package main

import (
	"bufio"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"sync"
)

var pass string
var tag tags

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
	pass = os.Getenv("DB_PASS")
	tag.front = "0.0.1"
	tag.back = "0.0.1"
	go watch("/home/ubuntu/tags")
	http.HandleFunc("/created", provide)
	log.Printf("Listen on 0.0.0.0:5555")
	http.ListenAndServe(":5555", nil)
}
