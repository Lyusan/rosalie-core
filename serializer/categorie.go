package serializer

import (
	"github.com/gin-gonic/gin"
	"../model"
)

type Categorie struct {
	ID          uint   `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

type CategorieSerializer struct {
	C *gin.Context
	model.Categorie
}

func (s *CategorieSerializer) Response() Categorie {
	response := Categorie{
		ID:          s.ID,
		Name:        s.Name,
		Description: s.Description,
	}
	return response
}

type CategoriesSerializer struct {
	C          *gin.Context
	Categories []model.Categorie
}

func (s *CategoriesSerializer) Response() []Categorie {
	response := []Categorie{}
	for _, categorie := range s.Categories {
		serializer := CategorieSerializer{s.C, categorie}
		response = append(response, serializer.Response())
	}
	return response
}
