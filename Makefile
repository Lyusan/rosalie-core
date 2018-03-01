.PHONY: all
all: rosalie

.PHONY: rosalie

rosalie:
	go build -v rosalie/main.go
admin:
	go build -v admin/main.go
resetdb:
	go build -v admin/main.go

.PHONY: rosalie-static
rosalie-static: export CGO_ENABLED=0
rosalie-static: rosalie
	echo $$CGO_ENABLED

.PHONY: get
get:
	go get -v -d
