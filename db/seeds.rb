# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Portal.create([
			  { :name => "Kongregate", :short_name => "Kong", :url => "kongregate.com", :pattern => "/games/.*?/.+", :color => "C43C35"},
			  { :name => "NewGrounds", :short_name => "NG", :url => "newgrounds.com", :pattern => "/portal/view/.+", :color => "F89406"},
			  { :name => "ArmorGames", :short_name => "Armor", :url => "armorgames.com", :pattern => "/play/.+/.+", :color => "46A546"}
			  ])