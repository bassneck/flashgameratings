# -*- encoding : utf-8 -*-

class SessionsController < ApplicationController

	before_filter :require_login, :except => [:new, :create]

	def new
		@user = User.new
	end

	def create
		user = login(params[:username], params[:password], params[:remember_me])
		if user
			redirect_back_or_to root_url
			flash.now[:success] = "Oh hai!"
		else
			flash.now[:error] = "Вы ввели неверный логин или пароль"
			render :new
		end

	end

	def destroy
		logout
		redirect_to root_url
	end
end