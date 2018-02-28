package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Application struct {
	ID     uint   `json:"id"`
	Movie  Movie  `json:"movie"`
	Person Person `json:"person"`
}

type ApplicationSerializer struct {
	C *gin.Context
	model.Application
}

func (s *ApplicationSerializer) Response() Application {
	movieSerializer := MovieSerializer{s.C, s.Movie}
	movie := movieSerializer.Response()
	personSerializer := PersonSerializer{s.C, s.Person}
	person := personSerializer.Response()
	response := Application{
		ID:     s.ID,
		Movie:  movie,
		Person: person,
	}
	return response
}

type ApplicationsSerializer struct {
	C            *gin.Context
	Applications []model.Application
}

func (s *ApplicationsSerializer) Response() []Application {
	response := []Application{}
	for _, application := range s.Applications {
		serializer := ApplicationSerializer{s.C, application}
		response = append(response, serializer.Response())
	}
	return response
}
