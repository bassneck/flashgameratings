module GamesHelper
	def request(request)
		link_to request.portal.short_name, "http://#{request}", :class => "label", :style => "background-color:##{request.portal.color}", :target => "_blank"
	end
end
