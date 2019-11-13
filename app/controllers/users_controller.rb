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
	system("ssh-keygen -t rsa -b 2048 -f "+name)
	system("scp -P 22 ~/.ssh/"+name".pub cloudinfra@10.0.0.2:~/.ssh/authorized_keys")
	system("scp -P 22 ~/.ssh/"+name".pub cloudinfra@10.0.0.3:~/.ssh/authorized_keys")
	system("scp -P 22 ~/.ssh/"+name".pub cloudinfra@10.0.0.4:~/.ssh/authorized_keys")
    else
      render json: { status: 400, reason: @user.errors.full_messages }, status: 400
    end
  end
end
