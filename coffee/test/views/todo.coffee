# 定义todos数据集合 测试
define [
	'jquery'
	'models/todo'
	'views/todo'
	]
	,($,TodoModel,TodoView)->
		module '测试Views的TodoViews'
		,setup:()->
			@todoModel = new TodoModel
				content:"test one"
			@todoView = new TodoView
				model:@todoModel
			
		test 'views的render方法',()->
			ok true,@todoView.render().el

		test 'views的toggleVisible方法',()->

			ok true,@todoView.toggleVisible().el
			
		# test 'views的isHidden方法',()->
			
		# 	ok @todoView.isHidden(),'isHidden方法正常'
			
		# test 'views的toggleDone方法',()->
		# 	@todoView.toggleDone()
		# 	
		# 	ok @todoView.model.get('done'),'toggleDone方法正常'
			
		# test 'views的edit方法',()->
		# 	@todoView.edit()
		# 	ok true,'测试edit'

		test 'views的clear方法',()->
			@todoView.clear()
			ok true,'测试clear'

		test 'views的updateOnEnter方法',()->
			@todoView.updateOnEnter($('#new-todo'))
			ok true,'测试updateOnEnter'

		# test 'views的close方法',()->
		# 	@todoView.close()
		# 	ok true,'测试close方法'

			
			
			
		
		
				