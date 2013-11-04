#_require ../RiffModule.coffee



class BezierModule extends RiffModule
	constructor: (prefix, options = {}) ->
		super(prefix, options)
		@path = null
		@Xaxis = null
		@mode = "pencil"
	editModes:
		"pencil":
			events: [
				"onMouseDown"
				"onMouseDrag"
				"onMouseUp"
			]
			eventHandler: (event) ->
				console.log event.type
				switch event.type
					when "mousedown"
						# If we produced a path before, deselect it:
						if (@path)
							@path.remove()
		
						# Create a new path and set its stroke color to black:
						@path = new @paper.Path
							segments: [event.point],
							strokeColor: 'black',
							# Select the path, so we can see its segment points:
							fullySelected: true
					when "mousedrag"
						# While the user drags the mouse, points are added to the path
						# at the position of the mouse:
						@path.add(event.point)
					when "mouseup"
						# When the mouse is released, simplify it:
						@path.simplify(10)
						# Select the path, so we can see its segments:
						@path.fullySelected = true
		"pen":
			events: [
				"onMouseDown"
				"onMouseDrag"
				"onMouseUp"
			]
			eventHandler: (event) ->
				console.log event.type
				switch event.type
					when "mousedown"
						console.log "Pen"
					when "mousedrag"
						console.log "Pen"
					when "mouseup"
						console.log "Pen"
						



	setEditingMode: (mode) =>
		console.log @editModes[mode]
		for name in @editModes[mode].events
			@paper.tool[name] = (event) =>
				 @editModes[mode].eventHandler.call @, event

	getPath:()=>
		@path

	getYOnPath: (x) =>
		@Xaxis.position.x = x
		intersections = @path.getIntersections(@Xaxis)
		if intersections.length is 0
			null
		else
			intersections[0].point.y	
	init: =>
		@paper.tool.riffmodule = @
		@Xaxis = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]
		guide = new @paper.Path.Line
			from:[0, 0]
			to:[0, @paper.view.viewSize.height]
			strokeColor: 'yellow'

		textItem = new @paper.PointText
			content: 'Click and drag to draw a line.',
			point: new @paper.Point(20, 30),
			fillColor: 'black'

		@setEditingMode("pencil")


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
			if @path?
				showIntersections guide, @path