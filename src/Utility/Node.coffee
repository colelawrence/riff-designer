class Node
	constructor:(prefix, @containerSelector="")->
		# Assign the component's name/id
		@name = prefix + "-" + Math.floor(Math.random() * 0xFFFFFF).toString(16)
		@children = {}
		@activeChildName = null
	setActiveChild:(name = null)=>
		if @activeChildName?
			@getActiveChild().$().removeClass "active"
		if name?
			@activeChildName = name
			@getActiveChild().$().addClass "active"
		else
			@activeChildName = null
		@getActiveChild()
	getActiveChild:()=>
		if @activeChildName? then @children[@activeChildName] else null
	addChild: (child) =>
		@children[child.name] = child
		if @containerSelector?
			$(@containerSelector).append child.getTemplate()
		# setup() is called after the DOM piece is appended
		child.setup() if child.setup?
		@setActiveChild(child.name)
	getChild: (name) =>
		@children[name]
	getChildren: () =>
		children = []
		for name, child of @children
			children.push child
		return children
	$:() =>
		$('#'+@name)