

class BezierController
	constructor: ->
		@data.rigidCurve = null
		@path = null
		@Xaxis = null
		@tool = "Pencil"
		@tools = ["Pen", "Pencil", "BezierDebugger"]

	eq=(x)->
		rigidCurve.getY x

	changed:()=>
		points = []
		for x in [0..@paper.view.viewSize.width]
			points.push [x, @getYOnPath(x)]
		@data.rigidCurve = new RigidCurve @paper.view, points

	setEditingTool: (toolName) =>
		console.log @name, toolName
		# unset
		@paper.tool[name] = undefined for name, method of window.tool[@tool].events
		# set
		for name, method of window.tool[toolName].events
			@paper.tool[name] = new Methodder method, @
		window.tool[toolName].init.call @ if window.tool[toolName].init?
		@tool = toolName

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
	initModule: =>
		@Xaxis = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]

		textItem = new @paper.PointText
			content: @name,
			point: new @paper.Point(20, 30),
			fillColor: 'black'

		@setEditingTool(@tool)