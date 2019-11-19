class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :create, :update, :destroy]

  # GET /instances
  def index
    @instances = Instance.all

    render json: @instances
  end

  # GET /instances/1
  def show
    if @instance.nil?
      render status: 404, json: {status: 404, instance_id: params[:id]}
    else
      mq.publish({cmd: "show", instance_id: "i-#{@instance.public_uid}"})
      render json: @instance
    end
  end

  # POST /instances
  def create
    @instance = Instance.new(instance_params)
    if @instance.save
      mq.enqueue({cmd: "create", instance_id: "i-#{@instance.public_uid}", ip: @instance.ip.to_s, identity_pub: current_user.identity_pub})
      render json: @instance, status: :created, location: @instance
    else
      render json: @instance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /instances/1
  def update
    if @instance.nil?
      render status: 404, json: {status: 404, instance_id: params[:id]}
    else
      status = instance_params[:status].to_i
      if status == 0
        mq.publish({cmd: "stop", instance_id: "i-#{@instance.public_uid}"})
      elsif status == 1
        mq.publish({cmd: "start", instance_id: "i-#{@instance.public_uid}"})
      end
      render json: @instance
    end
  end

  # DELETE /instances/1
  def destroy
    if @instance.nil?
      render status: 404, json: {status: 404, instance_id: params[:id]}
    else
      mq.publish({cmd: "destroy", instance_id: "i-#{@instance.public_uid}"})
      render json: {cmd: "destroy", instance_id: "i-#{@instance.public_uid}", status: "accepted"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      if(params[:id] && params[:id].start_with?("i-"))
        @instance = Instance.find_by(public_uid: params[:id][2..-1])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def instance_params
      params.require(:instance).permit(:public_uid)
      params.require(:instance).permit(:ip)
      params.require(:instance).permit(:status)
    end
end
