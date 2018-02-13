package person

import (
	"time"

	"../utils"
	"github.com/jinzhu/gorm"
)

type Person struct {
	gorm.Model
	FirstName   string
	LastName    string
	BirthDate   time.Time
	Description string
	ImgUrl      string
}

func FindManyPersons() ([]Person, error) {
	var persons []Person
	db := utils.GetDB()
	err := db.Find(&persons).Error
	return persons, err
}

func FindPersonByID(id int) (Person, error) {
	var person Person
	db := utils.GetDB()
	err := db.First(&person, id).Error
	return person, err
}
