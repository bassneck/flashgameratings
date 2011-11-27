module RequestsHelper
	def yields_points?(request)
		if logged_in?
			request.fresh? and not current_user.voted_for?(request)
		else
		    request.fresh?
		end
	end
end
