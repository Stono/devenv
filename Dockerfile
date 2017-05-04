FROM centos:centos7
MAINTAINER Karl Stoney <me@karlstoney.com>

# Disable the annoying fastest mirror plugin
RUN sed -i '/enabled=1/ c\enabled=0' /etc/yum/pluginconf.d/fastestmirror.conf

# Set the environment up
ENV TERM xterm-256color
RUN mkdir -p /storage
WORKDIR /storage

# Install the EPEL repository and do a yum update
RUN yum -y -q install http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm && \ 
    yum -y -q update && \
    yum -y -q install gcc-c++ make git python-setuptools tar wget curl sudo which passwd vim cmake python-devel && \
    yum -y -q clean all

# Clone on the .vimrc stuff
RUN mkdir -p /root/.vim/vim-addons && \
    cd /root/.vim/vim-addons && \
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

RUN cd /root/.vim/vim-addons/YouCompleteMe && \
   	git submodule update --init --recursive && \
		./install.sh
 
# Add all our config files
COPY home /root/


# Add the profile scripts 
COPY scripts/* /usr/local/bin/
RUN ln -s /usr/local/bin/devenv_shell.sh /etc/profile.d/devenv_shell.sh

# NodeJS pre-reqs
RUN cd /tmp && \
		wget --quiet https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh && \
		chmod +x install.sh && \
		./install.sh && \
		rm install.sh

# Ruby pre-reqs
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN mkdir -p /root/.bundle

# Add NodeJS
RUN /bin/bash -l -c "nvm install 7.9"

# Add Ruby and RVM
RUN /bin/bash -l -c "rvm install 2.4"
RUN /bin/bash -l -c "gem install bundler"

# Install ansible
RUN yum -y -q install ansible-2.3.0*
