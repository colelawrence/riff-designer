#_require Application.coffee
#_require EventHandler.coffee

window.app = null
window.modules = {}
$(document).on "ready", (e) =>
	for template in $(".ichTemplate")
		console.log template.id
		ich.addTemplate(template.id, template.innerHTML)
		template.remove()
	window.app = new Application()
	window.evt = new EventHandler(window.app)