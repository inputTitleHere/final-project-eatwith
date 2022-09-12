select * from member;
select * from restaurant where no='3150000-101-2001-09860';
select * from district;
select * from food_type;
select * from review where restaurant_no ='3010000-101-2017-00400';
select * from review_image;
select * from food_type;
select * from favorite_restaurant;
select f.type from restaurant r left join food_type f on r.food_code = f.code where r.no='3020000-101-2018-00337';
--insert into gather values(seq_gather_no.nextval,'3110000-101-2022-00001','2인3메뉴 조질사람',1,to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'),'999','9876543','여의도에서 일하는 30대 남성입니다.편하게 먹고가요',149,null,null,'M');
-- abcd : 143 (1975)/ qwerty:151(1984) / park :148(1993)
insert into gather 
values(SEQ_GATHER_NO.nextval, '3020000-101-2018-00337', '뜨끈한 부대찌개 먹으실분', 4, to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'), '007', '3020000', '부대찌개에 밥 한공기 해요', 143, null, null, 'M');

insert into gather 
values(SEQ_GATHER_NO.nextval, '3150000-101-2001-09860', '비도오는데', 2, to_date('2022-09-18 21:00','YYYY-MM-DD hh24:mi'), '001', '3150000', '비오는데 전에 막걸리 한잔 어때요', 143, 60, 40, 'M');

insert into gather 
values(SEQ_GATHER_NO.nextval, '3010000-101-2014-00196', '커피 마시고 싶은데', 2, to_date('2022-09-15 21:00','YYYY-MM-DD hh24:mi'), '010', '3010000', '커피마시면서 대화 하실 분 있나요?', 148, null, null, 'F');

insert into gather 
values(SEQ_GATHER_NO.nextval, '3200000-101-2021-00477', '치킨 먹을사람', 4, to_date('2022-09-13 21:00','YYYY-MM-DD hh24:mi'), '008', '3200000', '치맥하실분', 151, null, null, null);

insert into gather 
values(SEQ_GATHER_NO.nextval, '3030000-101-1985-03463', '기력 보충하고싶다', 8, to_date('2022-09-18 21:00','YYYY-MM-DD hh24:mi'), '004', '3030000', '기력이 떨어지는 사람 손,,,', 151, null, 30, 'M');

insert into gather 
values(SEQ_GATHER_NO.nextval, '3010000-101-2017-00400', '쌀국수!!!', 3, to_date('2022-09-05 18:00','YYYY-MM-DD hh24:mi'), '009', '3010000', '베트남 여행 대신에 쌀국수라도 먹어요', 151, null, null, 'F');

select * from gather;

insert into review
values(SEQ_REVIEW_NO.nextval, 49, '3010000-101-2017-00400', 4, 5, 3, 3, '맛있어요. 가격이 조금 아쉽지만 종업원이 친절해요', 143);

insert into review
values(SEQ_REVIEW_NO.nextval, 49, '3010000-101-2017-00400', 5, 5, 5, 3, '여행가서 먹었던 그맛이에요 ㅜㅜ 재방문 100% 할거에요', 151);

insert into review
values(SEQ_REVIEW_NO.nextval, 49, '3010000-101-2017-00400', 3, 3, 3, 3, '친구들이랑 싸게 맛있게 잘 먹고왔어요', 148);

insert into member_gather values(143, 45, sysdate);
insert into member_gather values(143, 44, sysdate);
insert into member_gather values(148, 43, sysdate);
insert into member_gather values(151, 42, sysdate);
insert into member_gather values(151, 41, sysdate);

select * from member_gather;