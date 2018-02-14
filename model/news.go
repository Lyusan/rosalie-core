package model

import (
	"time"

	"../utils"

	"github.com/jinzhu/gorm"
)

type News struct {
	gorm.Model
	Title           string
	Author          string
	PublicationDate time.Time
	UpdateDate      time.Time
	Summary         string
	Content         string
}

func FindManyNews() ([]News, error) {
	var news []News
	db := utils.GetDB()
	err := db.Order("publication_date").Find(&news).Error
	return news, err
}

func FindNewsByID(id int) (News, error) {
	var news News
	db := utils.GetDB()
	err := db.First(&news, id).Error
	return news, err
}
