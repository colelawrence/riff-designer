#_require ../BezierModule.coffee

class Waveform extends BezierModule
	constructor: ->
		super("Waveform")
	getRiffData: (samples) ->
		window.gg = @path
		@getYOnPath()
