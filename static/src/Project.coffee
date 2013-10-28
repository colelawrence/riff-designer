class Project
	constructor:()->
		@containerSelector = "#ProjectView>.container"
		@layerViewContainerSelector = "#LayerView>.container"
		@riffs = {}
		@addRiff new RiffModule()
	addRiff: (riff) =>
		@riffs[riff.name] = riff
		$(@containerSelector).append riff.getTemplate()
	getRiff: (name) =>
		@riffs.name