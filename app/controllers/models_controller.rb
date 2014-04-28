class ModelsController < ApplicationController
def show
	@model = Model.find(params[:id])
	@specs = Specification.where(model_id: params[:id])
	@opts = Option.where(model_id: params[:id])
end

end
