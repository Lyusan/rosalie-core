package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Edition struct {
	ID             uint   `json:"id"`
	Name           string `json:"name"`
	Localisation   string `json:"localisation"`
	StartDate      string `json:"start_date"`
	NominationDate string `json:"nomination_date"`
	RewardingDate  string `json:"rewarding_date"`
	EndDate        string `json:"end_date"`
}

type EditionSerializer struct {
	C *gin.Context
	model.Edition
}

func (s *EditionSerializer) Response() Edition {
	response := Edition{
		ID:             s.ID,
		Name:           s.Name,
		Localisation:   s.Localisation,
		StartDate:      s.StartDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		NominationDate: s.NominationDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		RewardingDate:  s.RewardingDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		EndDate:        s.EndDate.UTC().Format("2006-01-02T15:04:05.999Z"),
	}
	return response
}

type EditionsSerializer struct {
	C        *gin.Context
	Editions []model.Edition
}

func (s *EditionsSerializer) Response() []Edition {
	response := []Edition{}
	for _, edition := range s.Editions {
		serializer := EditionSerializer{s.C, edition}
		response = append(response, serializer.Response())
	}
	return response
}
