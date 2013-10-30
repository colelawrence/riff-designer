#_require ../RiffModule.coffee

class Waveform extends RiffModule
	constructor: ->
		super("Waveform")
	init: =>
		path = new @paper.Path()
		# Give the stroke a color
		path.strokeColor = 'black'
		start = new @paper.Point(100, 100)
		# Move to start and draw a line from there
		path.moveTo(start)
		# Note that the plus operator on Point objects does not work
		# in JavaScript. Instead, we need to call the add() function:
		path.lineTo start.add([ 200, -50 ])
		# Draw the view now:
		@paper.view.draw()
		
		rect = new @paper.Path.Rectangle([100, 50], [10, 100])
		rect.strokeColor = 'black'
		@paper.view.onFrame = (event) ->
			# On each frame, rotate the path by 3 degrees:
			rect.rotate(3)