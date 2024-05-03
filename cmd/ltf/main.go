package main

import (
	"fmt"

	"goltf/core/engine"
)

var X string

func main() {
	engine.LtfEngine.Start()
	fmt.Println(X)
}
