class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_user, only: [:show, :edit, :update, :destroy, :payment, :transaction]

  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to new_user_registration_path
    end
  end
  # GET /users/:id.:format
  def show
    @category = Category.where(parent_id: nil)
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
        redirect_to users_detail_path(@user), notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    else
      redirect_to users_path(@user)
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def payment
    if params.has_key?(:id) and params.has_key?(:course)
      @payments = current_user.payments
      @course = Course.find(params[:course])
    else
      redirect_to user_path(current_user)
    end
  end

  def transaction
    puts params
  end

  def wait

  end

private
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
