#_require ../RiffModule.coffee

class Waveform extends RiffModule
	constructor: ->
		super("Waveform")
	init = ()->
		path = new @Path()
		# Give the stroke a color
		path.strokeColor = 'black'
		start = new @Point(100, 100)
		# Move to start and draw a line from there
		path.moveTo(start)
		# Note that the plus operator on Point objects does not work
		# in JavaScript. Instead, we need to call the add() function:
		path.lineTo start.add([ 200, -50 ])
		# Draw the view now:
		@view.draw()
		
		rect = new @Path.Rectangle([100, 50], [10, 100])
		rect.strokeColor = 'black'
		@view.onFrame = (event) ->
			# On each frame, rotate the path by 3 degrees:
			rect.rotate(3)
