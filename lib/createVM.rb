require 'fog'

connection = Fog::Compute.new(provider: 'libvirt',libvirt_uri: 'qemu+ssh://cloudinfra@10.0.0.2/system')
