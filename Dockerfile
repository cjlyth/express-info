FROM dockerfile/nodejs
MAINTAINER  Christopher Lyth <cjlyth@gmail.com>
ENTRYPOINT ["/usr/bin/env"]

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX

# supervisor
RUN ["mkdir", "-p", "/var/log/supervisor"]
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qqy supervisor 2> /var/log/supervisor/install.log
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# /supervisor


ENV NPM_CONFIG_UNSAFE_PERM true
ENV NPM_CONFIG_YES true
ENV NPM_CONFIG_NPAT false
ENV NPM_CONFIG_LOGLEVEL warn
# verbose

ENV CI true
# ENV bower_allow_root true
# ENV bower_log_level debug

ENV BOWER_ALLOW_ROOT true
ENV BOWER_LOG_LEVEL debug

# Express
RUN ["npm", "install", "-g", "express-generator"]
RUN ["mkdir", "-p", "/var/log/express"]
RUN express -c less /var/lib/express > /var/log/express/generator.log
WORKDIR /var/lib/express
RUN npm install 2> /var/log/express/install.log
# /Express

# Angular
# RUN npm -yq install -g bower 2> /var/log/bower-install.log

ADD angular-package.sed /tmp/angular-package.sed
RUN git clone https://github.com/angular/angular-seed.git /var/lib/angular
RUN ["mkdir", "-p", "/var/log/angular"]
WORKDIR /var/lib/angular
RUN ["sed", "-i", "-f", "/tmp/angular-package.sed", "/var/lib/angular/package.json"]
RUN npm install 2> /var/log/angular/install.log
# /Angular

WORKDIR /root
EXPOSE 3000 8000
# CMD ["/tmp/express-app/bin/www"]
# CMD ["npm", "start"]
# supervisord -n -k
CMD ["bash"]
CMD ["supervisord", "-n", "-k", "-e", "debug"]




