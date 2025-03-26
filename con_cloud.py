schema = "city_scooter_analysis"
host  = "Insert_Cloud_IP_for_SQL_table"
user = "root" 
password = "Insert_your_SQL_root_password"
port = 3306
con = f"mysql+pymysql://{user}:{password}@{host}:{port}/{schema}"