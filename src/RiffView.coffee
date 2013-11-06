#_require Utility/Node.coffee

#_require Modules/BezierModules/Drawing.coffee
#_require Modules/BezierModules/Waveform.coffee
#_require Modules/BezierModules/SpeedModifier.coffee

class RiffView extends Node
	constructor:(@riffViewSelector) ->
		super(@riffViewSelector, "RiffViewOpen")
		@options = {}
	init:()=>
		@options = {
			length: @$().find(".length").val()
			hz: @$().find(".hz").val()
			rate: @$().find(".rate").val()
		}
		@addChild new Waveform()
		@addChild new SpeedModifier(@options)
		@openRiff()
	getModules:()=>
		@getChildren()
	getModule:(name)=>
		@getChild name
	editModule:(name)=>
		@setActiveChild(name)
		@getChild(name).editModule()
	getActiveModule: =>
		@getActiveChild()
	openRiff: =>
		@closeRiff()
		for module in @getModules()
			module.$().show()
	playRiff: () =>
		@options.length= @$().find(".length").val()
		@options.hz= @$().find(".hz").val()
		@options.rate= @$().find(".rate").val()
		console.log @options
		waveform = null
		modifiers = []
		for module in @getModules()
			if module.getRiffData?
				waveform = module
			else
				modifiers.push module
		if waveform?
			data = null
			if modifiers.length isnt 0
				workingData = new Sound(waveform)
				for mod in modifiers
					workingData = mod.mod workingData
				data = workingData
			else
				data = waveform.getRiffData @options.rate
				if data?
					data_ = []
					for [1..@options.hz]
						data_.concat data
					data = []
					for [1..@options.length]
						data.concat data_
			if data?
				window.audio = new Audio()
				wave = new RIFFWAVE()
				wave.header.sampleRate = @options.rate
				wave.Make(data)
				window.audio.src = wave.dataURI
				window.audio.play()
			
	closeRiff: =>
		$(@riffViewSelector).children().hide()
	getTemplate: () =>
		ich.RiffViewOpen riffName:@name