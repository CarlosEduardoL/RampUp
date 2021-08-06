package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"os"
	"os/exec"
	"strings"
	"sync"
)

type information struct {
	Type byte
	Dns  string
}

func (i information) tag() string {
	var tag string
	if i.Type == 0 {
		tag = "Movies_front_instance"
	} else {
		tag = "Movies_back_instance"
	}
	return tag
}

var pass string

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
			"-e", "db_host="+info.Dns, "-e", "back_host="+info.Dns, "-e", "tag=0.0.1",
			"-e", "db_user=root", "-e", "db_pass="+pass, "/home/ubuntu/RampUp/ansible/site.yml")

		err := redirectCommandOutput(cmd)
		if err != nil {
			log.Default().Printf("Error providing %s -> %v", addr, err)
			return
		}
	}(info, addr)
}

func redirectCommandOutput(cmd *exec.Cmd) error {
	wg := sync.WaitGroup{}
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	stderr, err := cmd.StderrPipe()
	if err != nil {
		return err
	}
	if err := cmd.Start(); err != nil {
		return err
	}
	go read(stdout, wg)
	go read(stderr, wg)
	cmd.Wait()
	wg.Wait()
	return nil
}

func read(std io.ReadCloser, wg sync.WaitGroup) {
	wg.Add(1)
	in := bufio.NewScanner(std)
	for in.Scan() {
		log.Printf(in.Text())
	}
	wg.Done()
}

func main() {
	f, err := os.OpenFile("/var/log/provisioner.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		log.Fatalf("error opening file: %v", err)
	}
	defer f.Close()
	log.SetOutput(f)

	http.HandleFunc("/created", provide)
	http.ListenAndServe(":5555", nil)
}
