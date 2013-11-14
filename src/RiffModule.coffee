#_require Utility/Node.coffee

class RiffModule extends Node
	constructor:(prefix, @options)->
		super("", prefix)
		@paper = new paper.PaperScope()
		@data = {}
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	init: () =>
		canvas = @$().find("canvas")[0]
		@paper.setup(canvas)
		console.log(canvas)
		if @tools?
			for tool in @tools
				@$().find(".tools").append ich.Button \
					onclick:"evt.setModuleEditingTool('#{@name}','#{tool}')",
					sprite:window.tool[tool].sprite
		@initModule()
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