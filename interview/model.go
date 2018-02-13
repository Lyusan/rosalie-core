package interview

import (
	"time"

	"../utils"

	"github.com/jinzhu/gorm"
)

type Interview struct {
	gorm.Model
	Title           string
	VideoUrl        string
	PublicationDate time.Time

	MovieID int
}

func FindManyInterviews() ([]Interview, error) {
	var interviews []Interview
	db := utils.GetDB()
	err := db.Find(&interviews).Error
	return interviews, err
}

func FindInterviewByID(id int) (Interview, error) {
	var interview Interview
	db := utils.GetDB()
	err := db.First(&interview, id).Error
	return interview, err
}
