# Movie Recommendation API

Recommends movies based on user genre.

## Getting started

### Configuration

```sh
# Copy the environment configuration variables and
# ensure configuration variables are valid
$ cp .env.example .env.development
```

### Boot application
```sh
# boot without auto reloading after file changes
$ bundle exec puma -C config/puma.rb

# boot with auto reloading after file changes
$ rerun --dir app,config,lib "puma -C config/puma.rb -R config.ru"
```

### Deployment

```sh
# Apply changes to application variables e.g ENV vars from eu-cluster repo
$ kubectl apply -f api/api-deployment.yml

# drop into <instance> api-1519258495-j6h6k
$ kubectl exec <instance>  -i -t -- bash -il

# dockerize api service. {TAG} e.g latest

# Build the image
$ docker build -t registry/api:{TAG} .

# Push the image
$ docker push registry/api:{TAG}

# Run a container off the image
$ docker run -p 3002:8080 -e RACK_ENV=development registry/api:latest
```

### Testing

```sh
# Prepare the app for testing.
## Ensure environment validity of environment config file
$ cat .env.test

# Live testing specs during development
$ guard

# Testing with RSpec
$ rspec spec

# Acceptance testing with Cucumber
$ cucumber
```

#### Documentation

```sh
# OpenAPI API Documentation
GET /swagger.json

# Ruby Yard Documentation
$ rake doc:yard
```

#### Linting

```sh
# Rubocop
$ rake rubocop

# yard list undocumented
$ yard stats --list-undoc
```
