window.app = null
$(document).on "ready", (e) ->
	for template in $(".ichTemplate")
		console.log template.id
		ich.addTemplate(template.id, template.innerHTML)
	window.app = new Application()