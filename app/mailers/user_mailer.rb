# -*- encoding : utf-8 -*-

class UserMailer < ActionMailer::Base
	def reset_password_email(user)
		@user = user
		@url  = "http://flashgameratings.ru/password_resets/#{user.reset_password_token}/edit"
		mail(:to => user.email,
			 :subject => "Восстановление пароля на FlashGameRatings.ru",
			 :from => "noreply@flashgameratings.ru")
	end
end