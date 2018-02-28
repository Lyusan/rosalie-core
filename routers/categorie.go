package routers

import (
	"../model"
	"../serializer"

	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func CategorieRegister(router *gin.RouterGroup) {
	router.GET("/categories", CategorieList)
	router.GET("/categories/:id", CategorieByID)
}

func CategorieList(c *gin.Context) {
	categories, err := model.FindManyCategories()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.CategoriesSerializer{c, categories}
	c.JSON(http.StatusOK, serializer.Response())
}

func CategorieByID(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	categorie, err := model.FindCategorieByID(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.CategorieSerializer{c, categorie}
	c.JSON(http.StatusOK, serializer.Response())
}
