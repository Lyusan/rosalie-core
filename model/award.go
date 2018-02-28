package model

import (
	"../utils"

	"github.com/jinzhu/gorm"
)

type Award struct {
	gorm.Model
	CategorieID int
	EditionID   int
	Applications []Application
}

func FindManyAwards() ([]Award, error) {
	var awards []Award
	db := utils.GetDB()
	err := db.Find(&awards).Error
	return awards, err
}

func FindAwardByID(id int) (Award, error) {
	var award Award
	db := utils.GetDB()
	err := db.First(&award, id).Error
	return award, err
}
