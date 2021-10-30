FROM buildpack-deps:focal-curl

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash
ENV DOCKER_BUILDKIT=1

SHELL ["/bin/bash", "-c"]

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
RUN chsh -s /bin/zsh ${USERNAME}
USER ${USERNAME}
ENV SHELL=/bin/zsh
SHELL [ "/bin/zsh", "-c" ]
# RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git && asdf install terraform 1.0.1 && asdf global terraform 1.0.1
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add nodejs && asdf install nodejs 16.4.0 && asdf global nodejs 16.4.0
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add erlang && asdf install erlang 24.0.2 && asdf global erlang 24.0.2
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add elixir && asdf install elixir 1.12.1-otp-24 && asdf global elixir 1.12.1-otp-24
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add python && asdf install python 3.9.6 && asdf global python 3.9.6
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add postgres && asdf install postgres 13.2
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add redis && asdf install redis 6.2.1
# RUN . $HOME/.asdf/asdf.sh && asdf plugin add gcloud && asdf install gcloud 347.0.0 && asdf global gcloud 347.0.0

COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
COPY docker-entrypoint.sh docker-entrypoint.sh

VOLUME [ "/var/lib/docker" ]
CMD [ "sleep", "infinity" ]

# Setting the ENTRYPOINT to docker-init.sh will start up the Docker Engine
# inside the container "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
# ENTRYPOINT [ "./docker-entrypoint.sh" ]
ENTRYPOINT [ "/usr/local/share/docker-init.sh"]
ARG DeveloperBuild
RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
