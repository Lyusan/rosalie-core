# Rosalie

The backend of the rosalie project, written in [golang].

## How to build

There is a `Makefile` for simple commands that you'll want to run often.

For building, just run:
```bash
# `make get` is for retrieving all dependencies without installing them
# `make all` compiles the binary and prints all packages compiled during the operation.
make get all
```

For building a full static binary, without linking to any of the platform libraries, please use
the `make rosalie-static` task.

## How to run

You'll need postgresql up and running, don't forget to create a DB and to have the correct access
credentials.

> Note: for now, it seems the app must be run twice in order to create the db schema.

The application looks in it's environment for the DB url, credentials, and the port. You can
either export them in your shell, or simply write them in an `.env` file, loaded by [godotenv].

### Variables needed by the applications

|Variable name|Description|Required|
|-------------|-----------|--------|
|`DB_NAME`|The name of the database|:heavy_check_mark:|
|`DB_USERNAME`|Username used for the database|:heavy_check_mark:️|
|`DB_PASSWORD`|Password used for the database|:heavy_check_mark: [^1]|
|`DB_HOST`|Can be an url (`locahost`), or a path to a unix socket (`/var/run/postgres`)|defaults to `localhost`|
|`PORT`|Port the application will listen to|defaults to `4000`|



[^1]: can be empty if no password is required for login
[golang]: https://golang.org
[godotenv]: https://github.com/joho/godotenv
[pipeline status]: https://git.036.fr/rosalie/core/badges/master/pipeline.svg
[pipeline]: https://git.036.fr/rosalie/core/commits/master
