#_require ProjectView.coffee

class Application
	constructor:() ->
		@projectViewSelector = "#ProjectView>.container"
		@riffViewSelector = "#RiffView>.container"
		@project = new ProjectView(@projectViewSelector, @riffViewSelector)
	