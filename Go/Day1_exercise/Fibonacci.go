package Fibonacci

import(
	"fmt"
	"os"
)

func Fibonacci(n int) (ret int){
	if n < 1 {
		ret = -1
		fmt.Printf("input error: n < 1\n")
		os.Exit(1)
	} else if n < 3 {
		ret = 1
	} else {
		ret = Fibonacci(n-1) + Fibonacci(n-2)
	}
	return
}
