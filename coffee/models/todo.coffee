# 定义todo数据对象
define [
	'backbone'
	]
	,(Backbone)->
		Todo = Backbone.Model.extend
			defaults:
				content:'空的内容...' # 任务清单的内容
				done:false	# 是否选中
			initialize:()->
			# 置换选中状态
			toggle:()->
				@save done:not @get 'done'


