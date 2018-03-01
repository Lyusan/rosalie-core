package main

import (
	"fmt"
	"log"
	"os"

	"../routers"
	"../utils"

	"github.com/gin-gonic/gin"
	_ "github.com/joho/godotenv/autoload"
)



func main() {
	db, err := utils.InitDB()
	if err != nil {
		log.Fatalf("DB: Cannot connect: %s\n", err)
	}
	defer db.Close()

	engine := gin.Default()
	router := engine.Group("/v1")
	routers.NewsRegister(router)
	routers.CategorieRegister(router)
	routers.EditionRegister(router)
	routers.QuestionRegister(router)
	routers.ArticleRegister(router)
	routers.MovieRegister(router)
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "4000"
	}

	engine.Run(fmt.Sprintf(":%s", port))
}
