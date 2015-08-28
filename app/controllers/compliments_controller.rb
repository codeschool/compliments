class ComplimentsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :random

  http_basic_authenticate_with name: "internals", password: "heavy-awesome-croissant", only: :random

  def index
    @compliments = Compliment.public
  end

  def given
    @compliments = current_user.compliments_given
    render :index
  end

  def received
    @compliments = current_user.compliments_received
    render :index
  end

  def new
    @compliment = current_user.compliments_given.new
  end

  def create
    @compliment = current_user.compliments_given.new(compliment_params)

    if @compliment.save
      redirect_to compliments_path
    else
      render :new
    end
  end

  def show
    @compliment = Compliment.find(params[:id])
  end

  def random
    @compliment = Compliment.public.random

    render :show
  end

  def edit
    @compliment = find_compliment
  end

  def update
    @compliment = find_compliment

    if @compliment.update_attributes(compliment_params)
      redirect_to compliments_path
    else
      render :edit
    end
  end

  def destroy
    @compliment = find_compliment

    if @compliment.destroy
      redirect_to compliments_path
    else
      render :show
    end
  end

  private

  def find_compliment
    current_user.compliments_given.find(params[:id])
  end

  def compliment_params
    params.require(:compliment).permit(:complimentee_id, :text, :private)
  end
end
