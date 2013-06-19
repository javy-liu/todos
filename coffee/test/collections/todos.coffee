# 定义todos数据集合 测试
define [
	'collections/todos'
	]
	,(Todos)->
		module '测试Collections的Todos'
		,setup:()->
			@todos = Todos
			@todos.reset()
			@todos.localStorage = new Store 'test-todos2'
			@todos.add
				content:'list one'
			@todos.add
				content:'list two'
				done:true
			@todos.add
				content:'list three'
			@todos.add
				content:'list four'
			@todos.add
				content:'list five'
				done:true
			@todos.add
				content:'list six'
			@todos.add
				content:'list seven'
			@todos.add
				content:'list eight'
				done:true
			@todos.add
				content:'list nine'
				done:true

		test '测试Collections的done方法',()->
			
			equal 4,@todos.done().length,"todos集合done()方法正常"
			
		test '测试Collections的notDone方法',()->	
	
			equal 5,@todos.notDone().length,"todos集合notDone()方法正常"
			
		
				