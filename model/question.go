package model

import (
	"time"

	"../utils"
	"github.com/jinzhu/gorm"
)

type Question struct {
	gorm.Model
	FirstName   string
	LastName    string
	BirthDate   time.Time
	Description string
	ImgUrl      string
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
