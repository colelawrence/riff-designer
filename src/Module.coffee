#_require Utility/Node.coffee

class Module extends Node
	constructor: (modifierType, controllerType, @manager) ->
		super(modifierType)

		# if the modifierType or controllerType are not classes,
		#	catch and display error
		classUndefinedError=(problem)->
			console.log "window[#{problem}]() is not a correct type"
			return new Module("VolumeModifier", "BezierController")
		if window[modifierType]? then	@modifier = window[modifierType]
		else classUndefinedError(err)
		if window[controllerType]? then	@controller = window[controllerType]
		else classUndefinedError(err)

		# At this point:
		# @modifier and @controller are merely unconstructed classes
		# Neither piece can honestly do anything until setup() is called

	# Called by super after the template is appended
	setup: =>
		@paper = new paper.PaperScope()
		canvas = @$().find("canvas")[0]
		@paper.setup(canvas)
		console.log(canvas)
		if @tools?
			for tool in @tools
				@$().find(".tools").append ich.Button \
					onclick:"evt.setModuleEditingTool('#{@name}','#{tool}')",
					sprite:window.tool[tool].sprite
		# Controller uses @manager to call onchange()
		@controller = new @controller(@paper, @manager)
		@modifier = new @modifier()

	getTemplate: =>
		ich.RiffModule id:@name

	editModule: () =>
		@$().toggleClass("under-construction")
		resizer = ->
			oldViewSize = @paper.view.viewSize.clone()
			newViewSize = new @paper.Size @$().find("canvas").width(), @$().find("canvas").height()
			@paper.project.activeLayer.scale(
				newViewSize.width/oldViewSize.width,
				newViewSize.height/oldViewSize.height,
				new @paper.Point(0,0)
			)
			@paper.view.viewSize = newViewSize
			@paper.view.draw()
		setTimeout new Methodder(resizer,@) , 400