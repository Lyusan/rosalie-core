package news

import "github.com/gin-gonic/gin"

type NewsResponse struct {
	ID              uint   `json:"-"`
	Title           string `json:"title"`
	Author          string `json:"author"`
	PublicationDate string `json:"publicationDate"`
	UpdatedDate     string `json:"updateDate"`
	Summary         string `json:"summary"`
	Content         string `json:"content"`
}

type NewsSerializer struct {
	C *gin.Context
	News
}

func (s *NewsSerializer) Response() NewsResponse {
	response := NewsResponse{
		ID:              s.ID,
		Title:           s.Title,
		PublicationDate: s.PublicationDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		UpdatedDate:     s.UpdateDate.UTC().Format("2006-01-02T15:04:05.999Z"),
		Summary:         s.Summary,
		Content:         s.Content,
	}
	return response
}

type NewsArraySerializer struct {
	C         *gin.Context
	NewsArray []News
}

func (s *NewsArraySerializer) Response() []NewsResponse {
	response := []NewsResponse{}
	for _, news := range s.NewsArray {
		serializer := NewsSerializer{s.C, news}
		response = append(response, serializer.Response())
	}
	return response
}
