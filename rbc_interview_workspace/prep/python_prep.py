import psycopg2 as ps
import pandas as pd

conn = ps.connect(
    host="localhost",
    database="exxercises",
    user="postgres",
    password="postgres"
)

cur = conn.cursor()
df = pd.read_sql('SELECT * FROM cd.bookings LIMIT 5', conn)
print(df)