import pika
import libvirt
import json
import subprocess
import os
import time
import pprint


connection = pika.BlockingConnection(pika.ConnectionParameters(host='10.0.0.1'))
channel = connection.channel()
channel.queue_declare(queue='cloud_infra_api')
channel.queue_declare(queue='cloud_infra_api_result')

def publish_instance_status(vm):
    print('show '+vm.name())
    vminfo = vm.info()
    result = {
      "msg":"status",
      "instance_id": vm.name(),
      "state": vminfo[0],
      "memory": vminfo[2],
      "cpu": vminfo[3]
    }
    channel.basic_publish("", "cloud_infra_api_result", json.dumps(result))

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
        os.system("sed -e 's/@instance_id@/" + instance_id + "/g' -e 's|@image_path@|" + os.getcwd() + "|g' template.xml > " + instance_id + ".xml")

        connect = libvirt.open('qemu:///system')
        xmlfile = open(instance_id + ".xml")
        xmldesc = xmlfile.read()
        xmlfile.close()
        connect.defineXML(xmldesc)
        # lines below will move to start interface
        vm = connect.lookupByName(instance_id)
        print('starting'+vm.name())
        vm.create()
        publish_instance_status(vm)

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
        publish_instance_status(vm)
    elif cmd == "destroy":
        instance_id = params["instance_id"]
        connect = libvirt.open('qemu:///system')
        vm = connect.lookupByName(instance_id)
        print('show'+vm.name())
        vm.shutdown()

channel.basic_consume(pubsub_callback, queue=queue_name, no_ack=True)

channel.start_consuming()
