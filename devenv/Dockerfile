FROM centos:centos7
MAINTAINER Karl Stoney <me@karlstoney.com>

# Disable the annoying fastest mirror plugin
RUN sed -i '/enabled=1/ c\enabled=0' /etc/yum/pluginconf.d/fastestmirror.conf

# Set the environment up
ENV TERM xterm-256color

# Install the EPEL repository and do a yum update
# Install general shizzle we want
# rvm requirements
# vim requirements
RUN yum -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y -q update && \
    yum -y -q install \
    # Build tools
    make gcc-c++ cmake autoconf patch automake \
    # General Utils
    unzip jq git wget sudo which wemux tmux telnet httpie redis ansible libaio gettext bzip2 \
    # Build libraries
		libyaml-devel readline-devel zlib-devel libffi-devel openssl-devel libtool bison sqlite-devel \
    lua-devel luajit luajit-devel ctags tcl-devel libxml2-devel libxslt-devel \
    # All the pythons
    python34 python34-devel python34-pip python34-setuptools \
    python27 python27-devel python27-pip python27-setuptools \
    python-devel \
    # And the perls
    perl perl-devel perl-ExtUtils-ParseXS \
    perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed && \
    # Clean up
    yum -y -q clean all

# Compile VIM 8.0, like a boss
RUN cd /tmp && \
    git clone --depth=1 https://github.com/vim/vim.git && \
    cd vim && \
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib64/python2.7/config/ \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib64/python3.4/config-3.4m \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local && \
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim80 && \
    make install && \
    rm -rf /tmp/vim* && \
    update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1 && \
    update-alternatives --set editor /usr/bin/vim && \
    update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1 &&\
    update-alternatives --set vi /usr/bin/vim

