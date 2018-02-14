package main

import (
	"fmt"
	"os"
	"time"

	"./model"
	"./routers"
	"./utils"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
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
}

func createSchema(db *gorm.DB) {
	for _, model := range []interface{}{&model.News{}, &model.Categorie{} /*, &Edition{}, , &Award{}, &Movie{}, &Person{}, &Interview{}, &Article{}, &Application{}*/} {
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
	routers.NewsRegister(router)
	routers.CategorieRegister(router)

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "4000"
	}
	engine.Run(fmt.Sprintf(":%s", port))
}
