class WaveformModule
	constructor: () ->
		@name = "Waveform-#{Math.floor(Math.random() * 0xFFFFFF).toString(16)}"
	getTemplate: () =>
		ich.LayerModule name:@name