FROM elixir:1.16-alpine AS build

RUN apk add --no-cache build-base git protobuf protobuf-dev bash

WORKDIR /app
ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config ./config
RUN mix local.hex --force && mix local.rebar --force && mix deps.get --only prod

COPY lib ./lib
COPY generated ./generated
RUN mix compile

FROM elixir:1.16-alpine
RUN apk add --no-cache openssl ncurses-libs
WORKDIR /app
ENV MIX_ENV=prod

COPY --from=build /app/_build/prod/rel/email_service ./

ENV REPLACE_OS_VARS=true \
    SMTP_RELAY=smtp.example.com \
    SMTP_USER=user@example.com \
    SMTP_PASS=secret \
    GRPC_PORT=50051

CMD ["bin/email_service", "start"]
