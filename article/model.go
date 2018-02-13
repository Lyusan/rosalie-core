package article

import (
	"time"

	"../utils"

	"github.com/jinzhu/gorm"
)

type Article struct {
	gorm.Model
	Title           string
	Content         string
	UpdateDate      time.Time
	PublicationDate time.Time

	MovieID int
}

func FindManyArticles() ([]Article, error) {
	var articles []Article
	db := utils.GetDB()
	err := db.Find(&articles).Error
	return articles, err
}

func FindArticleByID(id int) (Article, error) {
	var article Article
	db := utils.GetDB()
	err := db.First(&article, id).Error
	return article, err
}
