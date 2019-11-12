import pika
import libvirt
import json
import subprocess
import os
import time

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
channel.queue_declare(queue='pleaseCreate')

def callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    params = json.loads(body)
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

channel.basic_consume(callback, queue='pleaseCreate', no_ack=True)

channel.start_consuming()
