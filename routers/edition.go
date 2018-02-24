package routers

import (
	"../model"
	"../serializer"

	"errors"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func EditionRegister(router *gin.RouterGroup) {
	router.GET("/editions", EditionList)
	router.GET("/editions/:id", EditionByID)
}

func EditionList(c *gin.Context) {
	edition, err := model.FindManyEditions()
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.EditionsSerializer{c, edition}
	c.JSON(http.StatusOK, serializer.Response())
}

func EditionByID(c *gin.Context) {
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
