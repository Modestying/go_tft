package engine

import (
	"fmt"

	"gotft/cmd/tft/srv"
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
