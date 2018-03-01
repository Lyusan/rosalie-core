.PHONY: all
all: rosalie

.PHONY: rosalie admin resetdb

rosalie:
	go build -v ./bin/rosalie.go
admin:
	go build -v ./bin/admin.go
resetdb:
	go build -v ./bin/resetdb.go

.PHONY: rosalie-static
rosalie-static: export CGO_ENABLED=0
rosalie-static: rosalie
	echo $$CGO_ENABLED

.PHONY: get
get:
	go get -v -d
