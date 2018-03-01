package serializer

import (
	"../model"
	"github.com/gin-gonic/gin"
)

type Award struct {
	ID            uint          `json:"id"`
	CategorieName string        `json:"categorie_name"`
	CategorieDesc string        `json:"categorie_desc"`
	Candidates    []Application `json:"candidates"`
	Nominees      []Application `json:"nominees"`
	Winner        []Application `json:"winner"`
}

type AwardSerializer struct {
	C *gin.Context
	model.Award
}

func (s *AwardSerializer) Response() Award {
	candidatesSerializer := ApplicationsSerializer{s.C, s.FindRelatedCandidates()}
	candidates := candidatesSerializer.Response()
	nomineesSerializer := ApplicationsSerializer{s.C, s.FindRelatedNominees()}
	nominees := nomineesSerializer.Response()
	winnerSerializer := ApplicationsSerializer{s.C, s.FindRelatedWinner()}
	winner := winnerSerializer.Response()
	response := Award{
		ID:            s.ID,
		CategorieName: s.FindRelatedCategorie().Name,
		CategorieDesc: s.FindRelatedCategorie().Description,
		Candidates:    candidates,
		Nominees:      nominees,
		Winner:        winner,
	}
	return response
}

type AwardsSerializer struct {
	C      *gin.Context
	Awards []model.Award
}

func (s *AwardsSerializer) Response() []Award {
	response := []Award{}
	for _, award := range s.Awards {
		serializer := AwardSerializer{s.C, award}
		response = append(response, serializer.Response())
	}
	return response
}
