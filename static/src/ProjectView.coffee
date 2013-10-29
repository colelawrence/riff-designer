class ProjectView extends Node
	constructor:(@projectViewSelector, @riffViewSelector) ->
		super(@projectViewSelector, "")
		@newRiff()
	newRiff:()=>
		riff = @addChild new RiffView(@riffViewSelector)
		riff.setActiveRiff
	openRiff:(name)=>
		@setActiveChild(name)
		@getChild(name).openRiff()
	getActiveRiff:()=>
		@getActiveChild()
	closeRiff: =>
		@getActiveChild().closeRiff()