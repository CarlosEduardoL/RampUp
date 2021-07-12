# Variables
$back_ip  = "192.168.33.3"
$front_ip = "192.168.33.2"

Vagrant.configure("2") do |config|

    # Copy the scripts folder on all the machines
    config.vm.provision "file", source: "scripts/", destination: "./scripts"
    config.vm.provision "shell", inline: "chmod +x scripts/*"

    # Create backend machine
    config.vm.define "ubuntu-back" do |back|
        back.vm.box = "bento/ubuntu-20.04"
        back.vm.network "private_network", ip: $back_ip
        customize_vm(back, "ubuntu-back")
        node_provision("back", back)
    end

    # Create frontend machine
    config.vm.define "ubuntu-front" do |front|
        front.vm.box = "bento/ubuntu-20.04"
        front.vm.network "private_network", ip: $front_ip
        customize_vm(front, "ubuntu-front")
        node_provision("front", front)
    end

    # Create the reverse proxy
    config.vm.define "ubuntu-proxy" do |proxy|
        proxy.vm.box = "bento/ubuntu-20.04"
        proxy.vm.network "private_network", ip: "192.168.33.50"
        proxy.vm.network "public_network", ip: "192.168.0.50" # Here would be a public ip
        customize_vm(proxy, "ubuntu-proxy")
        proxy.vm.provision "file", source: "nginx/", destination: "temp/nginx"
        proxy.vm.provision "shell", inline: <<-Script
            mv ./scripts/script-proxy.sh ./scripts/script.sh && rm ./scripts/script-*.sh && ./scripts/script.sh
        Script
    end
end

############### Helper methods ###############

# helper method to node machines
def node_provision(name, machine)
    # Remove unnecessary scripts, run the configuration script and add crontab rule to restart service on reboot
    machine.vm.provision "shell", inline: <<-Script
        mv ./scripts/script-#{name}.sh ./scripts/script.sh && rm ./scripts/script-*.sh
        ./scripts/script.sh #{$back_ip}
        (crontab -l 2>/dev/null; echo "@reboot /home/vagrant/scripts/script.sh") | uniq | crontab -
    Script
end

# helper method to setup vm customization
def customize_vm(vm, name)
    vm.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", name]
    end
end