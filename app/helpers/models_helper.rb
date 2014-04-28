module ModelsHelper

	def render_specs
		tmp = raw "Комплектации<ul>"
		spec_id = @specs[0].id
		spec_id = cookies[:last_spec] if !cookies[:last_spec].blank?
		
		@specs.each do |spec|
			cls = spec.id == spec_id ? ' class="selected"' : ''
			tmp += raw "<li#{cls}>#{spec.name}</li>"
		end

		tmp += raw "</ul>"
	end
	
end
