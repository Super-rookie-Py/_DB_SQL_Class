# 다중 튜플 삽입 프로그램
## keonwoo Park 2020/09/25

import pymysql

host = 'localhost'
id = "root"
pw = "system"
db_name = "company"

# connection 객체 생성
conn = pymysql.connect(host = host,user = id, password = pw, db=db_name,charset='utf8')
print("Connected")

# cursor 객체 생성
curs = conn.cursor()

# sql execute
try:
    # sql = "insert into project values ('NewProj1', 41, 'Seoul',4, 40000), ('NewProj2', 42, 'Pusan',5, 23000), ('NewProj3', 43, 'Chuncheon',1, 19000) "
    # curs.execute(sql)

    # curs.execute("delete from project where pnumber>31")
    # conn.commit()

    data = (
        ('NewProj1', 41, 'Seoul',4, 40000),
        ('NewProj2', 42, 'Pusan',5, 23000),
        ('NewProj3', 43, 'Chuncheon',1, 19000)
    )
    sql = "insert into project values(%s, %s, %s, %s, %s)"
    curs.executemany(sql, data)
    conn.commit()

    curs.execute("select * from project")
    rows = curs.fetchall()

    for r in rows:
        print(r)
except:
    print('err')
finally:
    curs.close()
    print('close')
