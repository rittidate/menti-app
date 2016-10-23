class ResourcesController < ApplicationController
  def new
    @resource = Resource.new
    if params['search-res'].present?
      @res_default = Resource.search(params['search-res'].downcase)
    else
      @res_default = Resource.where(resource_type: 0)
    end
    
    @resources = Resource.where(resource_type: 1, user_id: member_users)
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

  def member_users
    course_user_relation = CoursesUserRelation.joins("LEFT JOIN courses ON courses.id = courses_user_relations.course_id").where("courses.user_id = ?", current_user)
    user_array = Array.new
    for cur in course_user_relation
      user_array << cur.user_id
    end

    user_array << current_user.id
  end
end