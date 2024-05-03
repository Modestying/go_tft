package core

type Job interface {
	Name()
	Active(Solider)
}

type Solider interface {
	String()
	Name()
}
