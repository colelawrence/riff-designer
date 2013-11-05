#_require ../../Initiallizer.coffee

window.tool.Pencil =
name: "Pencil"
sprite: "pencil_png"
data: {}
init: ->
	@data.guide = new @paper.Path.Line
		from:[0, 0]
		to:[0, @paper.view.viewSize.height]
		strokeColor: 'yellow'
events:
	onMouseDown: (event) ->
		# If we produced a path before, deselect it:
		if (@path)
			@path.remove()
		# Create a new path and set its stroke color to black:
		@path = new @paper.Path
			segments: [event.point],
			strokeColor: 'black',
			# Select the path, so we can see its segmentpoints:
			fullySelected: true
	onMouseDrag: (event) ->
		# While the user drags the mouse, points are added to the path
		# at the position of the mouse:
		@path.add(event.point)
	onMouseUp:(event)->
		# When the mouse is released, simplify it:
		@path.simplify(10)
		# Select the path, so we can see its segments:
		@path.fullySelected = true
	onMouseMove: (event) ->
		@data.guide.position.x = event.point.x
		if @path?
			intersections = @data.guide.getIntersections(@path)
			for inter in intersections
				new @paper.Path.Circle({
					center: inter.point,
					radius: 5,
					fillColor: '#009dec'
				}).removeOnMove()