FROM tmaczukin/debian:jessie
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

RUN apt-get update && apt-get upgrade -y # update_20150724023300
RUN apt-get install -y nginx git-core build-essential zlib1g-dev libssl-dev libreadline-dev \
                       libyaml-dev libxml2-dev libxslt-dev libffi-dev supervisor && \
                       apt-get clean

RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv; \
    mkdir -p /usr/local/rbenv/plugins; \
    git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build; \
    cd /usr/local/rbenv/plugins/ruby-build; \
    ./install.sh

RUN addgroup rbenv; \
    chown :rbenv -R /usr/local/rbenv; \
    chmod g+w -R /usr/local/rbenv

RUN echo "export PATH=\"/usr/local/rbenv/bin:\$PATH\"" >> /etc/rbenvrc; \
    echo "eval \"\$(rbenv init -)\"" >> /etc/rbenvrc; \
    echo "gem: --no-rdoc --no-ri" >> /etc/skel/.gemrc; \
    echo "gem: --no-rdoc --no-ri" >> /root/.gemrc; \
    echo "source /etc/rbenvrc" >> /etc/skel/.bashrc ;\
    echo "source /etc/rbenvrc" >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc

RUN su root -c "source /etc/rbenvrc && rbenv install 2.2.0 && rbenv global 2.2.0 && gem install bundler"

COPY . /usr/local/lib/http-router

RUN su root -c "source /etc/rbenvrc && cd /usr/local/lib/http-router && bundle install"

ENTRYPOINT ["/usr/local/lib/http-router/init"]
CMD ["start"]
