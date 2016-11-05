class AddGreenlight < ActiveRecord::Migration
  def up
    portal = Portal.where(name: 'Steam Greenlight').first_or_initialize
    portal.short_name = 'Greenlight'
    portal.url = 'steamcommunity.com'
    portal.color = '618015'
    portal.pattern = '/sharedfiles/filedetails/\?id=.+'
    portal.save!
  end

  def down
    portal = Portal.where(name: 'Steam Greenlight').first
    portal.destroy
  end
end
