#_require ../BezierModule.coffee

class Waveform extends BezierModule
	constructor: ->
		super("Waveform")
		@Xaxis = @paper
	getRiffData: (samples) =>
		little = @path.firstSegment.point.x
		big = @path.lastSegment.point.x
		range = big
		if little > big
			big = little
			little = range
			range = big
		range -= little
		i = 0
		data = []
		heightRatio = 255 / @paper.view.size.height
		for x in [little..big] by range / samples
			data[i] = @getYOnPath(x) * heightRatio
			i++
		data