"""A program that edits a JSON file"""

import json

fileNames = ["argos.json", "cubesat.json", "education.json", "geo.json", "gnss.json",
             "military.json", "musson.json", "nnss.json", "other.json", "radar.json",
             "resource.json", "satnogs.json", "sbas.json", "science.json", "tdrss.json",
             "weather.json"]

# Open the JSON file
with open('Active_Satellites_Raw.json') as f:
    data = json.load(f)

new_data = []
for obj in data:
    tempID = obj["NORAD_CAT_ID"]
    stringID = str(tempID)
    new_obj = {
        "name": obj["OBJECT_NAME"],
        "satelliteId": stringID,
    }
    new_data.append(new_obj)

i = 0
# Open the JSON file form the JSONs folder
for file in fileNames:
    with open("JSONs/"+file) as f:
        data = json.load(f)

    #Check if the satellite is already in new_data, append if not
    for obj in data:
        tempID = obj["NORAD_CAT_ID"]
        stringID = str(tempID)
        new_obj = {
            "name": obj["OBJECT_NAME"],
            "satelliteId": stringID,
        }
        if new_obj not in new_data:
            i += 1
            print("New Object #" + str(i) + ": " + new_obj["name"])
            new_data.append(new_obj)

with open('active_satellites.json', 'w') as f:
    json.dump(new_data, f, indent=4)

