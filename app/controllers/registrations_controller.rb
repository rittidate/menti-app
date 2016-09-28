class RegistrationsController < Devise::RegistrationsController
  layout :layout_by_resource
  
  def new
    super
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def create
    build_resource(sign_up_params)
    
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)

        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def detail
    @category = Category.where(parent_id: nil)
  end

  def detail_update
    if current_user.update(detail_params)
      flash.now[:notice] = "Update Personal Data Success"
    else
      flash.now[:notice] = current_user.errors.full_messages.first
    end
    redirect_to dashboard_path
  end

  protected
  def sign_up_params
    hash_params = params.require(:user).permit(:username, :birthdate, :email, :password, :password_confirmation, :gender, :mobile_phone, :user_type, :security_question_id, :security_question_answer, :terms_of_service)
    hash_params[:birthdate] = Date.strptime(hash_params[:birthdate],"%m/%d/%Y") unless hash_params[:birthdate].nil? 
    return hash_params
  end

  def detail_params
    hash_params = params.require(:user).permit(:first_name, :middle_name, :last_name, :education, :country, :prefered_language)
    return hash_params
  end

  def after_sign_up_path_for(resource)
    users_detail_path
  end

  def layout_by_resource
    "home_application"
  end
end