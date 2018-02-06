package main

import (
	"time"

<<<<<<< HEAD:back/main.go
	"./categorie"
	"./news"
	"./utils"
=======
	"./back/news"
	"./back/utils"
>>>>>>> ebff3a7ae88cfca62512eb560409b44738b424a1:rosalie.go
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
  _ "github.com/joho/godotenv/autoload"
)

func testInsert(db *gorm.DB) {
	news := news.News{
		Title:           "News1",
		Author:          "Author",
		PublicationDate: time.Now(),
		UpdateDate:      time.Now(),
		Summary:         "News about a random movie",
		Content:         "News content blablabla\n blablablablabalandahuyegesgfegfuegfuegfeyges",
	}

	db.Create(&news)
	categorie1 := categorie.Categorie{
		Name:        "Meilleure Interprétation",
		Description: "",
	}
	db.Create(&categorie1)
	categorie2 := categorie.Categorie{
		Name:        "Meilleur Espoir",
		Description: "",
	}
	db.Create(&categorie2)
	categorie3 := categorie.Categorie{
		Name:        "Meilleur Scénario Original",
		Description: "",
	}
	db.Create(&categorie3)
}

func createSchema(db *gorm.DB) {
	for _, model := range []interface{}{&news.News{}, &categorie.Categorie{} /*, &Edition{}, , &Award{}, &Movie{}, &Person{}, &Interview{}, &Article{}, &Application{}*/} {
		db.DropTable(model)
		db.AutoMigrate(model)
	}
}

func main() {
	db := utils.InitDB()
  defer db.Close()
	createSchema(db)
	testInsert(db)
	engine := gin.Default()
	router := engine.Group("/v1")
	news.NewsRegister(router)
	categorie.CategorieRegister(router)
	engine.Run()
}
