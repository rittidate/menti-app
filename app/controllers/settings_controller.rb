class SettingsController < ApplicationController
  before_action :set_categories, only: [:mentor]

  def index

  end

  def update
    if current_user.update(user_params)
      flash.now[:notice] = "Update Personal Data Success"
    else
      flash.now[:notice] = current_user.errors.full_messages.first
    end
    render 'index'
  end

  def password
  end

  def change_password
    if current_user.valid_password?(params['user']['old_password'])
      if current_user.update(params.require(:user).permit(:password, :password_confirmation))
        flash[:notice] = "Change Password Success, Please Login Again"
        redirect_to new_user_session_path
      else
        flash.now[:notice] = current_user.errors.full_messages.first
        render 'password'
      end
    else
      flash.now[:notice] = "Your password is wrong."
      render 'password'
    end
  end

  def payment
    @payments = current_user.payments
  end

  def add_payment
    @client_token = generate_client_token
  end

  def category
    @category = Category.where(parent_id: nil)
  end

  def mentor
    if Course.where(user: current_user).first.present?
      set_course
    else
      @course = Course.new
    end
    #else
      #@course = Course.where(user: current_user)
    #end
  end

  def mentor_detail
    params[:user][:category].each do |val|
      current_user.courses.where(categories_id: val[:id]).first_or_initialize.tap do |course|
        course.price = val[:price]
        course.save
      end
    end
    respond_to do |format|
      if current_user.update(mentor_detail_params)
        format.html { redirect_to settings_mentor_url, notice: 'Update Mentor Detail Success' }
        format.json { render :show, status: :ok, location: settings_mentor_url }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def mentor_create
    @course = Course.new(coures_params)

    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to settings_mentor_url, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: settings_mentor_url }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def mentor_update 
    set_course
    respond_to do |format|
      if @course.update(coures_params)
        format.html { redirect_to settings_mentor_url, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: settings_mentor_url }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_course
    @course = Course.where(user: current_user).first
  end

  def set_categories
    @categories = Category.where(parent_id: nil)
  end
  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :gender, :education, :birthdate, :avatar, :address, :city, :state, :zipcode, :mobile_phone, :country, :prefered_language, :user_type)
  end

  def coures_params
    params.require(:course).permit(:price)
  end

  def mentor_detail_params
    params.require(:user).permit(:about, :program, :terms)
  end
end
