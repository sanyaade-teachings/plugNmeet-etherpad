FROM etherpad/etherpad:1.9.1

ARG ETHERPAD_PLUGINS="ep_disable_chat ep_sticky_attributes ep_themes"

USER root
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get -qq update && \
    apt-get -qq --no-install-recommends install libreoffice && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install --no-save --legacy-peer-deps ${ETHERPAD_PLUGINS} && \
    rm -rf ~/.npm

USER etherpad
