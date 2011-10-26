# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base

	protect_from_forgery

	protected

		def not_authenticated
			flash[:error] = "Представьтесь, пожалуйста"
			redirect_to sign_in_path
		end
end
