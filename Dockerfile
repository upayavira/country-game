FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y python-flask \
                       nodejs \
		       npm \
		       git-core \
		       nodejs-legacy \
                       python-pip \
                       libmysqlclient-dev \
		       python-dev \
                       mysql-client && \
    pip install --upgrade pip && \
    mkdir /countries

WORKDIR /countries
RUN npm install -g bower && \
    bower install --allow-root \
                  world-countries \
		  angular@1.6.1 \
		  angular-route@1.6.1 \
		  bootstrap@3.3.7 && \
    pip install MySQL-python==1.2.5

ADD *.py /countries/
ADD app /countries/app
ADD sql /countries/sql
ADD start.sh /countries
ADD tpl /countries/tpl
ENV COUNTRIES_FILE bower_components/world-countries/countries.json

ENTRYPOINT [ "./start.sh" ]
