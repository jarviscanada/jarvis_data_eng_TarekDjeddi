import sys
import pandas as pd


def find_members_by_city(csv_file, city_name, output_file):
    df_members = pd.read_csv(csv_file)
    df_city = df_members.loc[df_members['address'].str.contains(city_name)]
    return df_city.to_json(output_file)

csv_file = sys.argv[1]
city_name = sys.argv[2]
output_file = sys.argv[3]
find_members_by_city(csv_file, city_name, output_file)