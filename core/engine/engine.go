package engine

import (
	"fmt"

	"goltf/cmd/ltf/srv"
)

var (
	LtfEngine *Engine
)

func init() {
	LtfEngine = new(Engine)
}

type Engine struct {
}

func (e *Engine) Start() {
	fmt.Println("Start Game Engine")
	srv.ShowVersion()
}
