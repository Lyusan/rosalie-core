package model

import (
	"../utils"
	"github.com/jinzhu/gorm"
)

type Vote struct {
	gorm.Model
	Value         int `gorm:"DEFAULT:1"`
	Type          string
	Email         string
	Application   Application
	ApplicationID int
}

func FindManyVotes() ([]Vote, error) {
	var votes []Vote
	db := utils.GetDB()
	err := db.Find(&votes).Error
	return votes, err
}

func FindVoteByID(id int) (Vote, error) {
	var vote Vote
	db := utils.GetDB()
	err := db.First(&vote, id).Error
	return vote, err
}

func SaveVotes(vote Vote) (Vote, error) {
	db := utils.GetDB()
	err := db.Create(&vote).Error
	return vote, err
}
