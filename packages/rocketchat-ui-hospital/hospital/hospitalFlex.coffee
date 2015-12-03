Template.hospitalFlex.events
	'mouseenter header': ->
		SideNav.overArrow()

	'mouseleave header': ->
		SideNav.leaveArrow()

	'click header': ->
		SideNav.closeFlex()

	'click .cancel-settings': ->
		SideNav.closeFlex()

	'click .hospital-link': ->
		menu.close()

# Template.hospitalFlex.helpers
# 	allowUserProfileChange: ->
# 		return RocketChat.settings.get("Accounts_AllowUserProfileChange")
# 	allowUserAvatarChange: ->
# 		return RocketChat.settings.get("Accounts_AllowUserAvatarChange")