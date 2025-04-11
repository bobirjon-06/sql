import sqlite3
import pyodbc

con_str = "DRIVER={SQL SERVER};SERVER=miracle;DATABASE=master; Trusted_Connection=YES;"
con =  pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM photos;
    """
)

row = cursor.fetchone()
id, name, image_data = row
with open (f"{name}.jpg", 'wb') as f:
    f.write(image_data)