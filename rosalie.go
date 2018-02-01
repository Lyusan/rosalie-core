package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"

	"github.com/go-pg/pg"
)

type Edition struct {
	ID             int64
	Name           string
	Localisation   string
	StartDate      time.Time
	NominationDate time.Time
	RewardingDate  time.Time
	EndDate        time.Time
}

func (e Edition) String() string {
	return fmt.Sprintf("Edition<%d %s>", e.ID, e.Name)
}

type Award struct {
	ID          int64
	CategorieID int64
	Categorie   *Categorie
	EditionID   int64
	Edition     *Edition
}

func (a Award) String() string {
	return fmt.Sprintf("Award<%d %d %d>", a.ID, a.CategorieID, a.EditionID)
}

type Categorie struct {
	ID          int64
	Name        string
	Description string
}

func (c Categorie) String() string {
	return fmt.Sprintf("Award<%d %s %s>", c.ID, c.Name, c.Description)
}

func ExampleDB_Model() {
	db := pg.Connect(&pg.Options{
		User:     "postgres",
		Password: "root",
		Database: "rosalie",
	})

	err := createSchema(db)
	if err != nil {
		panic(err)
	}

	edition2018 := &Edition{
		Name:           "2018",
		Localisation:   "France",
		StartDate:      time.Now(),
		NominationDate: time.Now(),
		EndDate:        time.Now(),
		RewardingDate:  time.Now(),
	}
	err = db.Insert(edition2018)
	if err != nil {
		panic(err)
	}
	categorie1 := &Categorie{
		Name:        "Meilleure Interprétation,",
		Description: "",
	}

	err = db.Insert(categorie1)
	if err != nil {
		panic(err)
	}
	categorie2 := &Categorie{
		Name:        "Meilleur Espoir",
		Description: "",
	}
	err = db.Insert(categorie2)

	if err != nil {
		panic(err)
	}

	award1 := &Award{
		CategorieID: categorie1.ID,
		EditionID:   edition2018.ID,
	}
	err = db.Insert(award1)
	if err != nil {
		panic(err)
	}
	award2 := &Award{
		CategorieID: categorie2.ID,
		EditionID:   edition2018.ID,
	}
	err = db.Insert(award2)
	if err != nil {
		panic(err)
	}
	// Select user by primary key.
	categorie := Categorie{ID: categorie1.ID}
	err = db.Select(&categorie)
	if err != nil {
		panic(err)
	}

	// Select all users.
	var categories []Categorie
	err = db.Model(&categories).Select()
	if err != nil {
		panic(err)
	}

	// Select story and associated author in one query.
	var award Award
	err = db.Model(&award).
		Column("award.*", "Edition").
		Where("award.id = ?", award1.ID).
		Select()
	if err != nil {
		panic(err)
	}

	fmt.Println(categorie)
	fmt.Println(categories)
	fmt.Println(award)
	// Output: User<1 admin [admin1@admin admin2@admin]>
	// [User<1 admin [admin1@admin admin2@admin]> User<2 root [root1@root root2@root]>]
	// Story<1 Cool story User<1 admin [admin1@admin admin2@admin]>>
}

func createSchema(db *pg.DB) error {
	for _, model := range []interface{}{&Edition{}, &Categorie{}, &Award{}} {
		err := db.CreateTable(model, nil)
		if err != nil {
			return err
		}
	}
	return nil
}
func main() {
	//ExampleDB_Model()
	router := gin.Default()
	v1 := router.Group("/v1")
	{
		v1.GET("/example", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{"status": http.StatusOK, "message": "Hello world"})
		})
	}
	router.Run()

}
