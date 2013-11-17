#_require Utility/Node.coffee

# AKA a "Riff"
class ModuleManager extends Node
	constructor:(moduleListSelector) ->
		super("ModuleManagerOpen", moduleListSelector)
		@moduleOrder = []
		@prerender = null
		@options = {}
	init:()=>
		@options = {
			length: @$().find(".length").val()
			hz: @$().find(".hz").val()
			rate: @$().find(".rate").val()
		}
		@addChild new Module("Waveform", "BezierController", @)
		@openRiff()
	changed: =>
		# if Prerendering enabled
		# use new Worker('<File to do calculations>.js')
		# see article: http://www.html5rocks.com/en/tutorials/workers/basics/
	getModules:()=>	mods=[]; mods.push @getModule mN for mN in @moduleOrder; mods
	getModule:(name)=> @getChild name
	getActiveModule: =>	@getActiveChild()
	editModule:(name)=>
		@setActiveChild(name)
		@getChild(name).editModule()
	openRiff: =>
		@closeRiff()
		for module in @getModules()
			module.$().show()
	playRiff: () =>
		start = (new Date()).getTime()
		@options.length= @$().find(".length").val()
		@options.hz= @$().find(".hz").val()
		@options.rate= @$().find(".rate").val()
		console.log @options
		modules = @getModules()
		data = null
		if modules.length isnt 0
			workingData = new Sound(origin)
			for mod in modules
				workingData = mod.mod workingData
			data = workingData
		else
			data = origin.getRiffData @options.rate
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
			console.log ((new Date()).getTime()-start)/1000
			window.audio.play()
			
	closeRiff: =>
		$(@riffViewSelector).children().hide()
	getTemplate: () =>
		ich.RiffViewOpen id:@name