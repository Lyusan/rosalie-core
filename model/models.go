package model

func GetModels() []interface{} {
	return []interface{}{&Application{}, &Article{}, &Award{}, &Categorie{}, &Edition{}, &Movie{}, &News{}, &Person{}, &Question{}, &Vote{}}
}
