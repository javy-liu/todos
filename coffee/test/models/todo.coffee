# 定义测试 todo model 模块
require [
	'models/todo'
	]
	,(TodoModel)->
		module '测试Models的Todo'
		,setup:()->
			@todoModel = new TodoModel()

		test '测试Model的content',()->
			@todoModel.set content:'test-content'
			
			equal 'test-content',@todoModel.get('content'),'todo的content属性设置获取正常'
		test '测试Model的done',()->			
			@todoModel.set done:true
			ok @todoModel.get('done'),'todo的done属性设置获取正常'

		test '测试Model的toggle方法',()->
			@todoModel.localStorage = new Store 'test-todos'

			@todoModel.toggle()
			ok @todoModel.get('done'),'todo的toggle()方法正常'
			@todoModel.destroy()

		

