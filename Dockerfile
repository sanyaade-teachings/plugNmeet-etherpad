FROM etherpad/etherpad:1.9.7

ARG ETHERPAD_PLUGINS="ep_sticky_attributes ep_themes"

USER root
RUN apk update && \
    apk add --no-cache libreoffice libreoffice-common && \
    rm -rf /var/cache/apk/*

RUN npm install --package-lock-only --no-save --legacy-peer-deps -C src ${ETHERPAD_PLUGINS} && \
    rm -rf ~/.npm

USER etherpad
