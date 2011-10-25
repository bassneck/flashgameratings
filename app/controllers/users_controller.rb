# -*- encoding : utf-8 -*-

class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
		Portal.all.each do |p|
			@user.user_portal_accounts.build(:portal => p)
		end
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
