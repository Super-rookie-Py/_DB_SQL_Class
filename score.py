# MariaDB를 이용한 프로그래밍
## keonwoo Park 2020/09/25

import pymysql

host = "localhost"
id = "root"
pw = "system"
db_name = "mydb"

conn = pymysql.connect(host=host, user=id, password=pw,db=db_name, charset='utf8')
print('DB connected')
curs = conn.cursor()

### 본 실습 과제 : 학생들의 성적을 처리하는 프로그램 작성하기 ####
try:
    while (True):
        print("<<< Select Menu>>>")
        print("1 : 전체 목록 출력")
        print("2 : 성적 검색")
        print("3 : 성적 추가")
        print("4 : 성적 수정")
        print("5 : 성적 삭제")
        print("9 : 프로그램 종료")
        choice = int(input("입력 : "))

        if choice == 1:
            print("전체 목록 출력을 선택하셨습니다 !!")
            curs.execute("select * from score")
            rows = curs.fetchall()
            print("<<전체 목록 출력>>")
            for r in rows:
                print(r)

        if choice == 2:
            print("성적 검색을 선택하셨습니다 !!")
            student_no = input("학번을 입력하세요: ")
            sql = "select * from score where st_id = " + student_no
            curs.execute(sql)
            rows = curs.fetchall()
            for r in rows:
                print("학변 : " + str(r[0]))
                print("이름 : " + str(r[1]))
                print("국어 : " + str(r[2]))
                print("영어 : " + str(r[3]))
                print("수학 : " + str(r[4]))
                total = r[2] + r[3] + r[4]
                avg = round(total/3,1)
                print("총점 : ", total)
                print("평균 : ", avg)
            print("*** 검색을 완료했습니다 !! ***\n")

        if choice == 3:
            print("성적 추가를 선택하셨습니다 !!")
            s_id = input("학번 : ")
            s_name = input("이름 : ")
            kor = input("국어 : ")
            eng = input("영어 : ")
            math = input("수학 : ")
            sql = f"insert into score values({s_id},'{s_name}', {kor}, {eng}, {math}, null, null)"
            curs.execute(sql)

            sql = "select * from score where st_id = " + s_id
            curs.execute(sql)
            rows = curs.fetchall()
            for r in rows:
                print("학변 : " + str(r[0])+"  ", end='')
                print("이름 : " + str(r[1])+"  ", end='')
                print("국어 : " + str(r[2])+"  ", end='')
                print("영어 : " + str(r[3])+"  ", end='')
                print("수학 : " + str(r[4])+"  ", end='')
            print("")
            print("*** 성적이 입력되었습니다. ***\n")
        if choice == 4:
            print("성적 수정을 선택하셨습니다 !!")
            student_no = input("수정할 학생의 학번을 입력해 주세요: ")
            subject = ''
            while(True):
                update_menu = input("수정할 항목을 선택해 주세요. [국어, 영어, 수학]: ")
                if update_menu == '국어':
                    subject = 'kor'
                    break
                elif update_menu == '영어':
                    subject = 'eng'
                    break
                elif update_menu == '수학':
                    subject = 'math'
                    break
                else:
                    print("다시 선택해 주세요")
            update_value = input("수정할 점수를 입력해 주세요: ")
            sql = "update score set " + subject + f"= {update_value} where st_id = {student_no}"
            curs.execute(sql)

            # 출력
            sql = "select * from score where st_id = " + student_no
            curs.execute(sql)
            rows = curs.fetchall()
            for r in rows:
                print("학변 : " + str(r[0]) + "  ", end='')
                print("이름 : " + str(r[1]) + "  ", end='')
                print("국어 : " + str(r[2]) + "  ", end='')
                print("영어 : " + str(r[3]) + "  ", end='')
                print("수학 : " + str(r[4]) + "  ", end='')
            print("")
            print("*** 성적이 수정되었습니다 ***\n")

        if choice == 5:
            print("성적 삭제를 선택하셨습니다 !!")
            student_no = input("학번을 입력해 주세요: ")
            sql = f"delete from score where st_id = {student_no}"
            curs.execute(sql)
            print("*** 해당 학생의 성적이 삭제되었습니다 ***\n")

        if choice == 9:
            print("프로그램 종료를 선택하셨습니다 !!")
            break;

        if choice not in [1,2,3,4,5,9]:
            print("잘못된 메뉴를 선택하셨습니다 !!")

        input("계속하기 (Enter 키 누름) >>")

except:
    print("ERROR: 실행 오류가 발생했습니다.")
finally:
    curs.close()
    print("프로그램 실행이 완료됐습니다")