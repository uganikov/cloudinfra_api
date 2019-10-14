class UsersController < ApplicationController
  skip_before_action :authenticate!, only: [ :login, :create ]

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      render json: { status: 200, user: @user }
    else
      render json: { status: 401, reason: 'invalid login' }, status: 401
    end
  end

  def create
    @user = User.new(email: params[:email], password: params[:password], name: params[:name])

    if @user.save
      render json: { status: 200, user: @user }
    else
      render json: { status: 400, reason: @user.errors.full_messages }, status: 400
    end
  end
end
