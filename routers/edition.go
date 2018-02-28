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
	router.GET("/editions/:id/awards", EditionListAward)
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
	id, err := strconv.ParseUint(c.Param("id"), 10, 16)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	edition, err := model.FindEditionByID(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.EditionSerializer{c, edition}
	c.JSON(http.StatusOK, serializer.Response())
}

func EditionListAward(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, errors.New("Expect an integer for param id"))
		return
	}
	awards, err := model.FindEditionAwards(uint(id))
	if err != nil {
		c.JSON(http.StatusNotFound, errors.New("Item not found"))
		return
	}
	serializer := serializer.AwardsSerializer{c, awards}
	c.JSON(http.StatusOK, serializer.Response())

}
