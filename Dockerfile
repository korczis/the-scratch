FROM mhart/alpine-node:8

ENV ELIXIR_VERSION 1.5.0-rc.1
ENV GLIBC_VERSION 2.25-r0

EXPOSE 4000

RUN apk --update add \
    git \
    wget \
    curl \
    erlang \
    erlang-dev \
    erlang-kernel \
    erlang-hipe \
    erlang-compiler \
    erlang-stdlib \
    erlang-erts \
    erlang-tools \
    erlang-syntax-tools \
    erlang-sasl \
    erlang-crypto \
    erlang-public-key \
    erlang-ssl \
    erlang-ssh \
    erlang-asn1 \
    erlang-inets \
    erlang-inets \
    erlang-mnesia \
    erlang-odbc \
    erlang-erl-interface \
    erlang-parsetools \
    erlang-eunit \
    ghc \
    make \
    tree \
    && rm -rf /var/cache/apk/*

# Download and install glibc
RUN curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
  curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
  curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
  apk add glibc-bin.apk glibc.apk && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

RUN wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
      mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
      unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
      rm Precompiled.zip && \
      rm -rf /var/cache/apk/*

ADD . /src
WORKDIR /src

RUN npm install elm \
    && chmod +x ./node_modules/elm/binwrappers/elm-make \
    && tree /src/node_modules \
    && npm install

# Add local node module binaries to PATH
ENV PATH $PATH:/usr/bin:/usr/lib/node_modules/elm/binwrappers:/src/node_modules/.bin:/opt/elixir-${ELIXIR_VERSION}/bin

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix deps.compile \
    && npm install \
    && npm run build
