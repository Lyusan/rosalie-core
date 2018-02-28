package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"./model"

	"github.com/qor/admin"
	_ "github.com/qor/qor"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
	_ "github.com/joho/godotenv/autoload"
)

func testInsert(db *gorm.DB) {
	news := model.News{
		Title:           "News1",
		Author:          "Author",
		PublicationDate: time.Now(),
		UpdateDate:      time.Now(),
		Summary:         "News about a random movie",
		Content:         "News content blablabla\n blablablablabalandahuyegesgfegfuegfuegfeyges",
	}

	db.Create(&news)
	categorie1 := model.Categorie{
		Name:        "Meilleure Interprétation",
		Description: "",
	}
	db.Create(&categorie1)
	categorie2 := model.Categorie{
		Name:        "Meilleur Espoir",
		Description: "",
	}
	db.Create(&categorie2)
	categorie3 := model.Categorie{
		Name:        "Meilleur Scénario Original",
		Description: "",
	}
	db.Create(&categorie3)
	award1 := model.Award{
		CategorieID: 1,
	}
	db.Create(&award1)
	award2 := model.Award{
		CategorieID: 1,
	}
	db.Create(&award2)
	// awardsResult := []model.Award{}
	// db.Find(&awardsResult)
	// for i, _ := range awardsResult {
	// 	db.Model(awardsResult[i]).Related(&awardsResult[i].Categorie)
	// }
	// fmt.Println(awardsResult)
	movie1 := model.Movie{
		Title:       "Movie1",
		Description: "Desc m1",
		Date:        time.Now(),
		Image:       "url",
		Articles: []model.Article{
			model.Article{
				Title:           "Article1 m1",
				Content:         "blabla",
				UpdateDate:      time.Now(),
				PublicationDate: time.Now(),
			},
			model.Article{
				Title:           "Article1 m1",
				Content:         "blabla",
				UpdateDate:      time.Now(),
				PublicationDate: time.Now(),
			},
		},
	}
	db.Create(&movie1)
}

func createSchema(db *gorm.DB, admin *admin.Admin) {
	for _, model := range []interface{}{&model.Application{}, &model.Article{}, &model.Award{}, &model.Categorie{}, &model.Edition{}, &model.Movie{}, &model.News{}, &model.Person{}, &model.Question{}} {
		db.DropTableIfExists(model)
		db.CreateTable(model)
		admin.AddResource(model)
	}
}

func main() {
	//db, err := utils.InitDB()
	db, err := gorm.Open("sqlite3", "demo.db")
	if err != nil {
		log.Fatalf("DB: Cannot connect: %s\n", err)
	}
	defer db.Close()
	db.LogMode(true)
	admin := admin.New(&admin.AdminConfig{DB: db})
	// admin := admin.New(&qor.Config{DB: db})
	createSchema(db, admin)
	time.Sleep(2 * time.Second)
	testInsert(db)

	// engine := gin.Default()
	// router := engine.Group("/v1")
	// routers.NewsRegister(router)
	// routers.CategorieRegister(router)
	// routers.EditionRegister(router)
	// routers.QuestionRegister(router)
	// routers.ArticleRegister(router)
	// routers.MovieRegister(router)
	// port := os.Getenv("PORT")
	// if len(port) == 0 {
	// 	port = "4000"
	// }
	//engine.Run(fmt.Sprintf(":%s", port))

	// initalize an HTTP request multiplexer
	mux := http.NewServeMux()

	// Mount admin interface to mux
	admin.MountTo("/admin", mux)

	fmt.Println("Listening on: 9000")
	http.ListenAndServe(":9000", mux)
}
