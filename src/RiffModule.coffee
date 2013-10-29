#_require Utility/Node.coffee

window.stainedPaper = (canvas, func) ->
    paper.setup(canvas)
    func.call paper

class RiffModule extends Node
	constructor:(prefix)->
		super("", prefix)
		console.log @$().find("canvas")[0]
		stainedPaper @$().find("canvas")[0], window.modules[prefix]
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	editModule: () =>
		@$().toggleClass "under-construction"
		@activatePaper()
		
