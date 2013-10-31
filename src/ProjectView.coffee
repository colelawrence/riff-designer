#_require Utility/Node.coffee

class ProjectView extends Node
	constructor:(@projectViewSelector, @riffViewSelector) ->
		super(@projectViewSelector, "Proj-View")
		@newRiff()
	newRiff:()=>
		riff = @addChild new RiffView(@riffViewSelector)
	openRiff:(name)=>
		@setActiveChild(name)
		@getChild(name).openRiff()
	playRiff:(name)=>
		@getChild(name).playRiff()
	getActiveRiff:()=>
		@getActiveChild()
	closeRiff: =>
		@getActiveChild().closeRiff()
		@setActiveChild(null)