window.app = null
window.evt = null
window.modules = {}
window.tool = {}
$(document).on "ready", (e) ->
	for template in $(".ichTemplate")
		console.log template.id
		ich.addTemplate(template.id, template.innerHTML)
		template.remove()
	window.app = new Application()
	window.evt = new EventHandler(window.app)