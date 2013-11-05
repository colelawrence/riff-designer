

class Methodder
	constructor: (method, scope) ->
		return (args)->
			method.call(scope, args)