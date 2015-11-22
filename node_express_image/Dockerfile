FROM node:4.2

RUN apt-get update
RUN apt-get -y install sudo

RUN npm set registry http://192.168.20.10:4873/

ENV NPM_CONFIG_LOGLEVEL=warn

RUN npm install npm@3.3.8 -g



RUN adduser --disabled-password --gecos "" nodeuser; \
  echo "nodeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# set HOME so 'npm install' and 'bower install' don't write to /
ENV HOME /home/nodeuser

# Always run as the nodeuser
USER nodeuser

RUN npm set registry http://192.168.20.10:4873/

RUN sudo npm install express-generator -g

RUN sudo npm install pm2 -g

RUN sudo npm install strongloop -g
#--no-optional

#RUN mkdir -p /root/.config/configstore

#RUN chmod 777 /root/.config/configstore


RUN sudo npm install yo -g

RUN sudo npm install generator-keystone -g

#RUN mkdir -p /root/.config/configstore
#RUN touch /root/.config/configstore/insight-yo.json
#RUN chmod a+rwx /root /root/.config /root/.config/configstore
#/root/.config/configstore/insight-yo.json

EXPOSE 3000
