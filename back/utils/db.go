package utils

import (
	"fmt"
  "os"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var DB *gorm.DB

func InitDB() *gorm.DB {
  username := os.Getenv("DB_USERNAME")
  dbname := os.Getenv("DB_NAME")
  password := os.Getenv("DB_PASSWORD")
  login_string := fmt.Sprintf("user=%s dbname=%s sslmode=disable password=%s", username, dbname, password)
	db, err := gorm.Open("postgres", login_string)
	if err != nil {
		fmt.Print("Error connecting db ---")
	}
	DB = db
	print(db)
	return db
}

func GetDB() *gorm.DB {
	return DB
}
