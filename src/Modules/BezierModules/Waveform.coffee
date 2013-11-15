

class WaveformSynthesizer
	constructor:(@Controller) ->
		@prefix = "Waveform"

	getSynthData: (samples) =>
		@Controller.getData samples