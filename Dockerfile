FROM etherpad/etherpad:2.2.6

ARG ETHERPAD_PLUGINS="ep_sticky_attributes ep_themes"

USER root
RUN apk update && \
    apk add --no-cache libreoffice libreoffice-common && \
    rm -rf /var/cache/apk/*

RUN bin/installDeps.sh && rm -rf ~/.npm && pnpm run install-plugins ${ETHERPAD_PLUGINS}
RUN chown etherpad:etherpad -R .

USER etherpad
