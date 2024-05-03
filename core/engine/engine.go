package engine

import (
	"fmt"
)

var (
	LtfEngine *Engine
	Engine    string
)

func init() {
	LtfEngine = new(Engine)
}

type Engine struct {
}

func (e *Engine) Start() {
	fmt.Printf("Start Game Engine")
}
