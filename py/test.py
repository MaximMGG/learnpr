import psycopg2



conn = psycopg2.connect(
    database="crypto",
    user="maximhrunenko",
    password="17TypeofMG")

cur = conn.cursor()
cur.execute('select version()')

db_version = cur.fetchone()

cur.execute('insert into ticker_1d (value) values (\'Hello\')')

conn.commit()

print(db_version)
