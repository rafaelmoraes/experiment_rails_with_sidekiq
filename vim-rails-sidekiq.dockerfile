FROM rmoraes/vim-ruby
LABEL version="0.0.2"
LABEL name="rmoraes/vim-rails-sidekiq"
LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

USER root

ENV HOME /root

ENV SCRIPT_INSTALL_RAILS_URL https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_ruby_on_rails.sh

RUN apt update && \
    apt install --no-install-recommends -y \
	apt-transport-https \
	ca-certificates \
	gnupg && \
    apt upgrade -y

COPY . /tmp/app

# Install rails
RUN cd /tmp/app && \
    curl -o install_ruby_on_rails.sh $SCRIPT_INSTALL_RAILS_URL && \
    chmod +x install_ruby_on_rails.sh
RUN cd /tmp/app && \
    ./install_ruby_on_rails.sh

# Fix bin path
RUN ln -fs $HOME/.rbenv/shims/rubocop /usr/bin/rubocop
RUN ln -fs $HOME/.rbenv/shims/brakeman /usr/bin/brakeman
RUN ln -fs $HOME/.rbenv/shims/solargraph /usr/bin/solargraph
RUN ln -fs $HOME/.rbenv/shims/solargraph-runtime /usr/bin/solargraph-runtime

#Cleanup
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/development"]
WORKDIR /development

EXPOSE 3000
