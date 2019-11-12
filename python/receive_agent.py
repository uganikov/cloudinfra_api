import pika
import libvirt
import json

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
channel.queue_declare(queue='pleaseCreate')

def callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    params = json.loads(body)
    instance_id = params["instance_id"]
    print('  instance_id: ' + instance_id)
    connect = libvirt.open('qemu:///system')
    for id in connect.listDomainsID():
        vm = connect.lookupByID(id)
        print('starting'+vm.name())
        vm.start()
        tim.sleep(1)

channel.basic_consume(callback, queue='pleaseCreate', no_ack=True)

channel.start_consuming()
