select * from gather order by no;
select*from restaurant;
select*from food_type;
select*from member;
select*from member_gather order by enroll_at desc;
select*from review order by no desc;
select*from review_image;

insert into member_gather values(141,102,sysdate,0);

delete gather where no between 180 and 188;
insert into gather values(seq_gather_no.nextval,'3220000-101-1997-12699','리스트 체크용이다',2,to_date('2022-10-20
11:30','YYYY-MM-DD hh24:mi'),'001','3220000','중국집조질사람구함',146,null,null,null);
insert into gather values(seq_gather_no.nextval,'3220000-101-2022-00526','족발은 살안쪄',3,to_date('2022-09-11 11:30','YYYY-MM-DD hh24:mi'),'007','3220000','귀한족발에서 족발 한번 조집시다.. 또래환영',142,24,27,null);

insert into member_gather values(151,103,sysdate);
commit;

insert into review values(SEQ_REVIEW_NO.nextval,26, '3030000-101-2022-00228', 5, 5, 5, 5, '새로생긴 성수 분위기 맛집. 분위기 뿐 아니라 커피 맛까지 잡았네요', 141);
insert into review values(SEQ_REVIEW_NO.nextval,26, '3030000-101-2022-00228', 4, 5, 1, 5, '성수여서 가격이쫌...', 145);
insert into review values(SEQ_REVIEW_NO.nextval,32, '3220000-101-2022-00526', 5, 5, 5, 5, '족발 맛집 맞네요!! 존맛탱구리..', 142);
insert into review values(SEQ_REVIEW_NO.nextval,27, '3130000-101-2022-00717', 5, 5, 5, 5, '사장님이 너무 인싸시구 좋아요 ㅋㅋㅋㅋ', 141);

update gather set age_restriction_bottom=20 where no=32;
update gather set count=3 where no=34;
delete gather where no=86;
delete member_gather where gather_no=103 and user_no=141;

insert into member_gather (user_no,gather_no,enroll_at) select 121,103,sysdate from dual where not exists(select user_no,gather_no from member_gather where user_no=121 and gather_no=103);
select * from member_gather where gather_no=103;

select (
select *
from gather g
where g.gender_restriction=null or g.gender_restriction=gender
) 
from member m;
  ALTER SESSION SET TIME_ZONE = 'Asia/Seoul';

		select 
	    g.*,
	    (select count(*) from member_gather where gather_no = g.no) as nowCount,
	    (select type from food_type f where g.food_code = f.code) as type,
	    (select name from district d where g.district_code = d.code) as locaName,
	    (select name from restaurant rest where rest.no = g.restaurant_no) as name
		from 
	    (select * from gather where meet_date>(sysdate+9/24)) g
		order by meet_date asc;
                
select gender_restriction,
case gender_restriction
        when 'M' then 'M'
        when 'F' then 'F'
        else '제한없음'
        end as gender
from gather;


select * from member_gather order by enroll_at desc;
select * from member;
alter table member_gather modify checked number default '0' not null;

select mg.user_no,mg.gather_no,mg.enroll_at,mg.checked, m.name , m.born_at,m.gender
from member_gather mg join member m on mg.user_no=m.no
where gather_no=61;

update member_gather set checked='0' where user_no=141 and gather_no=102;

select * from member_gather;
select * from member_gather where user_no=141 and gather_no=102 and checked=1;

select * from review;

delete review where no=68;

alter table review add user_no number not null;

alter table review add foreign key (user_no) references member(no);

select * from gather where meet_date>sysdate and no=140;

		select 
	    g.*,
	    (select count(*) from member_gather where gather_no = g.no) as nowCount,
	    (select type from food_type f where g.food_code = f.code) as type,
	    (select name from district d where g.district_code = d.code) as locaName,
	    (select name from restaurant rest where rest.no = g.restaurant_no) as name
		from 
	    (select * from gather where meet_date>(sysdate+9/24)) g
		order by g.no desc