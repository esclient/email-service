FROM elixir:1.18-alpine AS build

RUN apk add --no-cache \
    openssl \
    ncurses-libs \
    libgcc \
    libstdc++

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod && \
    mix deps.compile

COPY lib lib
COPY grpc grpc
COPY priv priv
RUN mix compile

ENV MIX_ENV=prod
RUN mix release --overwrite

FROM elixir:1.18-alpine AS release

RUN apk add --no-cache \
    openssl \
    ncurses-libs \
    libgcc \
    libstdc++

WORKDIR /app
COPY --from=build /app/_build/prod/rel/emailservice ./

ENTRYPOINT ["bin/emailservice"]
CMD ["start"]
