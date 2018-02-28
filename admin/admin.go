package main

import (
	"net/http"

	"../model"
	"../utils"

	"github.com/qor/admin"

	_ "github.com/joho/godotenv/autoload"
)

func main() {
	admin := admin.New(&admin.AdminConfig{DB: utils.DB})
	slice := model.GetModels()
	for _, model := range slice {
		admin.AddResource(model)
	}
	// initalize an HTTP request multiplexer
	mux := http.NewServeMux()

	// Mount admin interface to mux
	admin.MountTo("/admin", mux)
	http.ListenAndServe(":9000", mux)
}
