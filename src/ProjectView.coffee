#_require Utility/Node.coffee

class ProjectView extends Node
	constructor:(@projectViewSelector, @riffViewSelector) ->
		super(@projectViewSelector, "Proj-View")
		@newRiff()
	newRiff:()=>
		riff = @addChild new RiffView(@riffViewSelector)
	openRiff:(name)=>
		@setActiveChild(name)
		$("#RiffView .header .title").text(name)
		$("#RiffView").removeClass("hidden")
		@getChild(name).openRiff()
	playRiff:(name)=>
		@getChild(name).playRiff()
	getActiveRiff:()=>
		@getActiveChild()
	closeRiff: =>
		@getActiveChild().closeRiff()
		$("#RiffView .header .title").text("")
		$("#RiffView").addClass("hidden")
		@setActiveChild(null)