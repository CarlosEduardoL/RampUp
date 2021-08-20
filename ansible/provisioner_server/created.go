package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"os"
	"os/exec"
	"strings"
)

func provide(w http.ResponseWriter, req *http.Request) {
	addr := req.RemoteAddr

	body, err := ioutil.ReadAll(req.Body)
	if err != nil {
		log.Default().Printf("Error reading body from %s -> %v", addr, err)
		http.Error(w, "Error reading body", http.StatusBadRequest)
		return
	}
	var info information
	err = json.Unmarshal(body, &info)
	if err != nil {
		log.Default().Printf("Error parsing body from %s -> %v", addr, err)
		http.Error(w, "Error parsing body", http.StatusBadRequest)
		return
	}

	go func(info information, addr string) {
		// Create temp host file
		file_name := fmt.Sprintf("host%v%v", rand.Int31(), rand.Int31())
		err = ioutil.WriteFile(
			file_name,
			[]byte(fmt.Sprintf("[%s]\n%s", info.tag(), strings.Split(addr, ":")[0])),
			0644)
		defer os.Remove(file_name)

		if err != nil {
			log.Default().Printf("Error creating inventory file %s -> %v", addr, err)
			return
		}

		cmd := exec.Command("ansible-playbook", "-i", file_name,
			"--private-key", "/home/ubuntu/.ssh/id_rsa", "-u", "ubuntu",
			"-e", "db_host="+info.Dns, "-e", "back_host="+info.Dns, "-e", "tag="+tag.get(info.Type),
			"-e", "db_user=root", "-e", "db_pass="+pass, "/home/ubuntu/RampUp/ansible/playbooks/site.yml")

		err := redirectCommandOutput(cmd)
		if err != nil {
			log.Default().Printf("Error providing %s -> %v", addr, err)
			return
		}
	}(info, addr)
}
