Template.channels.helpers
	tRoomMembers: ->
		return t('Members_placeholder')

	isActive: ->
		return 'active' if ChatSubscription.findOne({ t: { $in: ['c']}, f: { $ne: true }, open: true, rid: Session.get('openedRoom') }, { fields: { _id: 1 } })?

	services: ->
		# distinct =
		# 	t: { $in: ['c']},
		# 	open: true
		# TODO: return distinct services from ChatRoom collection
		services = ChatSubscription.find().fetch()
		distinctServicesArray = _.uniq(services, false, (data) ->
			return data.service
			)
		distinctServiceValues = _.pluck(distinctServicesArray, 'service')
		
		servicesArray = [];
		for counter in [0..distinctServiceValues.length]
			servicesArray.push({service : distinctServiceValues[counter]})
			console.log('distinctServiceValues[counter]: ' + distinctServiceValues[counter])

		console.log('servicesArray: ' + JSON.stringify(servicesArray))
		console.log('distinctServiceValues.length: ' + distinctServiceValues.length)
		
		return servicesArray

		return [
				{service : 'nccu'},
				{service : 'trauma'},
				{service : 'acs'},
				{service : 'boneMarrowTransplants'},
				{service : 'med'},
				{service : 'heme'}
				]

	rooms: ->
		query =
			t: { $in: ['c']},
			# service: { $in: ['nccu']},
			open: true

		if !RocketChat.settings.get 'Disable_Favorite_Rooms'
			query.f = { $ne: true }

		if Meteor.user()?.settings?.preferences?.unreadRoomsMode
			query.alert =
				$ne: true

		return ChatSubscription.find query, { sort: 'service': 1, 'name': 1 }

Template.channels.events
	'click .add-room': (e, instance) ->
		if RocketChat.authz.hasAtLeastOnePermission('create-c')
			SideNav.setFlex "createChannelFlex"
			SideNav.openFlex()
		else
			e.preventDefault()

	'click .more-channels': ->
		SideNav.setFlex "listChannelsFlex"
		SideNav.openFlex()

# function getDistinctServices() {
# 	var data = rocketchat_room.find().fetch();
# 	var distinctData = _.uniq(data, false, function(d) {return d.class});
# 	return _.pluck(distinctData, "class");
# }		
