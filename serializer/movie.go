package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Movie struct {
	ID          uint   `json:"id"`
	Title       string `json:"title"`
	Description string `json:"desc"`
	Image       string `json:"img"`
	Date        string `json:"date"`
}

type MovieSerializer struct {
	C *gin.Context
	model.Movie
}

func (s *MovieSerializer) Response() Movie {
	response := Movie{
		ID:          s.ID,
		Title:       s.Title,
		Description: s.Description,
		Image:       s.Image,
		Date:        s.Date.UTC().Format("2006-01-02T15:04:05.999Z"),
	}
	return response
}

type MoviesSerializer struct {
	C      *gin.Context
	Movies []model.Movie
}

func (s *MoviesSerializer) Response() []Movie {
	response := []Movie{}
	for _, movie := range s.Movies {
		serializer := MovieSerializer{s.C, movie}
		response = append(response, serializer.Response())
	}
	return response
}
