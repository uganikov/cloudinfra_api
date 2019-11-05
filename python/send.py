import pika

credentials = pika.PlainCredentials('cloudinfra', 'cloudinfra01')
parameters = pika.ConnectionParameters('10.0.0.2', 5672,'/',credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()
channel.queue_declare(queue='pleaseCreate')
channel.basic_puvlish(exchange='', routing_key='pleaseCreate', body='please create VM')
print(" [x] Sent 'please create VM'")
connection.close()
