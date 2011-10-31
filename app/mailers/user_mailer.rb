class UserMailer < ActionMailer::Base
	def reset_password_email(user)
		@user = user
		@url  = "http://flashgameratings.ru/password_resets/#{user.reset_password_token}/edit"
		mail(:to => user.email,
			 :subject => "Your password reset request",
			 :from => "noreply@flashgameratings.ru")
	end
end