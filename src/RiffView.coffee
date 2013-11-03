#_require Utility/Node.coffee

#_require Modules/BezierModules/Drawing.coffee
#_require Modules/BezierModules/Waveform.coffee
#_require Modules/BezierModules/SpeedModifier.coffee

class RiffView extends Node
	constructor:(@riffViewSelector) ->
		super(@riffViewSelector, "RiffViewOpen")
		@addChild new Waveform()
		@addChild new SpeedModifier({length:2, sampleRate:8000})
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
	playRiff: (rate = 8000, seconds = 1, hz = 200) =>
		waveform = null
		modifiers = []
		for module in @getModules()
			if module.getRiffData?
				waveform = module
			else
				if module.isInit
					modifiers.push module
		if waveform?
			data = null
			if modifiers.length isnt 0
				workingData = new Sound(waveform)
				for mod in modifiers
					workingData = mod.mod workingData
				data = workingData
			else
				data = waveform.getRiffData rate
				if data?
					data_ = []
					for [1..hz]
						data_.concat data
					data = []
					for [1..seconds]
						data.concat data_
			if data?
				window.audio = new Audio()
				wave = new RIFFWAVE()
				wave.header.sampleRate = rate
				wave.Make(data)
				window.audio.src = wave.dataURI
				window.audio.play()
			
	closeRiff: =>
		$(@riffViewSelector).children().hide()
	getTemplate: () =>
		ich.RiffViewOpen riffName:@name