#_require ../RiffModule.coffee



class BezierModule extends RiffModule
	constructor: (prefix, options = {}) ->
		super(prefix, options)
		@path = null
		@Xaxis = null
		@tool = "pencil"
		@_ = {}
	tools = 
		"pen":
			onMouseDown: (event) ->
				hitOptions =
					segments: true
					handles: true
					stroke: true
					fill: true
					tolerance: 5
					selected: true
				hitResult = @M.paper.project.hitTest(event.point, hitOptions)
				@M._.segment = @M._.path = @M._.handle = null;
				if (event.modifiers.shift)
					if (hitResult.type == 'segment')
						hitResult.segment.remove();
					return
				if (hitResult)
					@M._.path = hitResult.item
					if (hitResult.type == 'segment')
						@M._.segment = hitResult.segment
					else if (hitResult.type == 'stroke')
						location = hitResult.location
						@M._.segment = @M._.path.insert(location.index + 1, event.point)
						@M._.path.smooth()
					
					else if (hitResult.type == 'handle-in')
							@M._.handle = hitResult.segment.handleIn
					
					else if (hitResult.type == 'handle-out')
							@M._.handle = hitResult.segment.handleOut
					
				
				@M._.movePath = hitResult.type == 'fill'
				if (@M._.movePath) 
					@M.paper.project.activeLayer.addChild(hitResult.item) 
					@M._.path.fullySelected = true;
			onMouseDrag: (event) ->
				if (@M._.segment)
					@M._.segment.point = event.point; 
					@M._.path.smooth();
					if @M._.handle
							@M._.handle.x += event.delta.x
							@M._.handle.y += event.delta.y
			
				if (@M._.movePath) 
					@M._.path.position += event.delta; 
		"pencil":
			onMouseDown: (event) ->
				# If we produced a path before, deselect it:
				if (@M.path)
					@M.path.remove()
				console.log "Creating Wave with pencil"
	
				# Create a new path and set its stroke color to black:
				@M.path = new @M.paper.Path
					segments: [event.point],
					strokeColor: 'black',
					# Select the path, so we can see its segmentpoints:
					fullySelected: true
			onMouseDrag: (event) ->
				# While the user drags the mouse, points are added to the path
				# at the position of the mouse:
				@M.path.add(event.point)
			onMouseUp:(event)->
				# When the mouse is released, simplify it:
				@M.path.simplify(10)
				# Select the path, so we can see its segments:
				@M.path.fullySelected = true
				@M.setEditingTool "pen"

						



	setEditingTool: (toolName) =>
		# unset
		@paper.tool[name] = undefined for name, method of tools[@tool]
		# set
		@paper.tool[name] = tools[toolName][name] for name, method of tools[toolName]
		@tool = toolName

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

		# Setting M = this allows our tools to modify our curve
		@paper.tool.M = @
		@setEditingTool(@tool)


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