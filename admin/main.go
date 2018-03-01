package main

import (
	"net/http"
	"log"
	"fmt"
	"os"

	"../model"
	"../utils"

	_ "github.com/jinzhu/gorm"
	"github.com/qor/admin"

	_ "github.com/joho/godotenv/autoload"
)

func main() {
	db, err := utils.InitDB()
	if err != nil {
		log.Fatalf("DB: Cannot connect: %s\n", err)
	}
	Admin := admin.New(&admin.AdminConfig{DB: db})
	// slice := model.GetModels()
	// for _, model := range slice {
	// 	admin.AddResource(model)
	// }
	adminApplication := Admin.AddResource(&model.Application{})
	Admin.AddResource(&model.Movie{})
	Admin.AddResource(&model.Person{})
	adminApplication.NewAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID")
	adminApplication.Meta(&admin.Meta{Name: "MovieID", Label: "Movie", Type: "select_one",
		Config: &admin.SelectOneConfig{
		  Collection: func(_ interface{}, context *admin.Context) (options [][]string) {
			var movies []model.Movie
			context.GetDB().Find(&movies)
	
			for _, n := range movies {
			  idStr := fmt.Sprintf("%d", n.ID)
			  var option = []string{idStr, n.Title}
			  options = append(options, option)
			}
	
			return options
		  },
		},
	  })
	  adminApplication.Meta(&admin.Meta{Name: "PersonID", Label: "Person", Type: "select_one",
		Config: &admin.SelectOneConfig{
		  Collection: func(_ interface{}, context *admin.Context) (options [][]string) {
			var people []model.Person
			context.GetDB().Find(&people)
	
			for _, n := range people {
			  idStr := fmt.Sprintf("%d", n.ID)
			  var option = []string{idStr, n.FirstName, n.LastName}
			  options = append(options, option)
			}
	
			return options
		  },
		},
	  })

	// initalize an HTTP request multiplexer
	mux := http.NewServeMux()

	// Mount admin interface to mux
	Admin.MountTo("/admin", mux)
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "9000"
	}

	http.ListenAndServe(fmt.Sprintf(":%s", port), mux)
}
