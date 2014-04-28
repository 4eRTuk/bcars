module ApplicationHelper
	
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "Batman Cars"
		if page_title.empty?
			base_title
		else
			"#{base_title} - #{page_title}"
		end
	end
	
	def get_models(man_id)
		#models = Car.where(manufacturer_id: man_id).uniq.pluck(:model_id)
		Model.where(MANUFACTURER_ID: man_id).order(:name)
	end
	
	def get_top
		tmp = raw "Топ 10 самых продаваемых<ul>"
		
		OCI8.new('s160645', 'nwr508', 'test').exec('select * from TOP_CARS_BY_ORDERS where ROWNUM <= 10') do |r|
			tmp += raw "<li>#{r[0]} (#{number_to_human r[1]})</li>"
		end
		
		tmp += raw "</ul>"
	end
end
