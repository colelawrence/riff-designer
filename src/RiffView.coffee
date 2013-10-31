#_require Utility/Node.coffee

#_require Modules/BezierModules/Drawing.coffee
#_require Modules/BezierModules/Waveform.coffee

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
	playRiff: (rate = 22000, seconds = 1, hz = 80) =>
		data = null
		for module in @getModules()
			if module.getRiffData?
				data = module.getRiffData(rate / hz)
		if data?
			data_ = []
			for [1..hz]
				data_.concat data
			data = []
			for [1..seconds]
				data.concat data_
		Riff data
			
	closeRiff: =>
		$(@riffViewSelector).children().hide()
	getTemplate: () =>
		ich.RiffViewOpen riffName:@name