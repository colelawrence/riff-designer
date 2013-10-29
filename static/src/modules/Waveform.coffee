class Waveform extends Node
	constructor: ->
		super("", "Waveform")
	getTemplate: () =>
		ich.RiffModule moduleName:@name
	editModule: () =>
		@$().toggleClass "under-construction"