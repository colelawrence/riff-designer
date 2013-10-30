#_require Utility/Node.coffee

#_require Modules/Drawing.coffee
#_require Modules/Waveform.coffee

class RiffView extends Node
	constructor:(@riffViewSelector) ->
		super(@riffViewSelector, "RiffViewOpen")
		@addChild new Waveform()
		@addChild new Drawing()
		@openRiff()
	getModules:()=>
		@getChildren()
	editModule:(name)=>
		@setActiveChild(name)
		@getChild(name).editModule()
	getActiveModule: =>
		@getActiveChild()
	openRiff: =>
		@closeRiff()
		for module in @getModules()
			module.$().show()
	closeRiff: =>
		$(@riffViewSelector).children().hide()
	getTemplate: () =>
		ich.RiffViewOpen riffName:@name