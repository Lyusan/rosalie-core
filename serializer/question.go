package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Question struct {
	ID            uint   `json:"id"`
	Question      string `json:"question"`
	Email         string `json:"email"`
	ApplicationID uint   `json:"application_id"`
}

type QuestionSerializer struct {
	C *gin.Context
	model.Question
}

func (s *QuestionSerializer) Response() Question {
	response := Question{
		ID:            s.ID,
		Question:      s.Question.Question,
		Email:         s.Email,
		ApplicationID: s.ApplicationID,
	}
	return response
}

type QuestionsSerializer struct {
	C         *gin.Context
	Questions []model.Question
}

func (s *QuestionsSerializer) Response() []Question {
	response := []Question{}
	for _, question := range s.Questions {
		serializer := QuestionSerializer{s.C, question}
		response = append(response, serializer.Response())
	}
	return response
}
