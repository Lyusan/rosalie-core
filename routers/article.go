package routers

import (
	"../model"
	"../serializer"

	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func ArticleRegister(router *gin.RouterGroup) {
	router.GET("/articles", ArticleList)
	router.GET("/articles/:id", ArticleByID)
}

func ArticleList(c *gin.Context) {
	article, err := model.FindManyArticles()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.ArticlesSerializer{c, article}
	c.JSON(http.StatusOK, serializer.Response())
}

func ArticleByID(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	article, err := model.FindArticleByID(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.ArticleSerializer{c, article}
	c.JSON(http.StatusOK, serializer.Response())
}
