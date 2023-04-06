package main

import (
	"log"
	"os"
	"strings"

	"github.com/fsnotify/fsnotify"
)

func watch(conf_file string) {
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		log.Printf("Error on watcher initialization: %v", err)
	}
	defer watcher.Close()

	//waiter
	done := make(chan bool)

	go func() {
		for {
			select {
			case event := <-watcher.Events:
				switch {
				case event.Op&fsnotify.Write == fsnotify.Write:
					content, err := os.ReadFile(event.Name)
					if err != nil {
						log.Printf("Error read conf file: %v", err)
					}
					manage_config(string(content))
				}
			case err := <-watcher.Errors:
				log.Printf("Error read conf file: %v", err)
			}
		}
	}()

	if err := watcher.Add(conf_file); err != nil {
		log.Printf("Error on watch setup: %v", err)
	}
	<-done
}

func manage_config(config string) {
	key_value := strings.Split(config, "::")
	if len(key_value) != 2 {
		log.Printf("config is invalid: %s", config)
		return
	}
	if key_value[0] != "front_tag" && key_value[0] != "back_tag" {
		log.Printf("invalid configuration %s", key_value[0])
		return
	} else if key_value[0] == "front_tag" {
		tag.front = key_value[1]
		log.Printf("The new front tag value is: %s", key_value[1])
	} else {
		tag.back = key_value[1]
		log.Printf("The new back tag value is: %s", key_value[1])
	}
}
