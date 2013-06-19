###
 * grunt-init-spa
 * https://gruntjs.com/
 *
 * Copyright (c) 2013 excalibur "刘真源", contributors
 * Licensed under the MIT license.
###
'use strict'
module.exports = (grunt)->

	# 全局设定 
	ASSETS_PATH = "assets"
	COFFEE_PATH = "coffee"
	LESS_PATH = "less"
	DIST_PATH = "dist"
	SRC_PATH = "src"
	COMPONENTS = "components"
	TEST_PATH = "test"

	# 二级设定
	## 发布路径设定
	DEV_PATH = "#{ DIST_PATH }/development"
	REL_PATH = "#{ DIST_PATH }/release"

	## javascript与css定义
	JS_PATH = "#{ SRC_PATH }"
	STYLES_PATH = "#{ SRC_PATH }/styles"
	


	# init project configuration
	grunt.initConfig
		# Metadata
		pkg:grunt.file.readJSON 'require.spa.json'
		banner:"/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - 
      			<%= grunt.template.today('yyyy-mm-dd') %>\n
      			<%= pkg.homepage ? '* ' + pkg.homepage + '\\n' : '' %>
      			* Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author.name %>;
      			Licensed <%= _.pluck(pkg.licenses, 'type').join(', ') %> */\n"

		# clean Task
		clean:
			# dist:[DIST_PATH]
			assets:["#{ASSETS_PATH}/!components/**"]
			dev:[
				"#{ASSETS_PATH}/*.*"
				"#{ASSETS_PATH}/collections/**"	
				"#{ASSETS_PATH}/models/**"	
				"#{ASSETS_PATH}/pages/**"	
				"#{ASSETS_PATH}/styles/**"	
				"#{ASSETS_PATH}/templates/**"	
				"#{ASSETS_PATH}/templates/**"	
			]

		copy:
			default:
				files:[
					cwd:"#{SRC_PATH}/"
					src:["**","!bower.json","!components/**"]
					dest:"#{ASSETS_PATH}/"
					expand: true
				]
			components:
				files:[
					cwd:"#{SRC_PATH}/"
					src:["components/**"]
					dest:"#{ASSETS_PATH}/"
					expand: true
				]
			dev:
				files:[
					cwd:"#{SRC_PATH}/"
					src:["*.htm*"]
					dest:"#{DEV_PATH}/"
					expand: true
				]
			rel:
				files:[
					cwd:"#{ASSETS_PATH}/"
					src:["templates/**/*.htm*","styles/**/*.css","font/**","img/**"]
					dest:"#{REL_PATH}/"
					expand: true
				]

		# concat:
			
		# less Task
		less:
			development:
				expand: true
				cwd: "#{LESS_PATH}"
				src: ["styles/**/*.less"]
				dest: "#{ASSETS_PATH}"
				ext: '.css'

		cssmin:
			
			dev:
				expand: true
				cwd: "#{ASSETS_PATH}/styles"
				src: ['**/*.css']
				dest: "#{DEV_PATH}/css"
				ext: '.min.css'

			# 自定义主要是为了css合一
			relase:
				files:
					"dist/dev/css/appliaction.css":[
						"#{ASSETS_PATH}/styles/index.css"
					]

		requirejs:
			# 主要是为了多页面
			compile: 
				options: 
                	appDir:"assets/"
                	dir:'dist/'
					baseUrl: "./"
					mainConfigFile: "assets/config.js"
					# include: ['pages/app']
					# insertRequire: ['main']
					modules:[
						
						name:"#{ASSETS_PATH}/pages/app"
					]
					logLevel: 0
					findNestedDependencies: true
					fileExclusionRegExp: /^\./
					inlineText: true
					# wrap: true
					# generateSourceMaps: true
					# preserveLicenseComments: false
					optimize: "uglify"
			# 单页面  为了把多个文件合在一起
			index_relase:
				options:
					name: "components/almond/almond"
					baseUrl: "#{ASSETS_PATH}/"
					mainConfigFile: "#{ASSETS_PATH}/config.js"
					include: ['pages/index']
					insertRequire: ['pages/index']
					wrap: true
					generateSourceMaps: true
					preserveLicenseComments: false
					optimize: "uglify2"
					out: "#{REL_PATH}/js/index.js"
			app_relase:
				options:
					name: "components/almond/almond"
					baseUrl: "#{ASSETS_PATH}/"
					mainConfigFile: "#{ASSETS_PATH}/config.js"
					include: ['pages/app']
					insertRequire: ['pages/app']
					wrap: true
					generateSourceMaps: true
					preserveLicenseComments: false
					optimize: "uglify2"
					out: "#{REL_PATH}/js/app.js"
					

		# coffeescript Task
		coffee:
			development: 
				options:
					bare: true
				expand: true		       
				cwd: "#{COFFEE_PATH}"
				src: [
					"**/*.coffee"
				]
				dest: "#{ASSETS_PATH}"
				ext: '.js'

			test:
				options:
					bare: true
				expand: true		       
				cwd: "test"
				src: [
					"**/*.coffee"
				]
				dest: "test"
				ext: '.js'

		# watch Task
		watch:
			default:
				files: [
					"#{LESS_PATH}/**"
					"#{COFFEE_PATH}/**"
					"#{SRC_PATH}/**"
					"!#{SRC_PATH}/components/**"
				]
				tasks: [
					"clean"
					'copy:default'
					"coffee"
					"less"
					]
			
		# connect Task
		connect:
			# custom define
			test:
				options:
					port:9001
					keepalive:true
					base:"#{ASSETS_PATH}"
			default:
				options:
					port:9000
					keepalive:true
					base:"#{ASSETS_PATH}"
			


				
		      
		  

	# These plugins provide necessary tasks
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-qunit'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-requirejs'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'

	
	# register default Task
	grunt.registerTask 'default', [
		'clean'
		'copy:default'
		'copy:components'
		'less'
		'coffee'
	]
	

	grunt.registerTask 'dev', [
		'default'
		'connect:default'
	]

	grunt.registerTask 'release', [
		'default'
		'requirejs:index_relase'
		'requirejs:app_relase'
		'copy:rel'
		
	]
