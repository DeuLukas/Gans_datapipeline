schema = "gans_wbsproject"
host  = "localhost"
user = "root" 
password = "Insert_your_SQL_root_password"
port = 3306
con = f"mysql+pymysql://{user}:{password}@{host}:{port}/{schema}"