import psycopg2 as ps
import pandas as pd
import sys

def connt_db(host, port, username, password, database, table, output_file):
    conn2 = ps.connect(dbname=f"{database}",
                       user=f"{username}",
                       password=f"{password}",
                       host=f"{host}",
                       port=f"{port}")

    sql_query = pd.read_sql_query(" SELECT * FROM " + table, conn2)
    df = pd.DataFrame(sql_query)
    df.to_csv(r'/home/centos/dev/jarvis_data_eng_Tarek/python_exercises/python_db_app/'+f'{output_file}', index = False)

host = sys.argv[1]
port = sys.argv[2]
username = sys.argv[3]
password = sys.argv[4]
database = sys.argv[5]
table = sys.argv[6]
output_file = sys.argv[7]
connt_db(host, port, username, password, database, table, output_file)

# import pip
# installed_packages = pip.get_installed_distributions()
# installed_packages_list = sorted(["%s==%s" % (i.key, i.version)
#      for i in installed_packages])
# print(installed_packages_list)
