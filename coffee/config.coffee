require.config
	# 设置加载资源的后缀防止缓存 形例如：a.js?12345678998 的数字
	urlArgs: (new Date()).getTime() # 获取当前时间毫秒数
	baseUrl:"./"

	# 定义资源加载路径
	paths:
		'jquery':'components/jquery/jquery'
		'underscore':'components/underscore-amd/underscore'
		'backbone':'components/backbone-amd/backbone'
		'backbone.localStorage':'components/backbone.localStorage/backbone.localStorage'
		'text':'components/requirejs-text/text'
		'bootstrap':'components/bootstrap/docs/assets/js/bootstrap.min'
		'base64':'components/base64/base64'


	# 定义相关资源所需依赖 并导出接口对象
	shim:
		backbone:
			des:[
				'jquery'
				'underscore'
			]
			exports:'Backbone'
		underscore:
			exports:'_'
		bootstrap:
			des:[
				'jquery'
			]
			exports:'$.Bootstrap'
		base64:
			des:[
				'underscore'
			]
			exports:'Base64'