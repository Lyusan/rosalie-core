package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Person struct {
	ID          uint   `json:"id"`
	FirstName   string `json:"firstname"`
	LastName    string `json:"lastname"`
	BirthDate   string `json:"birthdate"`
	Description string `json:"desc"`
	ImgUrl      string `json:"img"`
}

type PersonSerializer struct {
	C *gin.Context
	model.Person
}

func (s *PersonSerializer) Response() Person {
	response := Person{
		ID:          s.ID,
		FirstName:   s.FirstName,
		LastName:    s.LastName,
		BirthDate:   s.BirthDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		Description: s.Description,
		ImgUrl:      s.ImgUrl,
	}
	return response
}

type PeopleSerializer struct {
	C      *gin.Context
	People []model.Person
}

func (s *PeopleSerializer) Response() []Person {
	response := []Person{}
	for _, person := range s.People {
		serializer := PersonSerializer{s.C, person}
		response = append(response, serializer.Response())
	}
	return response
}
