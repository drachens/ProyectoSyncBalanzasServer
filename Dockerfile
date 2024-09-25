FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y nginx 
RUN apt-get install -y php7.4-fpm 
RUN apt-get install -y php7.4-cli 
RUN apt-get clean

# Agregar el bloque de configuración para PHP-FPM y restricciones de .htaccess
RUN echo "location ~ \\.php$ {" >> /etc/nginx/sites-available/default && \
    echo "    include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default && \
    echo "    fastcgi_pass unix:/run/php/php7.4-fpm.sock;" >> /etc/nginx/sites-available/default && \
    echo "}" >> /etc/nginx/sites-available/default && \
    echo "location ~ /\\.ht {" >> /etc/nginx/sites-available/default && \
    echo "    deny all;" >> /etc/nginx/sites-available/default && \
    echo "}" >> /etc/nginx/sites-available/default

RUN service nginx restart

RUN sudo touch /var/www/html/info.php

RUN echo "<?php" >> /var/www/html/info.php && \
    echo "php.info();" >> /var/www/html/info.php && \
    echo " ?>" >> /var/www/html/info.php

EXPOSE 80

CMD [ "sh","-c","service php7.4-fpm start && nginx -g 'deamon off;'" ]