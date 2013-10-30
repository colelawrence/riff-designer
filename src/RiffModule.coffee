#_require Utility/Node.coffee

class RiffModule extends Node
	constructor:(prefix)->
		super("", prefix)
		@isBeingEdited = false
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	editModule: () =>
		if not @isBeingEdited
			canvas = @$().find("canvas")[0]
			paper.setup(canvas)
			@init.call(paper)
			@isBeingEdited = true
		@$().toggleClass "under-construction"