FROM marcelocg/phoenix:latest

RUN apt-get update && apt-get install -y

EXPOSE 4000
ADD . /src

WORKDIR /src

RUN npm install elm \
    && chmod +x ./node_modules/elm/binwrappers/elm-make \
    && npm install

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix deps.compile \
    && npm install \
    && mix credo --strict \
    && npm run build
