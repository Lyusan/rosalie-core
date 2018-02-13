package utils

import (
	"fmt"
	"os"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var DB *gorm.DB

func InitDB() *gorm.DB {
	dburl := os.Getenv("DB_URL")
	if len(dburl) == 0 {
		dburl = "localhost"
	}
	username := os.Getenv("DB_USERNAME")
	dbname := os.Getenv("DB_NAME")
	password := os.Getenv("DB_PASSWORD")
	login_string := fmt.Sprintf("host=%s dbname=%s user=%s password=%s sslmode=disable",
		dburl, dbname, username, password)
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
