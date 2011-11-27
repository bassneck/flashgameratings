module RequestsHelper
	def yields_points?(request)
		request.fresh? and (logged_in? and not current_user.voted_for?(request))
	end
end
