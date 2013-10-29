#_require Utility/Node.coffee

class RiffModule extends Node
	constructor:(prefix)->
		super("", prefix)
		canvas = @$().find("canvas")[0]
		paper.setup(canvas)
		@init.call(paper)
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	editModule: () =>
		@$().toggleClass "under-construction"
		@activatePaper()