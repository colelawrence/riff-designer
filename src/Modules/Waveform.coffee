#_require ../RiffModule.coffee

class Waveform extends RiffModule
	constructor: ->
		super("Waveform")
	init: =>
		path = undefined
		guide = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]
			strokeColor: 'yellow'

		textItem = new @paper.PointText
			content: 'Click and drag to draw a line.',
			point: new @paper.Point(20, 30),
			fillColor: 'black'
		
		@paper.tool.onMouseDown = (event) =>

			# If we produced a path before, deselect it:
			if (path)
				path.selected = false

			# Create a new path and set its stroke color to black:
			path = new @paper.Path
				segments: [event.point],
				strokeColor: 'black',
				# Select the path, so we can see its segment points:
				fullySelected: true
		# While the user drags the mouse, points are added to the path
		# at the position of the mouse:
		@paper.tool.onMouseDrag = (event) =>
			path.add(event.point)
		# When the mouse is released, we simplify the path:
		@paper.tool.onMouseUp = (event) =>

			# When the mouse is released, simplify it:
			path.simplify(10)

			# Select the path, so we can see its segments:
			path.fullySelected = true
		showIntersections = (path1, path2) ->
			intersections = path1.getIntersections(path2)
			for inter in intersections
				new @paper.Path.Circle({
					center: inter.point,
					radius: 5,
					fillColor: '#009dec'
				}).removeOnMove()
		@paper.tool.onMouseMove = (event) =>
			guide.position.x = event.point.x
			for path in @paper.project.activeLayer.children
				showIntersections guide, path