# Add the profile scripts
COPY scripts/* /usr/local/bin/
RUN ln -s /usr/local/bin/devenv_shell.sh /etc/profile.d/devenv_shell.sh

RUN cd /usr/local/bin && \
		wget --quiet https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

RUN groupadd docker && \
    useradd -g docker docker && \
    echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /storage
WORKDIR /storage
RUN chown docker:docker /storage

# These modules are required when compiling npm modules that talk to oracle
ENV DL_HOST=http://ftp.riken.jp/Linux/cern/centos/7/cernonly/x86_64/Packages/
ENV BASE_ORACLE_VERSION=12.2
ENV ORACLE_VERSION=$BASE_ORACLE_VERSION.0.1.0-1
RUN cd /tmp && \
    wget -q $DL_HOST/oracle-instantclient$BASE_ORACLE_VERSION-basic-$ORACLE_VERSION.x86_64.rpm && \
    rpm -ivh oracle-instantclient$BASE_ORACLE_VERSION-basic-$ORACLE_VERSION.x86_64.rpm && \
    rm -f oracle-instantclient$BASE_ORACLE_VERSION-basic-$ORACLE_VERSION.x86_64.rpm

RUN cd /tmp && \
    wget -q $DL_HOST/oracle-instantclient$BASE_ORACLE_VERSION-devel-$ORACLE_VERSION.x86_64.rpm && \
    rpm -ivh oracle-instantclient$BASE_ORACLE_VERSION-devel-$ORACLE_VERSION.x86_64.rpm && \
    rm -f oracle-instantclient$BASE_ORACLE_VERSION-devel-$ORACLE_VERSION.x86_64.rpm

RUN pip3 install thefuck

USER docker
ENV HOME=/home/docker
ENV USER=docker

# Gem GPG2
RUN gpg2 --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# Add all our config files
COPY home $HOME/
RUN sudo chown -R docker:docker $HOME/

# Clone on the .vimrc stuff
RUN mkdir -p $HOME/.vim/vim-addons && \
    cd $HOME/.vim/vim-addons && \
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager && \
    git clone --depth=1 https://github.com/tpope/vim-fugitive && \
    git clone --depth=1 https://github.com/airblade/vim-gitgutter && \
    git clone --depth=1 https://github.com/editorconfig/editorconfig-vim && \
    git clone --depth=1 https://github.com/geekjuice/vim-spec && \
    git clone --depth=1 https://github.com/scrooloose/nerdtree && \
    git clone --depth=1 https://github.com/tomtom/tlib_vim && \
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-commenting && \
    git clone --depth=1 https://github.com/Chiel92/vim-autoformat && \
    git clone --depth=1 https://github.com/digitaltoad/vim-jade && \
    git clone --depth=1 https://github.com/tpope/vim-cucumber && \
		git clone --depth=1 https://github.com/tmhedberg/matchit && \
		git clone --depth=1 https://github.com/vim-scripts/restore_view.vim && \
		git clone --depth=1 https://github.com/vim-ruby/vim-ruby && \
		git clone --depth=1 https://github.com/Valloric/YouCompleteMe && \
		git clone --depth=1 https://github.com/ternjs/tern_for_vim && \
		git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim && \
		git clone --depth=1 https://github.com/digitaltoad/vim-pug && \
		git clone --depth=1 https://github.com/isRuslan/vim-es6 && \
		git clone --depth=1 https://github.com/othree/html5-syntax.vim && \
		git clone --depth=1 https://github.com/othree/html5.vim  && \
		git clone --depth=1 https://github.com/othree/javascript-libraries-syntax.vim && \
		git clone --depth=1 https://github.com/leafgarland/typescript-vim && \
		git clone --depth=1 https://github.com/HerringtonDarkholme/yats.vim && \
		git clone --depth=1 https://github.com/flazz/vim-colorschemes && \
		git clone --depth=1 https://github.com/scrooloose/syntastic && \
		git clone --depth=1 https://github.com/goatslacker/mango.vim && \
		git clone --depth=1 https://bitbucket.org/vimcommunity/vim-pi

# Compile YouCompleteMe
RUN cd $HOME/.vim/vim-addons/YouCompleteMe && \
    git config core.sparsecheckout true && \
   	git submodule update --init --recursive && \
		./install.sh

# RVM
ENV RVM_DIR=/usr/local/rvm
RUN sudo mkdir -p $RVM_DIR && \
    sudo chown docker:docker $RVM_DIR && \
    \curl -sSL https://get.rvm.io | bash -s -- --path $RVM_DIR

# NVM
ENV NVM_DIR=/usr/local/nvm
RUN sudo mkdir -p $NVM_DIR && \
    sudo chown docker:docker $NVM_DIR && \
    cd /tmp && \
		wget --quiet https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh && \
		chmod +x install.sh && \
		./install.sh

# Setup git-crypt
RUN cd /tmp && \
    git clone --depth=1 https://github.com/AGWA/git-crypt && \
    cd git-crypt && \
    make && \
    sudo make install PREFIX=/usr/local && \
    rm -rf /tmp/git-crypt*

# Terraform
ARG DEVENV_TERRAFORM_VERSION
RUN cd /tmp && \
    wget --quiet https://releases.hashicorp.com/terraform/$DEVENV_TERRAFORM_VERSION/terraform_$DEVENV_TERRAFORM_VERSION\_linux_amd64.zip && \
    unzip terraform_*.zip && \
    sudo mv terraform /usr/local/bin && \
    rm -rf *terraform*

# Download docker, the version that is compatible GKE
ARG DEVENV_DOCKER_VERSION
RUN cd /tmp && \
    wget --quiet https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-$DEVENV_DOCKER_VERSION.ce-1.el7.centos.x86_64.rpm && \
    sudo yum -y -q install docker-ce-*.rpm && \
    rm -rf docker*

# Download docker-compose, again the version that is compatible with GKE
ARG DEVENV_DOCKER_COMPOSE_VERSION
RUN cd /usr/local/bin && \
    sudo wget --quiet https://github.com/docker/compose/releases/download/$DEVENV_DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` && \
    sudo mv docker-compose-* docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    sudo ln -s /usr/local/bin/docker-compose /bin/docker-compose

# Setup GCloud CLI
ARG DEVENV_GCLOUD_VERSION
ENV CLOUDSDK_INSTALL_DIR /usr/lib64/google-cloud-sdk
ENV CLOUD_SDK_REPO cloud-sdk-trusty
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
COPY gcloud.repo /etc/yum.repos.d/
RUN sudo yum -y -q update && \
    sudo yum -y -q install google-cloud-sdk-$DEVENV_GCLOUD_VERSION* && \
    sudo yum -y -q clean all
RUN sudo mkdir -p /etc/gcloud/keys

# Setup Kubernetes CLI
ARG DEVENV_KUBECTL_VERSION
RUN cd /usr/local/bin && \
    sudo wget --quiet https://storage.googleapis.com/kubernetes-release/release/v$DEVENV_KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    sudo chmod +x kubectl

# Disable google cloud auto update... we should be pushing a new agent container
RUN sudo gcloud config set --installation component_manager/disable_update_check true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set core/disable_usage_reporting true

# Add Ruby and RVM
ARG DEVENV_RUBY_VERSION
RUN /bin/bash -l -c "rvm install $DEVENV_RUBY_VERSION && rvm cleanup all"
RUN /bin/bash -l -c "gem install bundler bundler-audit"

# Add NodeJS
ARG DEVENV_NODEJS_VERSION
RUN /bin/bash -l -c "nvm install $DEVENV_NODEJS_VERSION && nvm use $DEVENV_NODEJS_VERSION && nvm cache clear"
RUN /bin/bash -l -c "npm config set package-lock false"

# Gotta manually update npm due to: https://github.com/creationix/nvm/issues/1637
ARG DEVENV_NPM_VERSION
ENV NPM_DIR=$NVM_DIR/versions/node/v$DEVENV_NODEJS_VERSION/lib/node_modules/npm
RUN rm -rf $NPM_DIR && \
    mkdir $NPM_DIR && \
    curl -sL https://github.com/npm/npm/archive/v$DEVENV_NPM_VERSION.tar.gz | tar xz -C $NPM_DIR --strip-components=1 && \
    chown -R docker:docker $NPM_DIR

RUN /bin/bash -l -c "npm install -g --depth=0 --no-summary --quiet grunt-cli npm-check-updates nsp depcheck jshint hawkeye-scanner  && npm cache clean --force"

# Add GoLANG
ARG GOLANG_VERSION
RUN cd /tmp && \
    wget --quiet https://dl.google.com/go/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar xf go$GOLANG_VERSION.linux-amd64.tar.gz && \
    sudo mv go /usr/local && \
    rm -f go*

ENV GOROOT /usr/local/go
ENV GOPATH /storage/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN go get -u github.com/golang/lint/golint
RUN go get -u github.com/golang/dep/cmd/dep

# Fix all permissions
ENTRYPOINT ["/bin/bash", "--login"]
CMD ["/usr/local/bin/entrypoint.sh"]
VOLUME /home/docker

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY versions.sh /usr/local/bin/versions.sh
RUN /bin/bash --login -c "/usr/local/bin/versions.sh | sudo dd of=/.devenv-versions"
