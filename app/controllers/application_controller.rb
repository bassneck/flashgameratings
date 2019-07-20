# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base

	protect_from_forgery

	around_filter { raise }

	protected

		def not_authenticated
			flash[:error] = 'Представьтесь, пожалуйста'
			redirect_to sign_in_path
		end

		def check_banned
			if current_user.banned?
				flash[:error] = 'Ваш аккаунт заблокирован. Если вы считаете, что это произошло по ошибке, свяжитесь с администратором.'
				redirect_to root_url
			end
		end
end
