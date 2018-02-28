package utils

import (
	"fmt"
	"os"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var DB *gorm.DB

func InitDB() (*gorm.DB, error) {
	host := os.Getenv("DB_HOST")
	if len(host) == 0 {
		host = "localhost"
	}
	username := os.Getenv("DB_USERNAME")
	dbname := os.Getenv("DB_NAME")
	password := os.Getenv("DB_PASSWORD")
	loginString := fmt.Sprintf("host=%s dbname=%s user=%s password=%s sslmode=disable",
		host, dbname, username, password)
	db, err := gorm.Open("postgres", loginString)
	if err != nil {
		return nil, err
	}
	DB = db
	return db, nil
}

func GetDB() *gorm.DB {
	return DB
}
