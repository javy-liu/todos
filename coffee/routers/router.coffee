# 定义router
define ['underscore','backbone','namespace','collections/todos'],(_,Backbone,gobal,todos)->
	Workspace = Backbone.Router.extend
		routes:
			'*filter': 'setFilter'
		# 根据uri参数 设置filter的属性
		setFilter:(param)->
			gobal.app.TodoFilter = param or ''
			todos.trigger 'filter'


	gobal.app.TodoRouter = new Workspace()