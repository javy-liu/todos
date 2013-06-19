# 定义todo 视图
define [
	'backbone'
	'text!templates/todo.html'
	'namespace'
	]
	,(Backbone,TodoTpl,gobal)->
		TodoView = Backbone.View.extend
			# @$el依赖结点(该结点未添加在浏览器中)
			tagName:'li'
			# 该视图依赖的模板
			template:_.template TodoTpl
			initialize:()->
				console.log '44'
				# 监听数据模型 如果数据改变重新渲染视图
				@listenTo @model,'change',@render
				# 监听数据模型 如果该模型被销毁移除该视图
				@listenTo @model,'destroy',@remove
				# 监听对象的显示与隐藏转换
				@listenTo @model,'visible',@toggleVisible


			# 该视图的事件代理
			events:
				'click .toggle':'toggleDone' # 点击选择按钮  改变选择状态
				'dblclick label':'edit' 	# 双击内容进行编辑
				'click .destroy':	'clear' # 点击删除
				'keypress .edit':	'updateOnEnter' # 在录入框中按enter更新
				'blur .edit':		'close' # 离开碌碌框 更新数据
			# 视图渲染方法  该渲染是指在@$el中(也并未添加在浏览器中)	
			render:()->
				@$el.html @template @model.toJSON()
				@$el.toggleClass 'completed', this.model.get('done')
				@$input = @$ '.edit'
				# 必须返回这个对象 以方便吧该结点添加在浏览器中 
				
				@
			# 置换该视图的隐藏遇显示
			toggleVisible:()->
				@$el.toggleClass 'hidden', @isHidden()
			# 根据属性判别是否隐藏
			isHidden:()->
				isDone = @model.get 'done'
				(not isDone and gobal.app.TodoFilter is 'completed') or (isDone and gobal.app.TodoFilter is 'active')
			# 改变该对象的选中状态
			toggleDone:()->
				@model.toggle()

			# 内容编辑，其实默认的时候有一个录入框了的，这时候我们让label隐藏，那个隐藏的input显示。
			edit:()->
				# 增加一个editing css类 标识正在编辑
				@$el.addClass 'editing'
				# 让录入框获得焦点
				@$input.focus()
			# 删除该模型数据 与视图	
			clear:()->
				@model.destroy()
			# 当按下enter是的操作
			updateOnEnter:(e)->
				# enter 全局定义 为了以后方便修改
				if e.keyCode is gobal.app.ENTER_KEY
					@close()
			# 录入框关闭进行的操作
			close:()->
				# 获取输入的数据
				value = @$input.val().trim()
				# 如果值不为空 那么为数据模型保存值，否则(就是值为空)进行删除记录
				if value
					@model.save content:value
				else
					@clear()
				# 清除css 标识的编辑状态
				@$el.removeClass 'editing'



				



				