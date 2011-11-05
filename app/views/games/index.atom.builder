atom_feed do |feed|
	feed.title("FGR - новые игры")
	feed.updated(@games.first.updated_at)
	@games.each do |game|
		feed.entry(game) do |entry|
			entry.title(game.name)
			entry.content(render(game), :type => 'html')
			entry.author game.user.username
		end
	end
end