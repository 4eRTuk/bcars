module SpecificationsHelper
def get_spec_id
	if !cookies[:last_spec].blank?
		cookies[:last_spec]
	else
		@specs[0].id
	end
end
end
