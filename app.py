#!/usr/bin/python
from flask import Flask, request, send_from_directory, jsonify, render_template, g
import random
import math
import os
import MySQLdb
from MySQLdb.cursors import DictCursor
import logging
import json

app = Flask(__name__, template_folder="tpl")
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
GOOGLE_API_KEY= os.environ.get("GOOGLE_API_KEY")

@app.before_request
def before_request():
 g.db = MySQLdb.connect(host="172.17.0.1", passwd="root", user="root", db="countries", use_unicode=True,
                     charset="utf8")

def get_zoom(area):
  GLOBE_WIDTH = 256
  GLOBE_CIRCUMFERENCE=40075000
  pixelWidth=0.2798
  return int(math.log(pixelWidth * GLOBE_CIRCUMFERENCE / math.sqrt(area) / GLOBE_WIDTH) / math.log(2))


def find_countries(minimum_country_size, maximum_country_size, country_count, fields, sort):
    if sort == "random" or sort not in ("id", "area"):
        sort = "RAND()"
    sql = "SELECT id, area, common_name, json FROM country WHERE area >= %%s AND area <= %%s ORDER BY %s LIMIT %%s;" % sort
    cursor = g.db.cursor(DictCursor)
    logger.info(sql, minimum_country_size, maximum_country_size, country_count)
    cursor.execute(sql, [minimum_country_size, maximum_country_size, country_count])
    countries = []
    for row in cursor.fetchall():
        if fields == "all":
            country = json.loads(row["json"])
            country["zoom"] = get_zoom(country["area"])
            country["id"] = row["id"]
            countries.append(country)
        elif fields == "sizes":
            country = {"id": row["id"], "name": row["common_name"], "area": row["area"]}
            countries.append(country)
        else:
            logger.error("Unknown fields: %s", fields)
            return []
    cursor.close()

    return countries


@app.route("/")
def index():
  return send_from_directory("app", "index.html")


@app.route("/app/<path:f>")
def app_files(f):
  return send_from_directory("app", f)


@app.route("/libs/<path:f>")
def libs(f):
  return send_from_directory("bower_components", f)


@app.route("/css/<f>")
def css(f):
  return send_from_directory("app/css", f)


@app.route("/api/countries/")
@app.route("/api/countries")
def countries_find():
    minimum_country_size = int(request.args.get("minimum_size", 0))
    maximum_country_size = int(request.args.get("maximum_size", "100000000"))
    fields = request.args.get("fields", "all")
    sort = request.args.get("sort", "random")
    country_count = int(request.args.get("count", 10000))
    countries = find_countries(minimum_country_size, maximum_country_size, country_count, fields, sort)

    return jsonify({"countries":countries})


def run():
  app.run("0.0.0.0", 8080, debug=True)

if __name__ == "__main__":
  run()
