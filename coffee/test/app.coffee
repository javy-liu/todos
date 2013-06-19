QUnit.config.autostart = false

require [
	'test/models/todo'
	'test/collections/todos'
	'test/views/todo'
	]
	,($)->
		QUnit.start()