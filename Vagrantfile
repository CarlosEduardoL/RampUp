# Variables
$back_ip  = "192.168.33.3"
$front_ip = "192.168.33.2"

Vagrant.configure("2") do |config|

    # Create backend machine
    config.vm.define "ubuntu-back" do |back|
        back.vm.box = "hashicorp/bionic64"
        back.vm.network "private_network", ip: $back_ip
        customize_vm(back, "ubuntu-back")
        back.vm.provision "docker" do |docker|
            docker.run "zeronetdev/rampup-back:0.0.1",
            args: "-p 3000:3000"
        end
    end

    # Create frontend machine
    config.vm.define "ubuntu-front" do |front|
        front.vm.box = "hashicorp/bionic64"
        front.vm.network "private_network", ip: $front_ip
        customize_vm(front, "ubuntu-front")
        front.vm.provision "docker" do |docker|
            docker.run "zeronetdev/rampup-front:0.0.1",
            args: "-e BACK_HOST=#{$back_ip} -p 3030:3030"
        end
    end

    # Create the reverse proxy
    config.vm.define "ubuntu-proxy" do |proxy|
        proxy.vm.box = "bento/ubuntu-20.04"
        proxy.vm.network "private_network", ip: "192.168.33.50"
        proxy.vm.network "public_network", ip: "192.168.0.50" # Here would be a public ip
        customize_vm(proxy, "ubuntu-proxy")
        proxy.vm.provision "file", source: "nginx/", destination: "nginx"
        proxy.vm.provision "docker" do |docker|
            docker.build_image "/vagrant/nginx", args: "-t ubuntu-proxy"
            docker.run "ubuntu-proxy",
            args: "-p 80:80"
        end
    end
end

# helper method to setup vm customization
def customize_vm(vm, name)
    vm.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", name]
    end
end