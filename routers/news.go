package routers

import (
	"../model"
	"../serializer"

	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func NewsRegister(router *gin.RouterGroup) {
	router.GET("/news", NewsList)
	router.GET("/news/:id", NewsByID)
}

func NewsList(c *gin.Context) {
	news, err := model.FindManyNews()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.NewsArraySerializer{c, news}
	c.JSON(http.StatusOK, serializer.Response())
}

func NewsByID(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	news, err := model.FindNewsByID(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.NewsSerializer{c, news}
	c.JSON(http.StatusOK, serializer.Response())
}
