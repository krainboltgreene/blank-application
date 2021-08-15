ARG VARIANT="buster"
FROM buildpack-deps:${VARIANT}-curl

ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

SHELL ["/bin/bash", "-c"]

COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add - && \
	echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | tee /etc/apt/sources.list.d/rabbitmq.list

RUN /bin/bash /tmp/library-scripts/common-debian.sh "true" "${USERNAME}" "${USER_UID}" "${USER_GID}" "false" "true" "true"
RUN apt-get -y install --no-install-recommends curl \
    dirmngr \
    gpg \
    gawk \
    build-essential \
    autoconf \
    m4 \
    libncurses5-dev \
    libwxgtk3.0-gtk3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev \
    xsltproc \
    fop \
    libxml2-utils \
    libncurses-dev \
    openjdk-11-jdk \
    software-properties-common \
    libsecret-1-dev \
    gdb \
    ca-certificates \
    inotify-tools
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN mkdir -p /usr/local/etc/vscode-dev-containers/

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
COPY first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt

CMD [ "sleep", "infinity" ]

ARG DeveloperBuild

RUN if [ -z $DeveloperBuild ]; then \
        echo "not including debugger" ; \
    else \
        curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg ; \
    fi
