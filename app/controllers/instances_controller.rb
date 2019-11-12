class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :create, :update, :destroy]

  def enqueue(queue, params)
    connection = Bunny.new(host: '10.0.0.2', vhost: '/', user: 'cloudinfra', password: 'cloudinfra')
    connection.start
    channel = connection.create_channel
    queue = channel.queue(queue, durable: false)
    queue.publish(JSON.generate(params), persistent:false)
    channel.close
    connection.close
  end

  # GET /instances
  def index
    @instances = Instance.all

    render json: @instances
  end

  # GET /instances/1
  def show
    render json: @instance
  end

  # POST /instances
  def create
    @instance = Instance.new(instance_params)
    if @instance.save
      enqueue('pleaseCreate', {instance_id: "i-#{@instance.public_uid}"})
      render json: @instance, status: :created, location: @instance
    else
      render json: @instance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /instances/1
  def update
    if @instance.update(instance_params)
      render json: @instance
    else
      render json: @instance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /instances/1
  def destroy
    @instance.destroy

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
    end
end
