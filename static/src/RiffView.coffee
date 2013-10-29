class RiffView extends Node
	constructor:(@riffViewSelector) ->
		super(@riffViewSelector, "RiffViewOpen")
		@addChild new Waveform()
	getModules:(name)=>
		@getChildren(name)
	editModule:(name)=>
		@setActiveChild(name)
		@getChild(name).editModule()
	getActiveModule: =>
		@getActiveChild()
	openRiff: =>
		@closeRiff()
		for module in @getModules(name)
			$(@riffViewSelector).append module.getTemplate()
	closeRiff: =>
		$(@riffViewSelector).empty()
	getTemplate: () =>
		ich.RiffViewOpen riffName:@name