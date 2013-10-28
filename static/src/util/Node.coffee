class Node
	constructor:(@containerSelector, @prefix)->
		@name = @prefix + "-" + Math.floor(Math.random() * 0xFFFFFF).toString(16)
		@children = {}
	addChild: (child) =>
		@children[child.name] = child
		if @containerSelector?
			$(@containerSelector).append child.getTemplate()
	getChild: (name) =>
		@children[name]
	getChildren: () =>
		children = []
		for name, child of @children
			children.push child