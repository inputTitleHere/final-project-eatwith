-- 시간대 변경하기
alter session set time_zone = '09:00';


select * from member;
select * from gather order by no desc;
select * from restaurant;
select * from restaurant where no = '3170000-101-2020-00142';
insert into gather values(seq_gather_no.nextval,'3110000-101-2022-00001','2인3메뉴 조질사람',1,to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'),'999','9876543','여의도에서 일하는 30대 남성입니다.편하게 먹고가요',149,null,null,'M');

insert into gather values(seq_gather_no.nextval,'3180000-101-1993-07961','오마카세 먹을 파티원 구합니다.',4,to_date('2022-09-11 12:30','YYYY-MM-DD hh24:mi'),'002','3180000','여의도의 스시마카세에서 오마카세를 같이 드실 분을 구합니다.',149,null,null,'F');
insert into gather values(seq_gather_no.nextval,'3220000-101-2022-00365','맛있는 불고기 먹는 모임입니다.',4,to_date('2022-09-15 18:10','YYYY-MM-DD hh24:mi'),'001','3220000','안녕 숯불에서 숯불고기정식을 같이 먹을 사람을 구해요~.',149,30,20,null);
insert into gather values(seq_gather_no.nextval,'3030000-101-2022-00220','성수동 훈연 팟.',4,to_date('2022-09-14 17:40','YYYY-MM-DD hh24:mi'),'002','3030000','조금 이른 저녁에 만나서 같이 먹을 사람 구해요',147,null,null,null);
insert into gather values(seq_gather_no.nextval,'3010000-101-2020-00074','파스타파스타.',4,to_date('2022-09-16 12:10','YYYY-MM-DD hh24:mi'),'003','3010000','신당동 까르보네에서 파스타 모임을 하고자 합니다.',144,30,20,'M');
insert into gather values(seq_gather_no.nextval,'3070000-101-2022-00121','성북구 동선동 카페같이 가실분.',4,to_date('2022-09-17 11:40','YYYY-MM-DD hh24:mi'),'010','3070000','주말에 커피 마실분 분 구해요~ ',144,null,null,'F');

insert into gather values(seq_gather_no.nextval,'3170000-101-2020-00142','중국집 같이 먹으러 가실 3분 구해요.',3,to_date('2022-09-01 11:40','YYYY-MM-DD hh24:mi'),'005','3170000','중국집 같이 가실분 구합니다. 공동 메뉴로 사천 비빔 탕수육을 주문할 예정이며 추가적으로 각자 원하는 메뉴 하나씩 골라서 먹어봐요. ',144,null,null,'F');

select no, user_no from gather where user_no in (149,147,144);

insert into member_gather values(149, 25,sysdate);

insert into member_gather values(149, 29,sysdate);
insert into member_gather values(147, 31,sysdate);
insert into member_gather values(144, 38,sysdate);
insert into member_gather values(144, 39,sysdate);
insert into member_gather values(144, 58,sysdate);

delete from gather where no=22;
commit;

select * from review order by no desc;
delete from review where no=4;
insert into review values(SEQ_REVIEW_NO.nextval, 58, '3170000-101-2020-00142', 4, 5, 5, 3, '정말 맛있게 먹었는데 직원은 적고 사람들이 너무 많아서 주문도 쉽지 않네요.', 149);
insert into review values(SEQ_REVIEW_NO.nextval, 58, '3170000-101-2020-00142', 3, 5, 3, 3, '맛은 괜찮은데 아무래도 직원을 조금 더 뽑아야 할 것 같네요.', 144);
insert into review values(SEQ_REVIEW_NO.nextval, 58, '3170000-101-2020-00142', 5, 5, 3, 5, '자주가던 중국집인데 정말 맛있습니다! 동네 가기 치고는 가격이 조금 쎈데 쎈 만큼 맛있어서 만족스럽습니다. ', 147);

commit;


-- select 연습장
select * from member;
select * from review;
select * from restaurant;
select * from food_type;
select 
    rev.*,
    rest.name,
    rest.dong,
    (select image_name from review_image where restaurant_no = rev.restaurant_no and rownum=1) as image_source,
    (select name from member where no = rev.user_no) as writer,
    (select type from food_type t where t.code = rest.food_code) as food_type,
    (select count(*) from review where restaurant_no = rev.restaurant_no) as review_count,
    (select avg(overall_score) from review where  restaurant_no = rev.restaurant_no) as avg_score
from (select * from review where overall_score = 5 order by no desc) rev join restaurant rest on rev.restaurant_no = rest.no
where rownum <=5;

-- 마감임박 모임
select 
    (meet_date - current_date)
from gather
where 
   (meet_date - current_date) >0
order by meet_date
;

select
    r.*,
    rest.name,
    rest.dong,
    (select count(*) from member_gather where gather_no = r.no) as enrolled_count,
    (select type from food_type where rest.food_code = code) as food_type
from(
    select
        r.*
    from(
        select
            g.*,
            (meet_date-current_date) as remaining_time
        from
            gather g
        where
            (meet_date-current_date)>0 
    order by g.meet_date
    ) r
    where rownum <= 8
) r join restaurant rest on r.restaurant_no = rest.no;


select sysdate from dual;
select to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss') from dual;
select to_char(current_date, 'yyyy-MM-dd HH24:mi:ss') from dual;

select * from restaurant;

	  select
	    r.*,
	    (select name from member where no = r.user_no) as writer,
	    rest.name as restaurant_name,
	    rest.dong as restaurant_dong,
	    ri.no as review_image_no,
	    ri.restaurant_no as restno,
	    ri.review_no as revno,
	    ri.image_name as image_name
		from
	    review r join restaurant rest on r.restaurant_no = rest.no left join review_image ri on r.no=ri.review_no
		order by 
	    r.no desc;


select * from favorite_district;
select * from favorite_food;
select * from member;

commit;

--delete from favorite_district where no=161;
--delete from member where no=161;
















