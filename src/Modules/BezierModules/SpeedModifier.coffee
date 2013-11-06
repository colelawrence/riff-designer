#_require ../BezierModule.coffee

class SpeedModifier extends BezierModule
	constructor:(@options = {})->
		@options.length ?= 1
		@options.lowerBounds ?= .1
		@options.upperBounds ?= 2
		@options.rate ?= 8000
		@options.hz ?= 80
		@heightRange = @options.upperBounds - @options.lowerBounds
		super "SpeedMod", @options
		window.gg = @

	heightToHz: (h) =>
			@options.hz * (((@paper.view.size.height - h) / @paper.view.size.height) * @heightRange + @options.lowerBounds)
	getStep: (x) =>
		result = {}
		result.step = @getYOnPath x
		if result.step?
			result.step = @heightToHz result.step
		else
			result.step = @options.hz
		# step = hz
		result.hz = result.step
		result.samples = @options.rate / result.hz
		result.step = @paper.view.size.width / @options.length / result.step
		result
	mod: (sound) =>
		console.log "Modding"
		data = []
		step = @getStep(0).step
		console.log i, step, @paper.view.size.width
		for i in [0..@paper.view.size.width] by step
			result = @getStep(i)
			console.log i, step, result.samples
			data = data.concat sound.getRiffData(result.samples)
			step = result.step
		console.log data.length
		data