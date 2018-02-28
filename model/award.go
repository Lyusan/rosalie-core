package model

import (
	"../utils"

	"github.com/jinzhu/gorm"
)

type Award struct {
	gorm.Model

	Applications []Application

	CategorieID uint
	EditionID   uint
}

func FindManyAwards() ([]Award, error) {
	var awards []Award
	db := utils.GetDB()
	err := db.Find(&awards).Error
	return awards, err
}

func FindAwardByID(id uint) (Award, error) {
	var award Award
	db := utils.GetDB()
	err := db.First(&award, id).Error
	return award, err
}

func (s *Award) FindRelatedCategorie() Categorie {
	var categorie Categorie
	db := utils.GetDB()
	db.First(&categorie, s.CategorieID)
	return categorie
}
