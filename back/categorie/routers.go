package categorie

import (
	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func CategorieRegister(router *gin.RouterGroup) {
	router.GET("/categorie", CategorieList)
	router.GET("/categorie/:id", CategorieByID)
}

func CategorieList(c *gin.Context) {
	categories, err := FindManyCategories()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := CategoriesSerializer{c, categories}
	c.JSON(http.StatusOK, serializer.Response())
}

func CategorieByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	categorie, err := FindCategorieByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := CategorieSerializer{c, categorie}
	c.JSON(http.StatusOK, serializer.Response())
}
