class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :update, :destroy]

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
    connection = Fog::Compute.new(provider: 'libvirt',libvirt_uri: 'qemu+ssh://cloudinfra@10.0.0.2/system',libvirt_username: 'cloudinfra',libvirt_password: 'cloudinfra01')
    connection.volumes
    bootvm = connection.servers.find{|s| s.name == 'kvm_centos7'}
    bootvm.start

    if @instance.save
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
