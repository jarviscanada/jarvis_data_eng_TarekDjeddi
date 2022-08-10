import pandas as pd

import csv
import json


def csv_2_json(input_csv, output_json):
    jsonList = []

    # read csv file
    with open(input_csv) as csvf:
        # load csv file using csv dictionary reader
        csvReader = csv.DictReader(csvf)

        # convert each csv row into dictin
        for row in csvReader:
            jsonList.append(row)

    with open(output_json, 'w') as jsonf:
        jsonString = json.dumps(jsonList, indent=3)
        jsonf.write(jsonString)


input_csv = r'test_members.csv'
output_json = r'test_members.json'
csv_2_json(input_csv, output_json)


def test_csv_2_json():
    csv_2_json('test_members.csv', 'test_members.json')
    act_json = pd.read_json('act_members.json')
    test_json = pd.read_json('test_members.json')
    assert (act_json.equals(test_json))
