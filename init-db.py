#!/usr/bin/python

import MySQLdb
import os
import json

COUNTRIES_FILE = os.environ.get("COUNTRIES_FILE")

print "Starting"
db=MySQLdb.connect(host="172.17.0.1", passwd="root", user="root", db="countries", use_unicode=True, charset="utf8")

print "Loading countries"
with open(COUNTRIES_FILE) as f:
  text = f.read()
  countries = json.loads(text)

print "Loaded countries"

c = db.cursor()

print "Cursor created"

def get(array, pos, default):
    if len(array)<=pos:
        return default
    else:
        return array[pos]

print "For each country..."
for country in countries:
  id=country["cca3"]
  print id
  print country["name"]["common"].encode("UTF-8")
  c.execute("""INSERT INTO country (id,
                                    common_name,
                                    official_name,
                                    currency,
                                    calling_code,
                                    capital,
                                    region,
                                    subregion,
                                    lat,
                                    lon,
                                    landlocked,
                                    area,
                                    json)
                                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
            (id,
             country["name"]["common"],
             country["name"]["official"],
             get(country["currency"], 0, ""),
             get(country["callingCode"], 0, ""),
             country["capital"],
             country["region"],
             country["subregion"],
             get(country["latlng"], 0, 0),
             get(country["latlng"], 1, 0),
             country["landlocked"],
             country["area"],
             json.dumps(country)
             ))

  for k,v in country["languages"].iteritems():
    c.execute("""INSERT INTO language (country_id, language_code, language_name)
                                      VALUES(%s, %s, %s)""",
              (id, k, v))

  for border in country["borders"]:
      c.execute("""INSERT INTO border (country_id, border) VALUES (%s, %s)""",
                (id, border))

db.commit()
