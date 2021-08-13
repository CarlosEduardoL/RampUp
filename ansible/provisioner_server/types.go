package main

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

type tags struct {
	front string
	back  string
}

func (tags) get(machineType byte) string {
	if machineType == 0 {
		return tag.front
	} else {
		return tag.back
	}
}
