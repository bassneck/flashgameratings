class UserPortalAccount < ActiveRecord::Base

  attr_accessible :username, :portal, :portal_id

  belongs_to :user
	belongs_to :portal
end