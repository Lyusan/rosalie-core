package model

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Application struct {
	gorm.Model
    AwardID       int
	MoveID        int
	PersonID      int
	Questions     []Question
	VotesNominees int
	VotesWinner   int
	Votes         []Vote
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
