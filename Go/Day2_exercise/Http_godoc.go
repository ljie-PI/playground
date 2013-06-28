package main

import (
	"http"
)

func main() {
	http.Handle("/", http.FileServer("godoc", "/"))
	http.ListenAndServe(":8000", nil)
}
