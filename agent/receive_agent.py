import pika
import libvirt
import json
import subprocess
import os
import time

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
channel.queue_declare(queue='cloud_infra_api')


def callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    params = json.loads(body)
    cmd = params["cmd"]

    if cmd == "create":
        instance_id = params["instance_id"]
        ip = params["ip"]
        print('  instance_id: ' + instance_id)
        print('           ip: ' + ip)
        fn = subprocess.check_output(["sudo", "bash", "./mkmeta.sh", ip, instance_id])
        os.system("sed -e 's/@instance_id@/" + instance_id + "/g' template.xml > " + instance_id + ".xml")

        connect = libvirt.open('qemu:///system')
        xmlfile = open(instance_id + ".xml")
        xmldesc = xmlfile.read()
        xmlfile.close()
        connect.defineXML(xmldesc)
        # lines below will move to start interface
        vm = connect.lookupByName(instance_id)
        print('starting'+vm.name())
        vm.create()
    time.sleep(1)

channel.basic_consume(callback, queue='cloud_infra_api', no_ack=True)

channel.exchange_declare(exchange='cloud_infra_api_pubsub', type='fanout')
result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue
channel.queue_bind(exchange='cloud_infra_api_pubsub', queue=queue_name)

def pubsub_callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    params = json.loads(body)
    cmd = params["cmd"]
    if cmd == "show":
        instance_id = params["instance_id"]
        connect = libvirt.open('qemu:///system')
        vm = connect.lookupByName(instance_id)
        print('show'+vm.name())

channel.basic_consume(pubsub_callback, queue=queue_name, no_ack=True)

channel.start_consuming()
