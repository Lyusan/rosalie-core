package news

import (
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
	news, err := FindManyNews()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := NewsArraySerializer{c, news}
	c.JSON(http.StatusOK, serializer.Response())
}

func NewsByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	news, err := FindNewsByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := NewsSerializer{c, news}
	c.JSON(http.StatusOK, serializer.Response())
}
