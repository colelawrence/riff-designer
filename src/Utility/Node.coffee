class Node
	constructor:(@containerSelector, prefix)->
		@name = prefix + "-" + Math.floor(Math.random() * 0xFFFFFF).toString(16)
		@children = {}
		@activeChildName = null
	setActiveChild:(name)=>
		@activeChildName = name
	getActiveChild:()=>
		@children[@activeChildName]
	addChild: (child) =>
		@children[child.name] = child
		if not @activeChildName?
			@setActiveChild(child.name)
		if @containerSelector?
			$(@containerSelector).append child.getTemplate()
		child
	getChild: (name) =>
		@children[name]
	getChildren: () =>
		children = []
		for name, child of @children
			children.push child
		return children
	$:() =>
		$('#'+@name)