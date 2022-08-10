import pandas as pd
from python_pandas_app.app_convert_csv_to_json import csv_2_json

def test_csv_2_json():
    csv_2_json('tests/temp.csv','tests/test_csv_2_json')
    temp_json=pd.read_json('tests/temp.json')
    test_json=pd.read_json('tests/test_csv_2_json.json')
    assert(temp_json.equals(test_json))