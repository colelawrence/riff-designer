class Application
	constructor:() ->
		@projectViewSelector = "#ProjectView>.container"
		@riffViewSelector = "#RiffView>.container"
		@projects = []
	newProject:()=>
		@projects.push \
			new ProjectView(@projectViewSelector, @riffViewSelector)