package main

import (
	"log"

	"./model"
	"./utils"

	"github.com/jinzhu/gorm"
	_ "github.com/joho/godotenv/autoload"
)

func resetSchema(db *gorm.DB) {
	slice := model.GetModels()
	for _, model := range slice {
		db.DropTableIfExists(model)
		db.AutoMigrate(model)
	}
}

func main() {
	db, err := utils.InitDB()
	if err != nil {
		log.Fatalf("DB: Cannot connect: %s\n", err)
	}
	defer db.Close()
	resetSchema(db)
}
