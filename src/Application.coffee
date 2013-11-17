

class Application
	constructor:() ->
		@projectViewSelector = "#ProjectView>.container"
		@moduleListSelector = "#RiffView>.container"
		@project = new ProjectView(@projectViewSelector, @moduleListSelector)