Vagrant.configure("2") do |config|
    config.vm.define "ubuntu-server" do |server|
        server.vm.box = "bento/ubuntu-20.04"
        server.vm.network "private_network", ip: "192.168.33.200"
        server.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "ubuntu-server"]
        end
    end
end