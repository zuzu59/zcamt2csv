# Zuzubank

A minimal app for converting an xml file in campt format to csv.

## Usage

```
cd app
gem install bundler
bundle install
bundle exec ruby app.rb
```

then visit (http://localhost:4567/)

## Docker

For a production environment it is probably better to use docker. 
The provided `Dockerfile` should be good enough but it requires a reverse
http proxy for ssl. An example `docker-compose.yml` file is provided but
it is based on my own [traefik setup](https://github.com/multiscan/dev_traefik) 
and needs to be modified to suit your setup. 

## TODO
 - [ ] authentication
 - [ ] form autenticity token
