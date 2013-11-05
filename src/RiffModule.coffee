#_require Utility/Node.coffee

class RiffModule extends Node
	constructor:(prefix, @options)->
		super("", prefix)
		@isInit = false
		@paper = new paper.PaperScope()
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	editModule: () =>
		@$().toggleClass "under-construction"
		if not @isInit
			canvas = @$().find("canvas")[0]
			@paper.setup(canvas)
			@isInit = true
			@init()
			if @tools?
				for tool in @tools
					@$().find(".tools").append ich.Button \
						onclick:"evt.setModuleEditingTool('#{@name}','#{tool}')",
						sprite:window.tool[tool].sprite