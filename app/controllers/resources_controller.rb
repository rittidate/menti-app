class ResourcesController < ApplicationController
  def new
    @resource = Resource.new
    if params['search-res'].present?
      @res_default = Resource.search(params['search-res'].downcase)
    else
      @res_default = Resource.where(resource_type: 0)
    end
    
    @resources = Resource.where(resource_type: 1)
  end

  def admin
    @resource = Resource.new
    @res_default = Resource.where(resource_type: 0)
  end

  def upload
    msg = Resource.create(document_params) do |r|
      r.resource_type = :user
    end
    redirect_to request.referer
  end

  def upload_default
    msg = Resource.create(document_params) do |r|
      r.resource_type = :default
    end
    redirect_to request.referer
  end

private
  def document_params
    params.require(:resource).permit(:document, :resource_name, :user_id)
  end
end