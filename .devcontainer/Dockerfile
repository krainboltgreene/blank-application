ARG VARIANT="buster"
FROM buildpack-deps:${VARIANT}-curl

ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

SHELL ["/bin/bash", "-c"]

COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add - && \
	echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | tee /etc/apt/sources.list.d/rabbitmq.list

RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true"
RUN apt-get install -y --no-install-recommends curl git
RUN apt-get install -y --no-install-recommends dirmngr gpg gawk
RUN apt-get install -y --no-install-recommends esl-erlang
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

USER ${USERNAME}

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
RUN . $HOME/.asdf/asdf.sh && asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
RUN . $HOME/.asdf/asdf.sh && asdf install terraform latest
RUN . $HOME/.asdf/asdf.sh && asdf plugin add nodejs
RUN . $HOME/.asdf/asdf.sh && asdf install nodejs latest
RUN . $HOME/.asdf/asdf.sh && asdf plugin add elixir
RUN . $HOME/.asdf/asdf.sh && asdf install elixir latest

CMD [ "sleep", "infinity" ]

ARG DeveloperBuild

RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
