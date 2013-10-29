class EventHandler
	constructor: (@app) ->

	newRiff:()=>
		@app.project.newRiff()
	openRiff:(name) =>
		@app.project.openRiff(name)
	closeRiff:() =>
		@app.project.closeRiff()
	editModule:(name) =>
		@app.project.getActiveRiff().editModule(name)