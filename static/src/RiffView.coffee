class RiffView extends Node
	constructor:(@projectViewSelector, @riffViewSelector) ->
		super(@projectViewSelector, "Riff")
		@addChild new Waveform(@riffViewSelector)
	getTemplate:()=>
		ich.RiffViewOpen name:@name