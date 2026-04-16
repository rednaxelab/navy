FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/kinoite-main:latest

RUN mkdir -p /var/roothome

# Bake in Homebrew (same method as Bazzite/Aurora/Bluefin)
COPY --from=ghcr.io/ublue-os/brew:latest /system_files/ /tmp/brew_files/
RUN cp -a /tmp/brew_files/. / && \
    rm -rf /tmp/brew_files

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
