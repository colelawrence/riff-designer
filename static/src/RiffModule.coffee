class RiffModule
	constructor: () ->
		@name = "Riff-#{Math.floor(Math.random() * 0xFFFFFF).toString(16)}"
		
		@modules = []
		@modules.push new WaveformModule()
	getTemplate: () =>
		ich.RiffModule name:@name
	getModules: () =>
		@modules