import pika
import libvirt

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
channel.queue_declare(queue='pleaseStart')

def callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    connect = libvirt.open('qemu:///system')
    for id in connect.listDomainsID():
        vm = connect.lookupByID(id)
        print('starting'+vm.name())
        vm.start()
        tim.sleep(1)

channel.basic_consume(callback, queue='pleaseSreate', no_ack=True)

channel.start_consuming()
