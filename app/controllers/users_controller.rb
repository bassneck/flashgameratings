# -*- encoding : utf-8 -*-

class UsersController < ApplicationController

	before_filter :require_login, :except => [:show, :new, :create]

	def show
		@user = User.find_by_username(params[:id])
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
			flash[:success] = "Добро пожаловать на FGR, #{@user.username}"
			redirect_to root_url
		else
			flash.now[:error] = "Произошла ошибка..."
			render :new
		end
	end

	def edit
		@user = User.find_by_username(params[:id])
	end

	def update
		@user = User.find_by_username(params[:id])

		if @user.update_attributes(params[:user])
			flash[:success] = 'Профиль обновлен'
			redirect_to root_url
		else
			render :action => "edit"
		end
	end
end
