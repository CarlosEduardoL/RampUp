Vagrant.configure("2") do |config|

    config.vm.provision "file", source: "scripts/", destination: "./scripts"
    config.vm.provision "shell", inline: "chmod +x scripts/*"

    config.vm.define "ubuntu-back" do |back|
        back.vm.box = "bento/ubuntu-20.04"
        back.vm.network "private_network", ip: "192.168.33.3"
        back.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "ubuntu-back"]
        end
        back.vm.provision "shell", inline: "mv ./scripts/script-back.sh ./scripts/script.sh"
        back.vm.provision "shell", inline: "rm ./scripts/script-*.sh && ./scripts/script.sh &"
    end
    config.vm.define "ubuntu-front" do |front|
        front.vm.box = "bento/ubuntu-20.04"
        front.vm.network "private_network", ip: "192.168.33.2"
        front.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "ubuntu-front"]
        end
        front.vm.provision "shell", inline: "mv ./scripts/script-front.sh ./scripts/script.sh"
        front.vm.provision "shell", inline: "rm ./scripts/script-*.sh && ./scripts/script.sh &"
    end
    config.vm.define "ubuntu-proxy" do |proxy|
        proxy.vm.box = "bento/ubuntu-20.04"
        proxy.vm.network "private_network", ip: "192.168.33.50"
        proxy.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "ubuntu-proxy"]
        end
        proxy.vm.provision "shell", inline: "mv ./scripts/script-proxy.sh ./scripts/script.sh"
        proxy.vm.provision "file", source: "nginx/", destination: "temp/nginx"
        proxy.vm.provision "shell", inline: "mv -f temp/nginx/* /etc/nginx/ && systemctl reload nginx && rm -rf temp"
        proxy.vm.provision "shell", inline: "rm ./scripts/script-*.sh && ./scripts/script.sh &"
    end
    config.vm.provision "shell", inline: "(crontab -l 2>/dev/null; echo \"@reboot /home/vagrant/scripts/script.sh\") | crontab -"
end