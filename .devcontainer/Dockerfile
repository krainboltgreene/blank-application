FROM buildpack-deps:focal-curl

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV DOCKER_BUILDKIT=1

COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

RUN echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | tee /etc/apt/sources.list.d/erlang.list > /dev/null
RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
RUN /bin/bash /tmp/library-scripts/common-debian.sh "true" "${USERNAME}" "${USER_UID}" "${USER_GID}" "false" "true" "true"
RUN /bin/bash /tmp/library-scripts/docker-debian.sh "true" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}" "false"
RUN /bin/bash /tmp/library-scripts/user-debian.sh "${USERNAME}" "${PATH}"
RUN /bin/bash /tmp/library-scripts/github-debian.sh
RUN /bin/bash /tmp/library-scripts/postgresql-debian.sh
RUN /bin/bash /tmp/library-scripts/nodejs-debian.sh
RUN /bin/bash /tmp/library-scripts/erlang-debian.sh
RUN /bin/bash /tmp/library-scripts/elixir-debian.sh
RUN apt-get -qq autoremove -y
RUN apt-get -qq clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN mkdir -p /usr/local/etc/vscode-dev-containers/

COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt

RUN chsh -s /bin/zsh ${USERNAME}

USER ${USERNAME}
ENV SHELL=/bin/zsh
SHELL [ "/bin/zsh", "-c" ]


# Setting the ENTRYPOINT to docker-init.sh will start up the Docker Engine
# inside the container "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh"]
VOLUME [ "/var/lib/docker" ]
CMD [ "sleep", "infinity" ]

ARG DeveloperBuild
RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
