Template.hospitalPatients.helpers
	patients: ->
		query =
			t: { $in: ['c']},
			open: true
		patients = ChatSubscription.find query, { sort: 'service': 1, 'name': 1 }
		console.log 'patients:', patients.fetch()

		if patients?
			return patients.fetch()
		else
			return 'no patients'

Template.hospitalPatients.onCreated ->
	settingsTemplate = this.parentTemplate(3)
	settingsTemplate.child ?= []
	settingsTemplate.child.push this

	@clearForm = ->
		@find('#language').value = localStorage.getItem('userLanguage')
		@find('#oldPassword').value = ''
		@find('#password').value = ''
		@find('#username').value = ''

	@changePassword = (oldPassword, newPassword, callback) ->
		instance = @
		if not oldPassword and not newPassword
			return callback()

		else if !!oldPassword ^ !!newPassword
			toastr.warning t('Old_and_new_password_required')

		else if newPassword and oldPassword
			if !RocketChat.settings.get("Accounts_AllowPasswordChange")
				toastr.error t('Password_Change_Disabled')
				instance.clearForm()
				return
			Accounts.changePassword oldPassword, newPassword, (error) ->
				if error
					toastr.error t('Incorrect_Password')
				else
					return callback()

	@save = ->
		instance = @

		oldPassword = _.trim($('#oldPassword').val())
		newPassword = _.trim($('#password').val())

		instance.changePassword oldPassword, newPassword, ->
			data = {}
			reload = false
			selectedLanguage = $('#language').val()

			if localStorage.getItem('userLanguage') isnt selectedLanguage
				localStorage.setItem 'userLanguage', selectedLanguage
				data.language = selectedLanguage
				reload = true

			if _.trim $('#realname').val()
				data.realname = _.trim $('#realname').val()

			if _.trim $('#username').val()
				if !RocketChat.settings.get("Accounts_AllowUsernameChange")
					toastr.error t('Username_Change_Disabled')
					instance.clearForm()
					return
				else
					data.username = _.trim $('#username').val()

			Meteor.call 'saveUserProfile', data, (error, results) ->
				if results
					toastr.success t('Profile_saved_successfully')
					instance.clearForm()
					if reload
						setTimeout ->
							Meteor._reload.reload()
						, 1000

				if error
					toastr.error error.reason

Template.hospitalPatients.onRendered ->
	Tracker.afterFlush ->
		# this should throw an error-template
		FlowRouter.go("home") if !RocketChat.settings.get("Accounts_AllowUserProfileChange")
		SideNav.setFlex "hospitalFlex"
		SideNav.openFlex()

		$('#patient-table').DataTable();

Template.hospitalPatients.events
	'click .submit button': (e, t) ->
		t.save()
