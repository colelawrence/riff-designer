window.app = null
$(document).on "ready", (e) ->
	for template in $(".ichTemplate")
		console.log template.id
		ich.addTemplate(template.id, template.innerHTML)
		template.remove()
	window.app = new Application()
	window.evt = new EventHandler(window.app)