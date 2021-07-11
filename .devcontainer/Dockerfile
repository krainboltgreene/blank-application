FROM buildpack-deps:focal-curl

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

SHELL ["/bin/bash", "-c"]

COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

RUN echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | tee /etc/apt/sources.list.d/erlang.list > /dev/null
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN /bin/bash /tmp/library-scripts/common-debian.sh "true" "${USERNAME}" "${USER_UID}" "${USER_GID}" "false" "true" "true"
RUN apt-get -y install --no-install-recommends docker-ce docker-ce-cli containerd.io
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN mkdir -p /usr/local/etc/vscode-dev-containers/
RUN chown codespace /opt/*

USER ${USERNAME}

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
RUN . $HOME/.asdf/asdf.sh && asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
RUN . $HOME/.asdf/asdf.sh && asdf install terraform 1.0.1
RUN . $HOME/.asdf/asdf.sh && asdf plugin add nodejs
RUN . $HOME/.asdf/asdf.sh && asdf install nodejs 16.4.0
RUN . $HOME/.asdf/asdf.sh && asdf plugin add erlang
RUN . $HOME/.asdf/asdf.sh && asdf install erlang 24.0.2
RUN . $HOME/.asdf/asdf.sh && asdf plugin add elixir
RUN . $HOME/.asdf/asdf.sh && asdf install elixir 1.12.1-otp-24
RUN . $HOME/.asdf/asdf.sh && asdf plugin add python
RUN . $HOME/.asdf/asdf.sh && asdf install python 3.9.6
RUN . $HOME/.asdf/asdf.sh && asdf plugin add gcloud
RUN . $HOME/.asdf/asdf.sh && asdf install gcloud 347.0.0
COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt

CMD [ "sleep", "infinity" ]

ARG DeveloperBuild

RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
