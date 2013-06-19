# 定义todos 集合对象
define [
	'backbone'
	'models/todo'
	'backbone.localStorage'
	]
	,(Backbone,TodoModel,LocalStorage)->
		Todos = Backbone.Collection.extend
			# 集合中对象类型
			model:TodoModel
			# 集合储存方式
			localStorage:new Store 'todos'

			initialize:()->
			# 返回集合中done 是true的对象
			done:()->
				@filter (todo)->
					todo.get 'done'
			# 返回集合最中done 为false的方法
			notDone:()->
				# 返回@done()中没有的对象
				@without.apply @,@done()
			


		# 返回集合  如果想单例的话 new 对象返回	
		new Todos()