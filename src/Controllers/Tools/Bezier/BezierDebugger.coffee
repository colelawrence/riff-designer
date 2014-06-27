#_require ../../../Initiallizer.coffee

window.tool.BezierDebugger =
name: "BezierDebugger"
sprite: "edit-points_png"
data: {}
init: ->
	@data.guide = new @paper.Path.Line
		from:[0, 0]
		to:[0, @paper.view.viewSize.height]
		strokeColor: 'yellow'
events:
	onMouseMove: (event) ->
		@data.guide.position.x = event.point.x
		if @path?
			intersections = @data.guide.getIntersections(@path)
			for inter in intersections
				mb = @rigidCurve.getMB(inter.point.x)
				new @paper.Path.Line({
					from: [inter.point.x+100,mb.m * (inter.point.x+100) + mb.b],
					to: [inter.point.x-100,mb.m * (inter.point.x-100) + mb.b],
					strokeColor: 'black'
				}).removeOnMove()
	onMouseDown: (event) ->
		if @path?
			intersections = @data.guide.getIntersections(@path)
			for inter in intersections
				mb = @rigidCurve.getMB(inter.point.x)
				console.log mb