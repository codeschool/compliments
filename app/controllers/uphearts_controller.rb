class UpheartsController < ApplicationController
  def create
    @upheart = find_compliment.uphearts.new(upheart_params)

    if @upheart.save
      render json: { upheart_count: find_compliment.upheart_count }, status: 200
    else
      render json: { errors: @upheart.errors.full_messages.to_sentence }, status: 500
    end
  end

  def destroy
    @upheart = find_upheart

    if @upheart && @upheart.destroy
      render json: { upheart_count: find_compliment.upheart_count }, status: 200
    else
      render json: { errors: "Unable to remove upheart. :(" }, status: 500
    end
  end

  private

  def find_compliment
    Compliment.find(params[:compliment_id])
  end

  def find_upheart
    find_compliment.uphearts.where(user_id: current_user.id).first
  end

  def upheart_params
    { user_id: current_user.id }
  end

end
