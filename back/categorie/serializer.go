package categorie

import "github.com/gin-gonic/gin"

type CategorieResponse struct {
	ID          uint   `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

type CategorieSerializer struct {
	C *gin.Context
	Categorie
}

func (s *CategorieSerializer) Response() CategorieResponse {
	response := CategorieResponse{
		ID:          s.ID,
		Name:        s.Name,
		Description: s.Description,
	}
	return response
}

type CategoriesSerializer struct {
	C          *gin.Context
	Categories []Categorie
}

func (s *CategoriesSerializer) Response() []CategorieResponse {
	response := []CategorieResponse{}
	for _, categorie := range s.Categories {
		serializer := CategorieSerializer{s.C, categorie}
		response = append(response, serializer.Response())
	}
	return response
}
