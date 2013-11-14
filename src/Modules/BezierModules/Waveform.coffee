#_require ../BezierModule.coffee

class Waveform extends BezierModule
	constructor: ->
		super("Waveform")
		@rigidCurve = null

	getRigidData: (samples) =>
		if not @rigidCurve?
			@changed()
		@rigidCurve.getData(samples)
	changed:()=>
		points = []
		for x in [0..@paper.view.viewSize.width]
			points.push [x, @getYOnPath(x)]
		@rigidCurve = new RigidCurve @paper.view, points

	getRiffData: (samples) =>
		@getRigidData samples
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