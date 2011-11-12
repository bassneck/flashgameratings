task :user => [:environment] do
	task :calculate_points do
		User.calculate_points
	end
end