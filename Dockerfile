FROM dockerfile/nodejs
MAINTAINER  Christopher Lyth <cjlyth@gmail.com>
ENTRYPOINT ["/usr/bin/env"]

ADD express-app.js /root/src/express-app.js
ADD package.json /root/src/package.json
WORKDIR /root/src
RUN npm install