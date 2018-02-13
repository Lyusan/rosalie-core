package movie

import (
	"time"

	"../utils"
	"../award"

	"github.com/jinzhu/gorm"
)

type Movie struct {
	gorm.Model
	Title         string
	Description   string
	Date          time.Time
	Image         string
	RewardingDate time.Time
	
	Articles  Article[]
	Inteviews Interview[]
}

func FindManyMovies() ([]Editon, error) {
	var movies []Movie
	db := utils.GetDB()
	err := db.Find(&movies).Error
	return e, err
}

func FindMovieByID(id int) (News, error) {
	var movie Movie
	db := utils.GetDB()
	err := db.First(&movie, id).Error
	return movie, err
}