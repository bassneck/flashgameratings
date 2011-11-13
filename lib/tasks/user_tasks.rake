namespace :user do
	task :calculate_points => [:environment] do
		User.calculate_points
	end
end