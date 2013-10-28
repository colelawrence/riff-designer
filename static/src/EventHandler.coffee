class EventHandler
	constructor: (@project) ->

	openRiff:(name) =>
		modules = @project.getRiff(name).getModules()
		for module in modules
			$(@project.riffViewContainerSelector).append module.getTemplate()
	editLayer:(riffName, name) =>
		modules = @project.getRiff(riffName).getModule(name)
		for module in modules
			$(@project.riffViewContainerSelector).append module.getTemplate()