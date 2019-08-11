module RequestsHelper
	def yields_points?(request)
		if logged_in?
			policy = AwardPointsPolicy.build_from_env(current_user, request)
			policy.should_award_points?
		else
			true
		end
	end
end
