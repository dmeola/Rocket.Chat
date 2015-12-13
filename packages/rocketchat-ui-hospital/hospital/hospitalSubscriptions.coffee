Template.hospitalSubscriptions.helpers

	subscriptions: ->
		# TODO: make this query work
		query = 
			'u._id': { $in: ['ooDfbHmD6rGqx5CvE']},
			open: true
		#query = 'u._id': { $in: [Meteor.userId()]}
		query =
			t: { $in: ['c']},
			open: true
		patients = ChatSubscription.find query, { sort: 'service': 1, 'name': 1 }
		console.log 'patients:', patients.fetch()

		if patients?
			return patients.fetch()
		else
			return 'no patients'

Template.hospitalSubscriptions.onCreated ->
	settingsTemplate = this.parentTemplate(3)
	settingsTemplate.child ?= []
	settingsTemplate.child.push this

Template.hospitalSubscriptions.onRendered ->
	Tracker.afterFlush ->
		SideNav.setFlex "hospitalFlex"
		SideNav.openFlex()

	$('#subscription-table').DataTable();