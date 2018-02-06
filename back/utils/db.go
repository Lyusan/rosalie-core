package utils

import (
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var DB *gorm.DB

func InitDB() *gorm.DB {
	db, err := gorm.Open("postgres", "user=postgres dbname=rosalie sslmode=disable password=root")
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
