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
	
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end
	
	def get_spec_id
		if params[:spec_id].nil?
			spec_id = @model.specifications.first.id
		else
			spec_id = params[:spec_id]
		end
	end

	def admin?
		if !current_user.nil?
			current_user.acs_level > 0
		else
			false
		end
	end
	
	def split_rn(data)
		tmp = raw "<ul>"
		
		data.split('\r\n').each do |opt|
			tmp += raw "<li>#{opt}</li>"
		end
		
		tmp += raw '</ul>'
	end

	def to_rus(str)
		str.force_encoding("cp1251").encode("utf-8", undef: :replace)
	end
	
	def fill_content
		a = ['<h3>Тут типа новости</h3>', 'Для наполнения сайдбара']
		20.times { a.push(a[1]) }
		raw a.join("<br>")
	end
	
	def get_color(clr)
		if !clr || clr.blank?
			'#fff'
		else
			clr
		end
	end
end
