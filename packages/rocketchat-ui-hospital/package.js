Package.describe({
	name: 'rocketchat:ui-hospital',
	version: '0.1.0',
	// Brief, one-line summary of the package.
	summary: '',
	// URL to the Git repository containing the source code for this package.
	git: '',
	// By default, Meteor will default to using README.md for documentation.
	// To avoid submitting documentation, set this field to null.
	documentation: 'README.md'
});

Package.onUse(function(api) {
	api.versionsFrom('1.2.1');

	api.use([
		'ecmascript',
		'templating',
		'coffeescript',
		'underscore',
		'rocketchat:lib@0.0.1'
	]);

	api.addFiles('hospital/hospital.html', 'client');
	api.addFiles('hospital/hospitalFlex.html', 'client');
	// api.addFiles('hospital/hospitalSubscriptions.html', 'client');
	// api.addFiles('hospital/hospitalServices.html', 'client');
	// api.addFiles('hospital/hospitalPatients.html', 'client');

	api.addFiles('hospital/hospital.coffee', 'client');
	api.addFiles('hospital/hospitalFlex.coffee', 'client');
	// api.addFiles('hospital/hospitalSubscriptions.coffee', 'client');
	// api.addFiles('hospital/hospitalServices.coffee', 'client');
	// api.addFiles('hospital/hospitalPatients.coffee', 'client');

	// api.addAssets('styles/side-nav.less', 'client');
});