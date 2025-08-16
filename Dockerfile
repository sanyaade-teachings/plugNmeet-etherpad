FROM etherpad/etherpad:2.4.2

ARG ETHERPAD_PLUGINS="ep_sticky_attributes"

# Switch to root to install system packages
USER root

# Install LibreOffice. The --no-cache option handles cleanup automatically.
RUN apk update && \
    apk add --no-cache libreoffice libreoffice-common

# Install plugins, clean up cache, and fix permissions in a single layer.
# The base image already ran installDeps.sh, so we only need to add plugins.
# The chown is necessary because the RUN command executes as root.
RUN pnpm run install-plugins ${ETHERPAD_PLUGINS} && \
    pnpm store prune && \
    chown -R etherpad:etherpad .

# Switch back to the non-root user to run the application
USER etherpad
