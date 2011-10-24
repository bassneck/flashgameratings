# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			login(@user.username, params[:user][:password])
			redirect_to root_url
			flash[:success] = "Добро пожаловать на FGR, #{@user.username}"
		else
			render :new
			flash.now[:error] = "В процессе регистрации произошли ошибки"
		end
	end

	def edit

	end

	def update

	end
end
