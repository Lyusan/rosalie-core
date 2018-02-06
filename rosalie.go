package main

import (
	"time"

	"./back/news"
	"./back/utils"
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
}

func createSchema(db *gorm.DB) {
	for _, model := range []interface{}{&news.News{} /*, &Edition{}, &Categorie{}, &Award{}, &Movie{}, &Person{}, &Interview{}, &Article{}, &Application{}*/} {
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
	engine.Run()
}
