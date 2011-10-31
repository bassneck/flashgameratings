# -*- encoding : utf-8 -*-

class PasswordResetsController < ApplicationController

	# request password reset.
	# you get here when the user entered his email in the reset password form and submitted it.
	def create
		@user = User.find_by_username(params[:username])

		# This line sends an email to the user with instructions on how to reset their password (a url with a random token)
		if @user

			unless @user.email.blank?
				@user.deliver_reset_password_instructions!
				flash[:success] = "На ваш email отправлена инструкция по восстановлению пароля."
			else
				flash[:error] = "Поле email не заполнено. Обратитесь к администратору"
			end
			redirect_to root_url
		else
			flash[:error] = "Пользователь с таким логином не найден"
			redirect_to sign_in_path
		end
	end

	# This is the reset password form.
	def edit
		@user = User.load_from_reset_password_token(params[:id])
		@token = params[:id]
		not_authenticated if !@user
	end
  
  # This action fires when the user has sent the reset password form.
	def update
		@token = params[:token] # needed to render the form again in case of error
		@user = User.load_from_reset_password_token(@token)
		not_authenticated if !@user
		# the next line makes the password confirmation validation work
		@user.password_confirmation = params[:user][:password_confirmation]
		# the next line clears the temporary token and updates the password
		if @user.change_password!(params[:user][:password])
			redirect_to(root_path, :notice => 'Password was successfully updated.')
		else
			render :action => "edit"
		end
	end

end