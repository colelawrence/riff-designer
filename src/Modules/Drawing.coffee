#_require ../RiffModule.coffee

class Drawing extends RiffModule
	constructor: ->
		super("Drawing")
	init: =>
		path = undefined

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

			# Update the content of the text item to show how many
			# segments it has:
			textItem.content = 'Segment count: ' + path.segments.length
		# When the mouse is released, we simplify the path:
		@paper.tool.onMouseUp = (event) =>
			segmentCount = path.segments.length

			# When the mouse is released, simplify it:
			path.simplify(10)

			# Select the path, so we can see its segments:
			path.fullySelected = true

			newSegmentCount = path.segments.length
			difference = segmentCount - newSegmentCount
			percentage = 100 - Math.round(newSegmentCount / segmentCount * 100)
			textItem.content = difference + ' of the ' + segmentCount + ' segments were removed. Saving ' + percentage + '%'