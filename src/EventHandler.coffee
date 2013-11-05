

class EventHandler
	constructor: (@app) ->

	newRiff:()=>
		@app.project.newRiff()
	openRiff:(name) =>
		@app.project.openRiff(name)
	playRiff:(name) =>
		@app.project.playRiff(name)
	closeRiff:() =>
		@app.project.closeRiff()
	editModule:(name) =>
		@app.project.getActiveRiff().editModule(name)
	setModuleEditingTool:(name,editingTool) =>
		@app.project.getActiveRiff().getModule(name).setEditingTool(editingTool)