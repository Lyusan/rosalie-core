package routers

import (
	"../model"
	"../serializer"

	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func MovieRegister(router *gin.RouterGroup) {
	router.GET("/movies", MovieList)
	router.GET("/movies/:id", MovieByID)
	router.GET("/movies/:id/articles", ListMoviesArticles)
}

func MovieList(c *gin.Context) {
	movie, err := model.FindManyMovies()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.MoviesSerializer{c, movie}
	c.JSON(http.StatusOK, serializer.Response())
}

func MovieByID(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	movie, err := model.FindMovieByID(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.MovieSerializer{c, movie}
	c.JSON(http.StatusOK, serializer.Response())
}

func ListMoviesArticles(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	articles, err := model.FindMovieRelatedArticles(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.ArticlesSerializer{c, articles}
	c.JSON(http.StatusOK, serializer.Response())
}
