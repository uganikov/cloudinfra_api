import pika
import libvirt

connection = pika.BlockingConnection(pika.ConnectionParameters(host='10.0.0.1'))
channel = connection.channel()
channel.queue_declare(queue='pleaseCreate')

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    connect = libvirt.open("qemu:///system")
    for id in conn.listDomainsID():
        dom = conn.lookupByID(id)
        infos = dom.info()
        print 'ID = %d' % id
        print 'Name =  %s' % dom.name()
        print 'State = %d' % infos[0]
        print 'Max Memory = %d' % infos[1]
        print 'Number of virt CPUs = %d' % infos[3]
        print 'CPU Time (in ns) = %d' % infos[2]
        print ' '

channel.basic_consume(callback, queue='pleaseCreate', no_ack=True)

channel.start_consuming()
