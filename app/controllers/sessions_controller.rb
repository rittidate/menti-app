class SessionsController < Devise::SessionsController
  layout :layout_by_resource
  
  def new
    super
  end

  def create
    super
  end

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == "new"
      "home_application"
    else
      "application"
    end
  end

end
