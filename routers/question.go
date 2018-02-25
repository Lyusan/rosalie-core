package routers

import (
	"strconv"

	"../model"
	"../serializer"

	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
)

func QuestionRegister(router *gin.RouterGroup) {
	router.GET("/questions", QuestionList)
	router.GET("/questions/:id", QuestionByID)
	router.POST("/questions", CreateQuestions)
}

type QuestionsPOST struct {
	Email     string     `json:"email"`
	Token     string     `json:"token"`
	Questions []Question `json:"questions"`
}

type Question struct {
	Question      string `json:"question"`
	ApplicationID int    `json:"application_id"`
}

func CreateQuestions(c *gin.Context) {
	var questionsPOST QuestionsPOST
	err := c.BindJSON(&questionsPOST)
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	for _, question := range questionsPOST.Questions {
		_, err = model.SaveQuestions(model.Question{
			Question:      question.Question,
			Email:         questionsPOST.Email,
			ApplicationID: question.ApplicationID,
		})
	}

	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Item not found"))
	}
	c.JSON(http.StatusOK, nil)
}

func QuestionList(c *gin.Context) {
	question, err := model.FindManyQuestions()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.QuestionsSerializer{c, question}
	c.JSON(http.StatusOK, serializer.Response())
}

func QuestionByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	edition, err := model.FindEditionByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.EditionSerializer{c, edition}
	c.JSON(http.StatusOK, serializer.Response())
}
