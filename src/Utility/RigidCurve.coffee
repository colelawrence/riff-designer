

class RigidCurve
	constructor: (view, points) ->
		# Slopes
		@m = []

		# Y-Intercepts
		@b = []

		@yScale = 255 / view.viewSize.height

		p1 = null
		p2 = null
		for point in points
			p1 = point
			# p1[0]: p1.x, p1[1]: p1.y
			# y1 - y2 = slope * (x1 - x2)
			# (y1 - y2) / (x1 - x2) = slope
			# y1 = [m * x1] - m * x2 + y2
			if p2?
				x1=p1[0]
				x2=p2[0]
				y1=p1[1]
				y2=p2[1]
				slope = @yScale * (y1 - y2) / (x1 - x2)
				@m.push slope
				@b.push -slope * x1 + @yScale * y1
			p2 = p1
	getMB:(x)=>
		iX = x & 1023
		m:@m[iX] / @yScale, b:@b[iX] / @yScale
	getY: (x) =>
		iX = x & 1023
		(@m[iX] * x + @b[iX])
	getData: (nsamples) =>
		dx = @m.length / nsamples
		data = []
		for x in [0 .. @m.length] by dx
			iX = x & 1023
			data.push @m[iX] * x + @b[iX]
		data