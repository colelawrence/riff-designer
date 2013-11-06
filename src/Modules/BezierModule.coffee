#_require ../RiffModule.coffee

class BezierModule extends RiffModule
	constructor: (prefix, options = {}) ->
		super(prefix, options)
		@path = null
		@Xaxis = null
		@tool = "Pencil"
		@tools = ["Pen", "Pencil"]
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
		@Xaxis.position.x = x
		intersections = @path.getIntersections(@Xaxis)
		if intersections.length is 0
			null
		else
			intersections[0].point.y
	initModule: =>
		@Xaxis = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]

		textItem = new @paper.PointText
			content: @name,
			point: new @paper.Point(20, 30),
			fillColor: 'black'

		@setEditingTool(@tool)