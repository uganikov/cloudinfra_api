class Usagi
  def initialize(host)
    @connection = Bunny.new(host: host, vhost: '/')
    @connection.start
    at_exit { @connection.stop }
  end

  def enqueue(params)
    cloudinfra_queue.publish(JSON.generate(params), persistent:false)
  end

  def publish(params)
    cloudinfra_exchange.publish(JSON.generate(params))
  end

  def cloudinfra_queue
    @cloudinfra_queue ||= channel.queue("cloud_infra_api", durable: false)
  end

  def cloudinfra_exchange 
    @cloudinfra_exchange ||= channel.fanout("cloud_infra_api_pubsub")
  end

  def result_queue
    @cloudinfra_result ||= channel.queue("cloud_infra_api_result", durable: false)
  end

  def channel
    @chanel ||= @connection.create_channel
  end

  def start_consumer
    Thread.new do
      Rails.application.executor.wrap do
        result_queue .subscribe do |delivery_info, properties, payload|
          puts "Received #{payload}, message properties are #{properties.inspect}"
          params = JSON.parse(payload, {:symbolize_names => true})
          case params[:msg]
          when "status"
            instance_id = params[:instance_id]
            instance = Instance.find_by(public_uid: instance_id[2..-1])
            if params[:state].nil?
              instance.destroy()
            else
              instance.update(status: params[:state])
            end
          end
        end
      end
    end
  end
end
