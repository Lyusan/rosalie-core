package categorie

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Categorie struct {
	gorm.Model
	Name        string
	Description string
}

func FindManyCategories() ([]Categorie, error) {
	var categories []Categorie
	db := utils.GetDB()
	err := db.Find(&categories).Error
	return categories, err
}

func FindCategorieByID(id int) (Categorie, error) {
	var categorie Categorie
	db := utils.GetDB()
	err := db.First(&categorie, id).Error
	return categorie, err
}
