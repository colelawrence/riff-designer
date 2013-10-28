class ProjectView extends Node
	constructor:(@projectViewSelector, @riffViewSelector) ->
		super("", "Proj-View")
		addChild new RiffView(@projectViewSelector, @riffViewSelector)