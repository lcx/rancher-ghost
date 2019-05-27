FROM ghost:1.25.7
MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>


ENV NODE_ENV=production


# Add Mysql and Postgresql support
RUN npm install -g mysql

# Add python support for init script
RUN apt-get update && \
    apt-get install vim -y

# Add init script
ADD assets/configure.sh /app/configure.sh
ADD assets/config.json /app/config.json
ADD assets/docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chmod +x /app/configure.sh


# CLEAN APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 2368
ENTRYPOINT ["/entrypoint.sh"]
VOLUME ["/var/lib/ghost/content"]
CMD ["node", "current/index.js"]
