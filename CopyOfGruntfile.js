module.exports = function(grunt) {
	'use strict';

	var config = {
		replace: {
			version: {
				src: ['webapp/i18n/i18n.properties'],
				overwrite: true, // overwrite matched source files
				replacements: [{
					from: /appVersion=(.*)/g,
					to: function(sCurrentVersion) { // callback replacement

						var aParts = sCurrentVersion.split("=");
						grunt.log.writeln("Current version: " + aParts[1]);

						var aVersionParts = aParts[1].split(".");

						if (aVersionParts[2] >= 95) {
							aVersionParts[1] = Number(aVersionParts[1]) + 1;
							aVersionParts[2] = 0;
						} else {
							aVersionParts[2] = Number(aVersionParts[2]) + 5;
						}

						var sNewVersion = aVersionParts[0] + "." + aVersionParts[1] + "." + aVersionParts[2];
						sNewVersion = sNewVersion + "." + "<%= grunt.template.today('yyyy-mm-dd') %>"
						grunt.log.writeln("New Version: " + sNewVersion);
						return aParts[0] + "=" + sNewVersion;
					}
				}]
			}
		},
		uglify: {
			dist: {
				files: [{
					expand: true,
					src: ['dist/controller/**/*.js', '!dist/controller/**/*.min.js', '!dist/controller/**/*-dbg*.js'],
					dest: 'dist/controller',
					cwd: '.',
					rename: function(dst, src) {
						grunt.log.writeln("Uglify " + src);
						// To keep the source js files and make new files as `*.min.js`:
						// return dst + '/' + src.replace('.js', '.min.js');
						// Or to override to src:
						return src;
					}
				}, {
					expand: true,
					src: ['dist/model/**/*.js', '!dist/model/**/*.min.js', '!dist/model/**/*-dbg*.js'],
					dest: 'dist/model',
					cwd: '.',
					rename: function(dst, src) {
						grunt.log.writeln("Uglify " + src);
						// To keep the source js files and make new files as `*.min.js`:
						// return dst + '/' + src.replace('.js', '.min.js');
						// Or to override to src:
						return src;
					}
				}, {
					expand: true,
					src: ['dist/Component.js'],
					dest: 'dist',
					cwd: '.',
					rename: function(dst, src) {
						grunt.log.writeln("Uglify " + src);
						// To keep the source js files and make new files as `*.min.js`:
						// return dst + '/' + src.replace('.js', '.min.js');
						// Or to override to src:
						return src;
					}
				}]
			}
		},
		xmlmin: {
			dist: {
				options: {
					preserveComments: false
				},
				files: {
					'dist/view/App.view.xml': 'dist/view/App.view.xml',
					'dist/view/Login.view.xml': 'dist/view/Login.view.xml',
					'dist/view/NotFound.view.xml': 'dist/view/NotFound.view.xml',
					'dist/view/nav/Home.view.xml': 'dist/view/nav/Home.view.xml',
					'dist/view/nav/GoodsMovement.view.xml': 'dist/view/nav/GoodsMovement.view.xml',
					'dist/view/nav/StatusChange.view.xml': 'dist/view/nav/StatusChange.view.xml',
					'dist/view/action/fragments/StorageUnitInfoForm.fragment.xml': 'dist/view/action/fragments/StorageUnitInfoForm.fragment.xml',
					'dist/view/action/GoodsReceipt.view.xml': 'dist/view/action/GoodsReceipt.view.xml',
					'dist/view/action/GoodsIssue.view.xml': 'dist/view/action/GoodsIssue.view.xml',
					'dist/view/action/FinishOperation.view.xml': 'dist/view/action/FinishOperation.view.xml',
					'dist/view/action/InterruptOperation.view.xml': 'dist/view/action/InterruptOperation.view.xml',
					'dist/view/action/ResumeOperation.view.xml': 'dist/view/action/ResumeOperation.view.xml',
					'dist/view/action/Startperation.view.xml': 'dist/view/action/StartOperation.view.xml',
				}
			}
		},
		copy: {
			test: {
				files: [{
					"expand": true,
					"src": "test/**",
					"dest": "dist",
					"cwd": "webapp"
				}, {
					"expand": true,
					"src": "test.html",
					"dest": "dist",
					"cwd": "webapp"
				}]
			},
			irpt: {
				files: [{
					"expand": true,
					"src": "index.html",
					"dest": "dist",
					"cwd": "webapp",
					rename: function(dest, src) {
						return dest + "/" + src.replace('.html', '.irpt');
					}
				}]
			}
		}
	};

	grunt.loadNpmTasks('@sap/grunt-sapui5-bestpractice-build');
	grunt.file.write("GruntConfigInitial.log", JSON.stringify(grunt.config(), null, 2));
	//	grunt.file.write("GruntOptions.log", JSON.stringify(grunt.option(), null, 2));
	//	grunt.file.write("GruntOptionsFlags.log", JSON.stringify(grunt.option.flags(), null, 2));

	grunt.config.merge(config);

	grunt.loadNpmTasks('grunt-text-replace');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-xmlmin');

	grunt.registerTask('default', [
		'replace:version',
		'lint',
		'clean',
		'build',
		'copy:test',
		'copy:irpt',
		'uglify:dist',
		'xmlmin:dist'
	]);

	grunt.file.write("GruntConfigFinal.log", JSON.stringify(grunt.config(), null, 2));

};