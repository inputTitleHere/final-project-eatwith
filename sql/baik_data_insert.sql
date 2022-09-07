
select * from member;
select * from gather;
select * from restaurant;
insert into gather values(seq_gather_no.nextval,'3110000-101-2022-00001','2인3메뉴 조질사람',1,to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'),'999','9876543','여의도에서 일하는 30대 남성입니다.편하게 먹고가요',149,null,null,'M');

insert into gather values(seq_gather_no.nextval,'3180000-101-1993-07961','오마카세 먹을 파티원 구합니다.',4,to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'),'002','3180000','여의도의 스시마카세에서 오마카세를 같이 드실 분을 구합니다.',149,null,null,'F');
insert into gather values(seq_gather_no.nextval,'3220000-101-2022-00365','맛있는 불고기 먹는 모임입니다.',4,to_date('2022-09-15 18:10','YYYY-MM-DD hh24:mi'),'001','3220000','안녕 숯불에서 숯불고기정식을 같이 먹을 사람을 구해요~.',149,30,20,null);
insert into gather values(seq_gather_no.nextval,'3030000-101-2022-00220','성수동 훈연 팟.',4,to_date('2022-09-14 17:40','YYYY-MM-DD hh24:mi'),'002','3030000','조금 이른 저녁에 만나서 같이 먹을 사람 구해요',147,null,null,null);
insert into gather values(seq_gather_no.nextval,'3010000-101-2020-00074','파스타파스타.',4,to_date('2022-09-16 12:10','YYYY-MM-DD hh24:mi'),'003','3010000','신당동 까르보네에서 파스타 모임을 하고자 합니다.',144,30,20,'M');


insert into gather values(seq_gather_no.nextval,'3070000-101-2022-00121','성북구 동선동 카페같이 가실분.',4,to_date('2022-09-17 11:40','YYYY-MM-DD hh24:mi'),'010','3070000','주말에 커피 마실분 분 구해요~ ',144,null,null,'F');
commit;