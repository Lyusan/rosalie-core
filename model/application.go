package model

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Application struct {
	gorm.Model
	VotesNominees int
	VotesWinner   int

	Votes     []Vote
	Questions []Question

	AwardID  uint
	MovieID  uint
	PersonID uint
}

func FindManyApplications() ([]Application, error) {
	var applications []Application
	db := utils.GetDB()
	err := db.Find(&applications).Error
	return applications, err
}

func FindApplicationByID(id uint) (Application, error) {
	var application Application
	db := utils.GetDB()
	err := db.First(&application, id).Error
	return application, err
}

func (s *Application) FindRelatedMovie() Movie {
	var movie Movie
	db := utils.GetDB()
	db.First(&movie, s.MovieID)
	return movie
}

func (s *Application) FindRelatedPerson() Person {
	var person Person
	db := utils.GetDB()
	db.First(&person, s.PersonID)
	return person
}
