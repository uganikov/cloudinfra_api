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

  def channel
    @chanel ||= @connection.create_channel
  end
end
