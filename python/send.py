import pika

credentials = pika.PlainCredentials('cloudinfra', 'cloudinfra01')
parameters = pika.ConnectionParameters('10.0.0.2', 5672,'/',credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

def order(word,instanceID):
    if 'create' in word:
        channel.queue_declare(queue='pleaseCreate')
        channel.basic_publish(exchange='', routing_key='pleaseCreate', body='please create VM'+'_'+instanceID)
        print(" [x] Sent 'please create VM'")
        connection.close()

    elif 'start' in word:
        channel.queue_declare(queue='pleaseStart')
        channel.basic_publish(exchange='', routing_key='pleaseStart', body='please start VM'+'_'+instanceID)
        print(" [x] Sent 'please start VM'")
        connection.close()

    elif 'stop' in word:
        channel.queue_declare(queue='pleaseStop')
        channel.basic_publish(exchange='', routing_key='pleaseStop', body='please stop VM'+'_'+instanceID)
        print(" [x] Sent 'please stop VM'")
        connection.close()

    elif 'destroy' in word:
        channel.queue_declare(queue='pleaseDestroy')
        channel.basic_publish(exchange='', routing_key='pleaseDestroy', body='please destroy VM'+'_'+instanceID)
        print(" [x] Sent 'please destroy VM'")
        connection.close()
