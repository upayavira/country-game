#!/usr/bin/python
from flask import Flask, request, send_from_directory, jsonify, render_template
app = Flask(__name__, template_folder="tpl")

import json
import random
import math
import os

GOOGLE_API_KEY= os.environ.get("GOOGLE_API_KEY")
COUNTRIES_FILE = os.environ.get("COUNTRIES_FILE")
print "GOOGLE API: %s" % GOOGLE_API_KEY

with open(COUNTRIES_FILE) as f:
  text = f.read()

  countries = json.loads(text)

def find_by_name(countries, name):
  for country in countries:
    if country["name"]["common"] == name:
      return country

def get_zoom(country):
  GLOBE_WIDTH = 256
  GLOBE_CIRCUMFERENCE=40075000
  pixelWidth=0.2798
  return int(math.log(pixelWidth * GLOBE_CIRCUMFERENCE / math.sqrt(country["area"]) / GLOBE_WIDTH) / math.log(2))

@app.route("/")
def index():
  return send_from_directory("app", "index.html")

@app.route("/libs/<path:f>")
def libs(f):
  return send_from_directory("bower_components", f)

@app.route("/css/<f>")
def css(f):
  return send_from_directory("app/css", f)

@app.route("/countries")
def show_countries():
  return render_template("countries.tpl", countries=countries)

@app.route("/countries/random")
def show_random_country():
  country = countries[random.randint(0,len(countries)-1)]
  return render_template("random-country.tpl", country=country, zoom=get_zoom(country), api_key=GOOGLE_API_KEY)

@app.route("/capitals/random")
def show_random_capital():
  country = countries[random.randint(0,len(countries)-1)]
  return render_template("random-capital.tpl", country=country, zoom=get_zoom(country), api_key=GOOGLE_API_KEY)

@app.route("/countries/<country_name>")
def show_country(country_name):
  country=find_by_name(countries, country_name)
  return render_template("country.tpl", country=country, zoom=get_zoom(country), api_key=GOOGLE_API_KEY)

@app.route("/capitals")
def show_capitals():
  return render_template("capitals.tpl", countries=countries)


def run():
  app.run("0.0.0.0", 8080, debug=True)

run()
