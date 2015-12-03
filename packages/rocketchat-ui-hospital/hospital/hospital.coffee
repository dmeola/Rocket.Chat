Template.hospital.helpers
	flexOpened: ->
		return 'opened' if RocketChat.TabBar.isFlexOpen()
	arrowPosition: ->
		console.log 'room.helpers arrowPosition' if window.rocketDebug
		return 'left' unless RocketChat.TabBar.isFlexOpen()

Template.hospital.onRendered ->
	Tracker.afterFlush ->
		SideNav.setFlex "hospitalFlex"
		SideNav.openFlex()
