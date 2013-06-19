# 主视图 
define [
	'jquery'
	'backbone'
	'namespace'
	'text!templates/stats.html'
	'collections/todos'
	'views/todo'
	]
	,($,Backbone,gobal,statsTemplate,todos,TodoView)->

		AppView = Backbone.View.extend
			# 该el是已经产生的dom结点
			el:'#todoapp'
			statsTemplate:_.template statsTemplate

			events:
				'keypress #new-todo':		'createOnEnter' # 录入时候enter
				'click #clear-completed':	'clearDoned' # 点击清除
				'click #toggle-all':		'toggleAllComplete' #改变选择状态
			render:()->
	
				@$footer.html @statsTemplate
					remaining:todos.notDone().length
					completed:todos.done().length
				@$('#filters li a')
					.removeClass('selected')
					.filter('[href="#/' + (gobal.app.TodoFilter || '') + '"]')
					.addClass('selected')


				# 如果没有done 为 false的数据 就吧allCheckbox设为选中
				@$allCheckbox.checked = not todos.notDone().length			        
				@
			initialize:()->
				@$input = @$ '#new-todo'
				@$list = @$ '#todo-list'
				@$allCheckbox = @$('#toggle-all')[0]
				@$footer = @$ '#footer'

				# 监听集合中数据 如果有数据添加 调用addOne方法
				@listenTo todos, 'add', @addOne
				# 监听集合中数据 当重新设置时 调用addAll方法
				@listenTo todos, 'reset', @addAll
				# 监听集合中数据 当对象done属性改变时 调用filterOne方法
				@listenTo todos, 'change:done', @filterOne
				@listenTo todos, 'filter', @filterAll
				# 监听集合中数据 当任何改变时 调用render方法
				@listenTo todos, 'all', @render
				# 读取存储的数据
				todos.fetch()
			# 添加一个记录到视图
			addOne:(todo)->			
				todoView = new TodoView
					model: todo
				@$list.append todoView.render().el


			# 添加所有记录到视图
			addAll:()->
				# 清空list
				@$list.html ''
				# 依次调用添加
				todos.each @addOne, @
			# enter 录入数据
			createOnEnter:(e)->
				if e.which isnt gobal.app.ENTER_KEY or not @$input.val().trim() 
					return
				

				todos.create @newAttributes()
				@$input.val ''
			# 创建一个新数据对象 01
			newAttributes:()->
				content: @$input.val().trim()
				done: false
			# 转化全部list的选中状态 
			toggleAllComplete:()->
				done = @$allCheckbox.checked

				todos.each (todo)->
					todo.save 
						done:done
			# 改变一个todo视图的状态
			filterOne:(todo)->
				todo.trigger 'visible'
			# 改变一个todo全部视图的状态
			filterAll:()->

				todos.each @filterOne, @

		# 返回对外的该对象
		new AppView()