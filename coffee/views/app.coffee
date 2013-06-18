# 主视图 
define [
	'jquery'
	'backbone'
	'collections/blogs'
	'views/blog'
	'namespace'
	'models/blog'
	'views/header'
	'services/blog'
	]
	,($,Backbone,blogs,BlogView,gobal,BlogModel,headerView,blogData)->

		AppView = Backbone.View.extend
			# 该el是已经产生的dom结点
			el:'#container'
			# statsTemplate:_.template TplApp

			events:
				'keypress #search':		'searchOnEnter'
				'click .navbar-form button':'search'
				'click #toggle-all':		'toggleAllComplete'
			render:()->
	
				
							        
				@
			initialize:()->
				@$input = @$('#search')
				@$blogsView = @$ '.blogs'
				# 处理初始化 
				@listenTo blogs,'add',@addOne

	
				

				# 获取blogs
				blogData.getBlogs()
			addOne:(blog)->
				view = new BlogView model:blog
				@$blogsView.append view.render().el

			getBlog:()->


		# 返回对外的该对象结构
		new AppView()