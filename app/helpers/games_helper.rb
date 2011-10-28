module GamesHelper
	def request(request)
		link_to request.portal.short_name, request, :class => "label request", :style => "background-color:##{request.portal.color}", :target => "_blank"
	end
end
