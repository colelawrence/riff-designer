

class BezierController
	@tools = ["Pen", "Pencil", "BezierDebugger"]
	@eq = (x) ->
		rigidCurve.getY x
	constructor: (@paper, @manager) ->
		@data = {}
		@data.rigidCurve = null
		@path = null
		@currentTool = "Pencil"

		@Xaxis = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]

		textItem = new @paper.PointText
			content: @name,
			point: new @paper.Point(20, 30),
			fillColor: 'black'

		@setTool(@currentTool)


	changed:()=>
		points = []
		for x in [0..@paper.view.viewSize.width]
			points.push [x, @getYOnPath(x)]
		@data.rigidCurve = new RigidCurve @paper.view, points
		@manager.changed()

	# The process of setting the tool we are using requires changing the paperScope's event functions
	#	Example: @paper.tool.onMouseDown = <function from tool>
	setTool: (toolName) =>
		# unapply functions of previous tool
		@paper.tool[eventName] = undefined for eventName, eventHandler of window.tool[@currentTool].events
		# apply functions of new tool
		for eventName, eventHandler of window.tool[toolName].events
			@paper.tool[eventName] = new Methodder eventHandler, @
		# initiallize tool if tool needs initiallization
		window.tool[toolName].init.call @ if window.tool[toolName].init?
		@currentTool = toolName

	getPath:()=>
		@path

	getYOnPath: (x) =>
		if(@Xaxis is null)
			@Xaxis = new @paper.Path.Line from:[0,0], to:[0,@paper.view.viewSize.height]
		@Xaxis.position.x = x
		intersections = @path.getIntersections(@Xaxis)
		if intersections.length isnt 0
			return intersections[0].point.y
		else
			return null