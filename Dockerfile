FROM elixir:1.12-slim

WORKDIR /src/app

COPY . .
RUN mix local.hex --force && mix deps.get && mix release

ENV PATH "$PATH:/src/app/_build/dev/rel/tofu/bin"
