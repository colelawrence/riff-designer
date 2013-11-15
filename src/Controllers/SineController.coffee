#_require ../Utility/Value.coffee

class SineController
	constructor: ->
		@data.amplitude = new Value .5, 0, 1
		@data.interval = new Value 1, 0, null
		@data.offset = new Value 0, 0, 1
	eq = (x) ->
		interval * amplitude * Math.sin( x + offset*2*Math.PI )