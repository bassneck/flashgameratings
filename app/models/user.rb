class User < ActiveRecord::Base
	has_many :games

	attr_accessible :username, :password, :password_confirmation, :remember_me

	authenticates_with_sorcery!
end
