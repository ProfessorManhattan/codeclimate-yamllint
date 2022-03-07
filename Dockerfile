FROM alpine:3

ENV container docker

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk --no-cache add --virtual build-dependencies \
      py3-pip~=20 \
  && apk --no-cache add \
      python3~=3 gawk~=5 \
  && pip3 install --no-cache-dir \
      "yamllint==1.*" \
  && apk del build-dependencies \
  && find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
  && find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

# Now copying the codeclimate deps
WORKDIR /usr/src/app/

COPY engine.json /

RUN adduser --uid 9000 --gecos "" --disabled-password app

COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-yamllint"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="Code climate engine for Yaml Lint"
LABEL org.opencontainers.image.documentation="https://gitlab.com/megabyte-labs/dockerfile/codeclimate/yamllint/-/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/dockerfile/codeclimate/yamllint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="code-climate"
