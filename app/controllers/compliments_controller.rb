class ComplimentsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:random, :slack]
  skip_before_filter :verify_authenticity_token, only: [:slack]

  # before_filter :authenticate_ip, only: :random

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

  def slack
    compliment_command = SlashCommand::Compliment.new(user_id: params[:user_id], text: params[:text])

    @compliment = Compliment.new(
      complimenter: compliment_command.complimenter,
      complimentee: compliment_command.complimentee,
      text: compliment_command.compliment
    )

    if @compliment.save
      render text: "Posted your compliment!"
    else
      render text: "Oops! Something went wrong :("
    end
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

  def authenticate_ip
    if !((request.env["HTTP_X_FORWARDED_FOR"].try(:split, ',').try(:last) || request.env["REMOTE_ADDR"]) == '66.194.34.250')
      redirect_to '/'
    end
  end

  def find_compliment
    current_user.compliments_given.find(params[:id])
  end

  def compliment_params
    params.require(:compliment).permit(:complimentee_id, :text, :private)
  end
end
