package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Article struct {
	ID              uint   `json:"id"`
	Title           string `json:"title"`
	Content         string `json:"content"`
	PublicationDate string `json:"publicationDate"`
	UpdatedDate     string `json:"updateDate"`
}

type ArticleSerializer struct {
	C *gin.Context
	model.Article
}

func (s *ArticleSerializer) Response() Article {
	response := Article{
		ID:              s.ID,
		Title:           s.Title,
		Content:         s.Content,
		PublicationDate: s.PublicationDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		UpdatedDate:     s.UpdateDate.UTC().Format("2006-01-02T15:04:05.999Z"),
	}
	return response
}

type ArticlesSerializer struct {
	C        *gin.Context
	Articles []model.Article
}

func (s *ArticlesSerializer) Response() []Article {
	response := []Article{}
	for _, article := range s.Articles {
		serializer := ArticleSerializer{s.C, article}
		response = append(response, serializer.Response())
	}
	return response
}
