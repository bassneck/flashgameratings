module GamesHelper
	def orders_chart_series(votes)
		votes_by_day = 	group("date(created_at)").
						select("created_at, count")
		(votes_by_day.first.created_at.to_date..votes_by_day.last.created_at.to_date).map do |date|
			vote = votes_by_day.detect { |order| order.purchased_at.to_date == date }
			vote && vote.total_price.to_f || 0
		end.inspect
	end

end
