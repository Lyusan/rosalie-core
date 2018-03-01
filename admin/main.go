package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"../model"
	"../utils"

	_ "github.com/jinzhu/gorm"
	"github.com/qor/admin"
	"github.com/qor/roles"

	_ "github.com/joho/godotenv/autoload"
)

func main() {
	db, err := utils.InitDB()
	if err != nil {
		log.Fatalf("DB: Cannot connect: %s\n", err)
	}
	Admin := admin.New(&admin.AdminConfig{DB: db})
	addAll(Admin)

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

func addAll(Admin *admin.Admin) {
	addApplication(Admin)
	addArticle(Admin)
	addAward(Admin)
	addCategorie(Admin)
	addEdition(Admin)
	addMovie(Admin)
	addNews(Admin)
	addPerson(Admin)
	addQuestion(Admin)
	addVote(Admin)
}

func addApplication(Admin *admin.Admin) {
	adminApplication := Admin.AddResource(&model.Application{})
	adminApplication.NewAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID")
	adminApplication.EditAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID")
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
					var option = []string{idStr, n.GetFullName()}
					options = append(options, option)
				}

				return options
			},
		},
	})
}

func addArticle(Admin *admin.Admin) {
	Admin.AddResource(&model.Article{})
}

func addAward(Admin *admin.Admin) {
	Admin.AddResource(&model.Award{})
}

func addCategorie(Admin *admin.Admin) {
	Admin.AddResource(&model.Categorie{})
}
func addEdition(Admin *admin.Admin) {
	Admin.AddResource(&model.Edition{})
}

func addMovie(Admin *admin.Admin) {
	Admin.AddResource(&model.Movie{})
}

func addNews(Admin *admin.Admin) {
	Admin.AddResource(&model.News{})
}

func addPerson(Admin *admin.Admin) {
	person := Admin.AddResource(&model.Person{})
	person.NewAttrs("-Applications")
	person.EditAttrs("-Applications")
}

func addQuestion(Admin *admin.Admin) {
	Admin.AddResource(&model.Question{}, &admin.Config{
		Permission: roles.Deny(roles.Delete, roles.Anyone).Deny(roles.Update, roles.Anyone).Deny(roles.Create, roles.Anyone),
	})
}

func addVote(Admin *admin.Admin) {
	Admin.AddResource(&model.Vote{}, &admin.Config{
		Permission: roles.Deny(roles.Delete, roles.Anyone).Deny(roles.Update, roles.Anyone).Deny(roles.Create, roles.Anyone),
	})
}
