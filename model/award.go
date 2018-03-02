package model

import (
	"../utils"

	"github.com/bradfitz/slice"
	"github.com/jinzhu/gorm"
)

type Award struct {
	gorm.Model
	NumberNominees int

	Applications []Application

	CategorieID uint
	EditionID   uint
}

func FindManyAwards() ([]Award, error) {
	var awards []Award
	db := utils.GetDB()
	err := db.Find(&awards).Error
	return awards, err
}

func FindAwardByID(id uint) (Award, error) {
	var award Award
	db := utils.GetDB()
	err := db.First(&award, id).Error
	return award, err
}

func (s *Award) FindRelatedCandidates() []Application {
	var applications []Application
	db := utils.GetDB()
	db.Find(s).Related(&applications)
	return applications
}

func (s *Award) FindRelatedNominees() []Application {
	var applications []Application
	var nominees []Application
	db := utils.GetDB()
	db.Find(s).Related(&applications)
	if len(applications) > 0 {
		// TODO use ORDER BY SQL
		slice.Sort(applications[:], func(i, j int) bool {
			return applications[i].VotesNominees > applications[j].VotesNominees
		})
		index := 0
		currentVoteNomineesValue := applications[index].VotesNominees
		// TODO REFACTOR
		for ; currentVoteNomineesValue > 0 && index < len(applications) && (currentVoteNomineesValue == applications[index].VotesNominees || index < s.NumberNominees); index++ {
			nominees = append(nominees, applications[index])
			currentVoteNomineesValue = applications[index].VotesNominees
		}
	}
	return nominees
}

func (s *Award) FindRelatedWinner() []Application {
	var applications []Application
	var winner []Application
	db := utils.GetDB()
	db.Find(s).Related(&applications)
	if len(applications) > 0 {
		// TODO use ORDER BY SQL
		slice.Sort(applications[:], func(i, j int) bool {
			return applications[i].VotesWinner > applications[j].VotesWinner
		})
		index := 0
		currentVoteWinnerValue := applications[index].VotesWinner
		// TODO REFACTOR
		for ; currentVoteWinnerValue > 0 && index < len(applications) && currentVoteWinnerValue == applications[index].VotesWinner; index++ {
			winner = append(winner, applications[index])
			currentVoteWinnerValue = applications[index].VotesWinner
		}
	}
	return winner
}

func (s *Award) FindRelatedCategorie() Categorie {
	var categorie Categorie
	db := utils.GetDB()
	db.First(&categorie, s.CategorieID)
	return categorie
}

func (s *Award) FindRelatedEdition() Edition {
	var edition Edition
	db := utils.GetDB()
	db.First(&edition, s.EditionID)
	return edition
}
