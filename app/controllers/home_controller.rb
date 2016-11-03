class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :term]
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      render layout: 'home_application'
    end
  end

  def terms
  end

  def registration
    render layout: 'home_application'
  end

  def registration_update
    respond_to do |format|
      if current_user.update(user_params)
        sign_in(current_user, :bypass => true)
        format.html { redirect_to  users_detail_url, notice: 'User\'s information updated.' }
        format.json { render :show, status: :created, location:  users_detail_url }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def user_params
    hash_params = params.require(:user).permit(:birthdate, :password, :password_confirmation, :gender, :mobile_phone, :user_type, :security_question_id, :security_question_answer, :terms_of_service)
    hash_params[:birthdate] = Date.strptime(hash_params[:birthdate],"%m/%d/%Y") unless hash_params[:birthdate].nil? 
    return hash_params
  end
end
