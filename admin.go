package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"./model"
	"./utils"

	_ "github.com/jinzhu/gorm"
	"github.com/qor/admin"
	"github.com/qor/qor"
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
	application := Admin.AddResource(&model.Application{})
	application.NewAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID", "AwardID")
	application.ShowAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID", "AwardID")
	application.EditAttrs("VotesNominees", "VotesWinner", "MovieID", "PersonID", "AwardID")
	application.Meta(&admin.Meta{Name: "MovieID", Label: "Movie", Type: "select_one",
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
		FormattedValuer: func(resource interface{}, context *qor.Context) (result interface{}) {
			var movie model.Movie
			if application, ok := resource.(*model.Application); ok {
				context.GetDB().Find(&movie, application.MovieID)
			} else {
				return "ERROR"
			}
			return movie.Title
		},
	})
	application.Meta(&admin.Meta{Name: "PersonID", Label: "Person", Type: "select_one",
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
		FormattedValuer: func(resource interface{}, context *qor.Context) (result interface{}) {
			var person model.Person
			if application, ok := resource.(*model.Application); ok {
				context.GetDB().Find(&person, application.PersonID)
			} else {
				return "ERROR"
			}
			return person.GetFullName()
		},
	})
	application.Meta(&admin.Meta{Name: "AwardID", Label: "Award", Type: "select_one",
		Config: &admin.SelectOneConfig{
			Collection: func(_ interface{}, context *admin.Context) (options [][]string) {
				var people []model.Award
				context.GetDB().Find(&people)

				for _, n := range people {
					idStr := fmt.Sprintf("%d", n.ID)
					var option = []string{idStr, n.FindRelatedEdition().Name + " - " + n.FindRelatedCategorie().Name}
					options = append(options, option)
				}

				return options
			},
		},
		FormattedValuer: func(resource interface{}, context *qor.Context) (result interface{}) {
			var award model.Award
			if application, ok := resource.(*model.Application); ok {
				context.GetDB().Find(&award, application.AwardID)
			} else {
				return "ERROR"
			}
			return award.FindRelatedEdition().Name + " - " + award.FindRelatedCategorie().Name
		},
	})

}

func addArticle(Admin *admin.Admin) {
	article := Admin.AddResource(&model.Article{})
	article.Meta(&admin.Meta{Name: "Content", Type: "text"})
}

func addAward(Admin *admin.Admin) {
	award := Admin.AddResource(&model.Award{})
	award.NewAttrs("-Applications")
	award.EditAttrs("-Applications")
	award.Meta(&admin.Meta{Name: "CategorieID", Label: "Categorie", Type: "select_one",
		Config: &admin.SelectOneConfig{
			Collection: func(_ interface{}, context *admin.Context) (options [][]string) {
				var categories []model.Categorie
				context.GetDB().Find(&categories)

				for _, n := range categories {
					idStr := fmt.Sprintf("%d", n.ID)
					var option = []string{idStr, n.Name}
					options = append(options, option)
				}

				return options
			},
		},
		FormattedValuer: func(resource interface{}, context *qor.Context) (result interface{}) {
			var categorie model.Categorie
			if award, ok := resource.(*model.Award); ok {
				context.GetDB().Find(&categorie, award.CategorieID)
			} else {
				return "ERROR"
			}
			return categorie.Name
		},
	})
	award.Meta(&admin.Meta{Name: "EditionID", Label: "Edition", Type: "select_one",
		Config: &admin.SelectOneConfig{
			Collection: func(_ interface{}, context *admin.Context) (options [][]string) {
				var editions []model.Edition
				context.GetDB().Find(&editions)

				for _, n := range editions {
					idStr := fmt.Sprintf("%d", n.ID)
					var option = []string{idStr, n.Name}
					options = append(options, option)
				}

				return options
			},
		},
		FormattedValuer: func(resource interface{}, context *qor.Context) (result interface{}) {
			var edition model.Edition
			if award, ok := resource.(*model.Award); ok {
				context.GetDB().Find(&edition, award.EditionID)
			} else {
				return "ERROR"
			}
			return edition.Name
		},
	})
}

func addCategorie(Admin *admin.Admin) {
	categorie := Admin.AddResource(&model.Categorie{})
	categorie.Meta(&admin.Meta{Name: "Description", Type: "text"})
	categorie.NewAttrs("-Awards")
	categorie.EditAttrs("-Awards")
}

func addEdition(Admin *admin.Admin) {
	edition := Admin.AddResource(&model.Edition{})
	edition.NewAttrs("-Awards")
	edition.EditAttrs("-Awards")
}

func addMovie(Admin *admin.Admin) {
	movie := Admin.AddResource(&model.Movie{})
	movie.NewAttrs("-Applications")
	movie.EditAttrs("-Applications")
	movie.Meta(&admin.Meta{Name: "Description", Type: "text"})
}

func addNews(Admin *admin.Admin) {
	news := Admin.AddResource(&model.News{})
	news.Meta(&admin.Meta{Name: "Summary", Type: "text"})
	news.Meta(&admin.Meta{Name: "Content", Type: "text"})
}

func addPerson(Admin *admin.Admin) {
	person := Admin.AddResource(&model.Person{})
	person.NewAttrs("-Applications")
	person.EditAttrs("-Applications")
	person.Meta(&admin.Meta{Name: "Description", Type: "text"})
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
