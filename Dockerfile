FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y python-flask nodejs npm git-core nodejs-legacy && \
    mkdir /countries

WORKDIR /countries
RUN npm install -g bower && \
    bower install --allow-root \
                  world-countries \
		  angular@1.6.1 \
		  angular-route@1.6.1 \
		  bootstrap@3.3.7

ADD app.py /countries
ADD app /countries/app
ADD tpl /countries/tpl
ENV COUNTRIES_FILE bower_components/world-countries/countries.json

CMD [ "python", "app.py"]
