FROM buildpack-deps:focal-curl

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

SHELL ["/bin/bash", "-c"]

COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

RUN echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | tee /etc/apt/sources.list.d/erlang.list > /dev/null
RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
RUN /bin/bash /tmp/library-scripts/common-debian.sh "true" "${USERNAME}" "${USER_UID}" "${USER_GID}" "false" "true" "true"
RUN /bin/bash /tmp/library-scripts/docker-in-docker-debian.sh "true" "${USERNAME}" "true"
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN mkdir -p /usr/local/etc/vscode-dev-containers/
COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
# RUN chown codespace /opt/*

USER ${USERNAME}

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
RUN . $HOME/.asdf/asdf.sh && asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git && asdf install terraform 1.0.1 && asdf global terraform 1.0.1
RUN . $HOME/.asdf/asdf.sh && asdf plugin add nodejs && asdf install nodejs 16.4.0 && asdf global nodejs 16.4.0
RUN . $HOME/.asdf/asdf.sh && asdf plugin add erlang && asdf install erlang 24.0.2 && asdf global erlang 24.0.2
RUN . $HOME/.asdf/asdf.sh && asdf plugin add elixir && asdf install elixir 1.12.1-otp-24 && asdf global elixir 1.12.1-otp-24
RUN . $HOME/.asdf/asdf.sh && asdf plugin add python && asdf install python 3.9.6 && asdf global python 3.9.6
RUN . $HOME/.asdf/asdf.sh && asdf plugin add postgres
RUN . $HOME/.asdf/asdf.sh && asdf plugin add redis
RUN . $HOME/.asdf/asdf.sh && asdf plugin add gcloud && asdf install gcloud 347.0.0 && asdf global gcloud 347.0.0

VOLUME [ "/var/lib/docker" ]
CMD [ "sleep", "infinity" ]

# Setting the ENTRYPOINT to docker-init.sh will start up the Docker Engine
# inside the container "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
ARG DeveloperBuild
RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
