package model

import (
	"time"

	"../utils"

	"github.com/jinzhu/gorm"
)

type Edition struct {
	gorm.Model
	Name           string
	Localisation   string
	StartDate      time.Time
	NominationDate time.Time
	RewardingDate  time.Time
	EndDate        time.Time
	Awards         []Award
}

func FindManyEditions() ([]Edition, error) {
	var editions []Edition
	db := utils.GetDB()
	err := db.Find(&editions).Error
	return editions, err
}

func FindEditionByID(id int) (Edition, error) {
	var edition Edition
	db := utils.GetDB()
	err := db.First(&edition, id).Error
	return edition, err
}
