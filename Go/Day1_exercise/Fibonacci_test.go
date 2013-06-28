package Fibonacci

import(
	"testing"
)

func TestFibonacci(t *testing.T) {
	s := Fibonacci(5)
	if s != 5 {
		t.Errorf("error")
	}
}

