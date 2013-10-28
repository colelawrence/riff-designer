class Waveform extends RiffModule
	constructor: (@riffViewSelector) ->
		super(@riffViewSelector, "Waveform")
	getTemplate: () =>
		ich.RiffModule name:@name