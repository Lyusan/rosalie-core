package model

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Application struct {
	gorm.Model
	Award   Award
	AwardID int
	Movie   Movie
	MoveID  int
}

func FindManyApplications() ([]Application, error) {
	var applications []Application
	db := utils.GetDB()
	err := db.Find(&applications).Error
	return applications, err
}

func FindApplicationByID(id int) (Application, error) {
	var application Application
	db := utils.GetDB()
	err := db.First(&application, id).Error
	return application, err
}
