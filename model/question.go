package model

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Question struct {
	gorm.Model
	Question      string
	Email         string
	Application   Application
	ApplicationID int
}

func FindManyQuestions() ([]Question, error) {
	var questions []Question
	db := utils.GetDB()
	err := db.Find(&questions).Error
	return questions, err
}

func FindQuestionByID(id int) (Question, error) {
	var question Question
	db := utils.GetDB()
	err := db.First(&question, id).Error
	return question, err
}

func SaveQuestions(question Question) (Question, error) {
	db := utils.GetDB()
	err := db.Create(&question).Error
	return question, err
}
