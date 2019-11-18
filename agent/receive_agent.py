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

def publish_instance_removed(instance_id):
    result = {
      "msg":"status",
      "instance_id": instance_id,
      "state": None,
      "memory": None,
      "cpu": None
    }
    channel.basic_publish("", "cloud_infra_api_result", json.dumps(result))

def _start_instance(vm):
    print('starting '+vm.name())
    vm.create()
    publish_instance_status(vm)

def _stop_instance(vm):
    print('stopping '+vm.name())
    vm.shutdown()
    publish_instance_status(vm)

def create_instance(connect, params):
    instance_id = params["instance_id"]
    ip = params["ip"]
    print('  instance_id: ' + instance_id)
    print('           ip: ' + ip)
    print('copy image ' +  instance_id + ".qcow2")
    with open(instance_id + ".pub", "w") as f:
        f.write(params["identity_pub"])
    os.system("scp 10.0.0.1:/var/cloudinfra/imgs/instance.qcow2 " + instance_id + ".qcow2")
    params["identity_pub"]
    fn = subprocess.check_output(["sudo", "bash", "./mkmeta.sh", ip, instance_id])
    os.system("sed -e 's/@instance_id@/" + instance_id + "/g' -e 's|@image_path@|" + os.getcwd() + "|g' template.xml > " + instance_id + ".xml")

    xmlfile = open(instance_id + ".xml")
    xmldesc = xmlfile.read()
    xmlfile.close()
    connect.defineXML(xmldesc)
    vm = connect.lookupByName(instance_id)
    _start_instance(vm)

def destroy_instance(connect, params):
    instance_id = params["instance_id"]
    vm = connect.lookupByName(instance_id)
    _stop_instance(vm)
    vm.undefineXML()
    publish_instance_removed("instance_id")

def start_instance(connect, params):
    instance_id = params["instance_id"]
    vm = connect.lookupByName(instance_id)
    _start_instance(vm)

def stop_instance(connect, params):
    instance_id = params["instance_id"]
    vm = connect.lookupByName(instance_id)
    _stop_instance(vm)

def show_instance(connect, params):
    instance_id = params["instance_id"]
    vm = connect.lookupByName(instance_id)
    publish_instance_status(vm)

def callback(ch, method, properties, body):
    print(' [x] Received %r' % body)
    params = json.loads(body)
    cmd = params["cmd"]
    connect = libvirt.open('qemu:///system')

    if cmd == "create":
        create_instance(connect, params)
    elif cmd == "destroy":
        destroy_instance(connect, params)
    elif cmd == "show":
        show_instance(connect, params)
    elif cmd == "start":
        start_instance(connect, params)
    elif cmd == "stop":
        stop_instance(connect, params)

channel.basic_consume(callback, queue='cloud_infra_api', no_ack=True)
channel.exchange_declare(exchange='cloud_infra_api_pubsub', type='fanout')
result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue
channel.queue_bind(exchange='cloud_infra_api_pubsub', queue=queue_name)
channel.basic_consume(callback, queue=queue_name, no_ack=True)

channel.start_consuming()
