#_require ../../Initiallizer.coffee

window.tool.Pen =
name: "PenTool"
data: {}
events:
	onMouseDown: (event) ->
		hitOptions =
			segments: true
			handles: true
			stroke: true
			fill: true
			tolerance: 5
			selected: true
		hitResult = @paper.project.hitTest(event.point, hitOptions)
		@data.segment = @data.path = @data.handle = null;
		if (event.modifiers.shift)
			if (hitResult.type == 'segment')
				hitResult.segment.remove();
			return
		if (hitResult)
			@data.path = hitResult.item
			if (hitResult.type == 'segment')
				@data.segment = hitResult.segment
			else if (hitResult.type == 'stroke')
				location = hitResult.location
				@data.segment = @data.path.insert(location.index + 1, event.point)
				@data.path.smooth()
			
			else if (hitResult.type == 'handle-in')
					@data.handle = hitResult.segment.handleIn
			
			else if (hitResult.type == 'handle-out')
					@data.handle = hitResult.segment.handleOut
			
		
		@data.movePath = hitResult.type == 'fill'
		if (@data.movePath) 
			@paper.project.activeLayer.addChild(hitResult.item) 
			@data.path.fullySelected = true;
	onMouseDrag: (event) ->
		if (@data.segment)
			@data.segment.point = event.point; 
			@data.path.smooth();
			if @data.handle
					@data.handle.x += event.delta.x
					@data.handle.y += event.delta.y
	
		if (@data.movePath) 
			@data.path.position += event.delta; 