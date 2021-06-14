class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:index, :update]
  def index
  end

  def create
    @profile = @current_user.create_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        flash[:error] = @profile.errors.full_messages
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(employee_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_profile
      @profile = @current_user.profile
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:employee).permit(:name, :title, :parent_id)
    end
end
