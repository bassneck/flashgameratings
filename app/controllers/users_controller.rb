# -*- encoding : utf-8 -*-

class UsersController < ApplicationController

	before_filter :require_login, except: [:show, :new, :create]

	def show
		@user = User.find_by_username!(params[:id])
	end

	def new
		@user = User.new
		@user.build_user_portal_accounts
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			login(@user.username, params[:user][:password])
			flash[:success] = "Добро пожаловать на FGR, #{@user.username}"
			redirect_to root_url
		else
      @user.build_user_portal_accounts
			flash.now[:error] = "Произошла ошибка..."
			render :new
		end
	end

	def edit
		@user = User.find_by_username(params[:id])

		if @user == current_user
      @user.build_user_portal_accounts
		else
			redirect_to edit_user_path(current_user)
		end
	end

	def update
		@user = current_user

		if @user.update_attributes(params[:user])
			flash[:success] = 'Профиль обновлен'
			redirect_to root_url
		else
      @user.build_user_portal_accounts
			flash.now[:error] = "Произошла ошибка..."
			render action: "edit"
		end
	end
end
