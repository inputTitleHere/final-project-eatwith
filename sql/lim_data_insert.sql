
SELECT
	rr.name name, 
	rr.address address, 
	rr.work_hours hours, 
	rr.menu menu, 
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
	where rr.menu like '%감자%'
		or rr.address like '%감자}%'
	order by case         
		WHEN 1=1
			THEN rn.rwn
           	else gc.pop
	    	end desc NULLS LAST
   	FETCH FIRST 10 ROWS ONLY;

    select count(*) from
	(SELECT
	rr.name name, 
	rr.address address, 
	rr.work_hours hours, 
	rr.menu menu, 
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop,
	rn.rwn
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
	where rr.menu like '%${searchWord}%'
		or rr.address like '%${searchWord}%');

select count(*) from
	(SELECT * FROM gather
		where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')
			< TO_CHAR(meet_date, 'YYYYMMDDHH24MISS')
		and (title like '%피자%'
			or content like '%피자%'));
            
            	SELECT * FROM gather g
			join (SELECT count(*) as attend, gather_no
					from member_gather group by gather_no) c
			on g.no = c.gather_no
				where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(g.meet_date, 'YYYYMMDDHH24MISS')
					and (g.title like '%피자%' or g.content like '%피자%');
                
                select * from review;
                select count(*) as pop, restaurant_no
				from gather group by restaurant_no;
                
SELECT
	rr.name name, 
	rr.address address, 
	rr.work_hours hours, 
	rr.menu menu, 
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop pop,
	rn.rwn rwn,
    rv.overall_score overallScore,
    ri.image_name imageName
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
    left join REVIEW_IMAGE  ri on ri.review_no = rv.no
	where rr.menu like '% %'
		or rr.address like '% %'
		or rr.name like '% %'
	order by case         
		WHEN 1=2
			THEN rn.rwn
           	else gc.pop
	    	end desc NULLS LAST
   	FETCH FIRST 9 ROWS ONLY;
    select count(*) from
	(SELECT * FROM gather
		where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')
			< TO_CHAR(meet_date, 'YYYYMMDDHH24MISS')
		and (title like '%피자' or content like '%피자%'));
                    
			ORDER BY desc NULLS LAST FETCH FIRST 10 ROWS ONLY;

select * from review;
select * from RESTAURANT;
select * from gather;
select * from member_gather;
select * from district where code = 3020000;
-- 시퀀스 / [식당 num] / 타이틀 / 모임인원 / 만날 날짜 / [food code] / [dis code] / 코멘트 / user no / 연령탑 / 연령 다운 / 성별 제한

-- 153 / M
    -- 3140000-101-2022-00151 / 3140000 / 010 / 카페,디저트
    insert into gather values(seq_gather_no.nextval,'3140000-101-2022-00151','커피 한잔 할래요',
    4,to_date('2022-09-24 19:30','YYYY-MM-DD hh24:mi'),'010','3140000','양천구 이직 고민하시는 직장인분들 커피한잔해요~!',
    153,null,null,'M');
    -- 3200000-101-2022-00168 / 3200000 / 005 / 중식
    insert into gather values(seq_gather_no.nextval,'3200000-101-2022-00168','주말 점심으로 탕수육 어때요?',
    4,to_date('2022-09-25 19:30','YYYY-MM-DD hh24:mi'),'005','3200000','점심으로 탕수육이나 요리류 같이 드실분들 모여요^^',
    153,null,null,'M');
    -- member_gather
        select * from gather where user_no = '153';
        select * from member_gather;
        insert into member_gather values (153, 40, sysdate);
        insert into member_gather values (153, 46, sysdate);
        commit;
        
-- 145 / M 
    -- 3130000-101-2021-00800 / 3130000 / 011 / 와인
        insert into gather values(seq_gather_no.nextval,'3130000-101-2021-00800','가볍게 술 한잔 하실 분들 모여요~!',
        6,to_date('2022-09-15 19:30','YYYY-MM-DD hh24:mi'),'011','3130000','와인 좋아하시는 분들이면 좋겠습니다 : )',
        145,null,null,'M');
    -- 3020000-101-2021-00080 / 3020000 / 011 / 맥주, 호프
        insert into gather values(seq_gather_no.nextval,'3020000-101-2021-00080','용산구 치맥...!!!!',
        6,to_date('2022-09-16 19:30','YYYY-MM-DD hh24:mi'),'011','3020000','퇴근 후 맥주한잔 같이해요~',
        145,null,null,'M');
    -- member_gather
        select * from gather where user_no = '145';
        select * from member_gather;
        insert into member_gather values (145, 47, sysdate);
        insert into member_gather values (145, 48, sysdate);
        commit;
        
-- 150 / F
    -- 3100000-101-2022-00087 / 3100000 / 003 / 양식_파스타
        insert into gather values(seq_gather_no.nextval,'3100000-101-2022-00087','파스타 같이 드실 점심 친구....!',
        2,to_date('2022-09-08 12:30','YYYY-MM-DD hh24:mi'),'003','3100000','있다면 좋겠어요!!',
        150,null,null,'F');
    -- 3180000-101-2021-00374 / 3180000 / 009 / 아시아음식 _ 쌀국수
        insert into gather values(seq_gather_no.nextval,'3180000-101-2021-00374','쌀국수 맛집 같이 가요~~',
        4,to_date('2022-09-10 12:15','YYYY-MM-DD hh24:mi'),'009','3180000','쌀국수 좋아하시는 분들 같이가요~!',
        150,null,null,'F');
    -- member_gather
        select * from gather where user_no = '150';
        select * from member_gather where user_no = 150 or user_no = 145 or user_no = 153;
        insert into member_gather values (150, 56, sysdate);
        insert into member_gather values (150, 57, sysdate);
        commit;

-- 150 / F / 3010000-101-2017-00021 / 3010000 / 004 / 코다리 복국
        insert into gather values(seq_gather_no.nextval,'3010000-101-2017-00021','복날엔 복국....!',
        6,to_date('2022-08-11 12:15','YYYY-MM-DD hh24:mi'),'004','3010000','복날 점심 복국 어떠세요?',
        150,null,null,'F');
        commit;
        SELECT
            * FROM gather;
        select * from gather where user_no = '150';
        insert into member_gather values (150, 61, to_date('2022-08-12 16:15','YYYY-MM-DD hh24:mi'));
        insert into member_gather values (145, 61, to_date('2022-08-11 19:15','YYYY-MM-DD hh24:mi'));        
        insert into member_gather values (153, 61, to_date('2022-08-11 14:15','YYYY-MM-DD hh24:mi'));
        commit;
        
        select * from review;
        insert into review
            values(SEQ_REVIEW_NO.nextval,61,'3010000-101-2017-00021', 4, 5, 3, 5, '매장도 깔끔하고, 음식도 맛있어요~!', 150);
        insert into review
            values(SEQ_REVIEW_NO.nextval,61, '3010000-101-2017-00021', 5, 5, 3, 5, '인생 맛집...! 이 집 복국 너무 맛있어요..!!', 145);
        insert into review
            values(SEQ_REVIEW_NO.nextval,61, '3010000-101-2017-00021', 4, 3, 3, 5, '기대 안하고 갔는데, 너무 맛있게 먹었습니다!!!!', 153);
        commit;
    SELECT
        * FROM GATHER WHERE restaurant_no = '3010000-101-2017-00021';
    SELECT
        * FROM review;
-- 시퀀스 / [모임 num] / [식당 num] / 전체평점 / 맛평점 / 가격평점 / 서비스평점 / 방문후기 / [작성자num]
    insert into gather values(seq_review_no.nextval,'3140000-101-2022-00151','커피 한잔 할래요',
    4,to_date('2022-09-24 19:30','YYYY-MM-DD hh24:mi'),'010','3140000','양천구 이직 고민하시는 직장인분들 커피한잔해요~!',
    153,null,null,'M');
    commit;
    
    select * from notice order by notice_no;
    TRUNCATE table notice;
    select notice_no from notice;
	insert into notice values (seq_notice_no.nextval, '확인차', '확인차', default, default, default);
	insert into notice values (seq_notice_no.nextval, '수정함', '수정되었는가', default, '22/09/16' , default);
    ALTER table notice values (seq_notice_no.nextval, '확인차', '확인차', default, default, default);
    DELETE FROM notice WHERE notice_no = '23';
    UPDATE notice SET updated_at = sysdate where notice_no = 31;
    commit;
    rollback;
    SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'seq_notice_no';
    
    -- 시퀀스 초기화 아직 안함.
--    alter SEQUENCE SEQ_NOTICE_NO


   select count(*) from notice where deleted_at is null;

     select count(*) from review group by ;

     select count(*) from gather group by ;

-- 이거 기반
   select count(*), gather_no from review group by gather_no;
   select * from review group by (select gather_no from gather);

select * from review;
select * from review r join member m on r.user_no = m.no;
select * from gather; g join district d on g.district_code = d.code;
select * from member;
select * from restaurant;
select * from review rv join restaurant rr on rv.restaurant_no = rr.no;

가져와서 뭐할거야 

select d.*,c.
from
(select * from district d where code not in (9876543)) d outer join
(select * from food_type f where code not in (999)) c on 1=1;

더 많은 결과를 원한다면!

select g.*,r.name,r.dong
from gather g left join restaurant 
r on g.restaurant_no = r.no;

	SELECT * FROM gather g join
		(SELECT count(*) as attend, gather_no
		from member_gather group by gather_no) c
	on g.no = c.gather_no
	where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(g.meet_date, 'YYYYMMDDHH24MISS')
	and (g.title like '%파스타%' or g.content like '%파스타%')
	ORDER BY CASE
            WHEN 1=1 THEN g.no
            else c.attend
    end desc FETCH FIRST 10 ROWS ONLY;
    
SELECT rr.name name,
rr.address address, 
rr.work_hours hours, 
rr.menu menu, 
rr.phone phone, 
rr.naver_food_type type,
gc.pop
FROM restaurant rr left join review rv on rr.no = rv.restaurant_no left join
(select count(*) as pop, restaurant_no
from gather group by restaurant_no) gc 
on rr.no = gc.restaurant_no;
    
select count(*), restaurant_no
from gather group by restaurant_no;
 
 select * form gather;
    
	select m.name, r.* from review r left join member m on m.no = r.user_no
    (
	where r.content like '%먹짱%' or m.name like '%먹짱%'
	ORDER BY CASE
            WHEN 1=1 THEN r.no
            else r.overall_score
    end desc FETCH FIRST 10 ROWS ONLY;

SELECT rr.name name, 
rr.address address, 
rr.work_hours hours, 
rr.menu menu, 
rr.phone phone, 
rr.naver_food_type type
FROM restaurant rr left join review rv on rr.no = rv.restaurant_no
where rr.menu like '%${searchWord}%' or rr.address like '%${searchWord}%' order by rr.no desc FETCH FIRST 10 ROWS ONLY


SELECT * from review;


SELECT rr.name name, 
rr.address address, 
rr.work_hours hours, 
rr.menu menu, 
rr.phone phone, 
rr.naver_food_type type
FROM restaurant rr left join review rv on rr.no = rv.restaurant_no
where (rr.menu like '%서울%' or rr.address like '%서울%')order by rr.no desc FETCH FIRST 10 ROWS ONLY;


SELECT rr.name name, 
rr.address address, 
rr.work_hours hours, 
rr.menu menu, 
rr.phone phone, 
rr.naver_food_type type
FROM restaurant rr left join review rv on rr.no = rv.restaurant_no
where (rr.menu like '%서울%' or rr.address like '%서울%');;


chltlstns

	select * from review
	where content like '%${searchWord}%'
	order by overall_score desc 
	FETCH FIRST 10 ROWS ONLY;

SELECT g.*, r.*
from gather g left join restaurant r
on g.restaurant_no = r.no
where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(g.meet_date, 'YYYYMMDDHH24MISS')
and (g.title like '%피자%' or g.content like '%피자%') ORDER BY g.no desc FETCH FIRST 10 ROWS ONLY;

where no = '3110000-101-2022-00129';
--
SELECT * FROM review ORDER BY overall_score DESC FETCH FIRST 5 ROWS ONLY;

SELECT m.name, r.* FROM review r left join member m on m.no = r.user_no;
    
    select count(*) from
	select * from review r left join member m on m.no = r.user_no
	where r.content like '%먹짱%' or m.name like '%먹짱%'
	order by r.overall_score desc
    union all;
    
    
    select count(*) from(
    SELECT count(*) FROM review
    union all
    SELECT count(*) FROM gather)
    group by rollup count(*);
    
	FETCH FIRST 10 ROWS ONLY;

	SELECT * FROM gather
	where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(meet_date, 'YYYYMMDDHH24MISS')
	and (title like '%xkzh%' or content like '%메뉴%')
	ORDER BY no desc FETCH FIRST 10 ROWS ONLY;

--
SELECT * FROM gather ORDER BY no;
SELECT * FROM gather ORDER BY no asc FETCH FIRST 3 ROWS ONLY;
SELECT * FROM gather ORDER BY meet_date DESC FETCH FIRST 3 ROWS ONLY;

--CREATE OR REPLACE TRIGGER review_insert 
--AFTER INSERT 
--ON review
--FOR EACH ROW
--BEGIN
--
--    INSERT INTO review_count
--    (review_date)
--      VALUES
--      (sysdate);
--      
--END review_insert;

select * from review order by overall_score;
select * from review order by no;
select * from review_count;

insert into review
values(SEQ_REVIEW_NO.nextval,61, '3010000-101-2017-00021', 4, 3, 3, 5, '기대 안하고 갔는데, 너무 맛있게 먹었습니다!!!!', 153);
commit;
rollback;





SELECT
	rr.name name, 
	rr.address address, 
	rr.work_hours hours, 
	rr.menu menu, 
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	where rr.menu like '%피자%'
		or rr.address like '%피자%'
	order by          
		WHEN 1=1
			THEN rr.no
           	else gc.pop
	    	end desc
   	FETCH FIRST 10 ROWS ONLY;



--============================================

	SELECT
    rv.no no,
    m.name userName,
    rr.name restaurantName,
    rv.overall_score overallScore,
    rv.taste_score tasteScore,
    rv.price_score priceScore,
    rv.service_score serviceScore,
    rv.content content,
    rr.address address
    FROM review rv 
        join restaurant rr on rv.restaurant_no = rr.no 
        join member m on rv.user_no = m.no
        join district d on rr.district_code = d.code
        join food_type f on rr.food_code = f.code
    where (m.name like '%피자%' or rr.name like '%피자%'
                or rv.content like '%피자%' or rr.address like '%피자%'
                or rr.menu like '%피자%');
    and rv.overall_score > 3
    and rv.taste_score > 3
    and rv.price_score > 3
    and rv.service_score > 3;

    select * from restaurant where district_code = 3200000;  
    select * from review;
    select * from review where content like '%피자%';
    select * from district;
    select * from food_type;
    select * from gather;    
    
			join (SELECT count(*) as attend, gather_no
					from member_gather group by gather_no) c
			on g.no = c.gather_no
				where <![CDATA[TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(g.meet_date, 'YYYYMMDDHH24MISS')]]>
					and (g.title like '%${searchWord}%' or g.content like '%${searchWord}%')
			ORDER BY CASE
            	WHEN 1=#{typeCheck} THEN g.no
            	else c.attend
    		end desc NULLS LAST FETCH FIRST 10 ROWS ONLY




	SELECT * FROM gather g
			join (SELECT count(*) as attend, gather_no
					from member_gather group by gather_no) c
			on g.no = c.gather_no
				where TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') < TO_CHAR(g.meet_date, 'YYYYMMDDHH24MISS')
					and (g.title like '%피자%' or g.content like '%피자%')
			ORDER BY CASE
            	WHEN 1=1 THEN g.no
            	else c.attend
    		end desc NULLS LAST FETCH FIRST 10 ROWS ONLY;


    SELECT
    rv.no no,
    m.name userName,
    rr.name restaurantName,
    rr.address address,
    rv.overall_score overallScore,
    rv.taste_score tasteScore,
    rv.price_score priceScore,
    rv.service_score serviceScore,
    rv.content content,
    rr.district_code districtCode,
    rr.name restaurantName
    FROM review rv 
        join restaurant rr on rv.restaurant_no = rr.no 
        join member m on rv.user_no = m.no
        join district d on rr.district_code = d.code
        join food_type f on rr.food_code = f.code
        join REVIEW_IMAGE  ri on ri.review_no = rv.no
    where (m.name like '%${keyword}%' or rr.name like '%${keyword}%'
                or rv.content like '%${keyword}%' or rr.address like '%${keyword}%'
                or rr.menu like '%${keyword}%')
    and <![CDATA[rv.overall_score > ${overallScore}]]>
    and <![CDATA[rv.taste_score > ${tasteScore}]]>
    and <![CDATA[rv.price_score > ${priceScore}]]>
    and <![CDATA[rv.service_score > ${serviceScore}]]>
    ORDER BY CASE
            WHEN 1=1 THEN rv.no
           		else rv.overall_score
    	end desc NULLS LAST FETCH FIRST 10 ROWS ONLY; 


	select m.name, r.*,ri.* from review r
		join member m on m.no = r.user_no
        join REVIEW_IMAGE  ri on ri.review_no = r.no
		where r.content like '%피자%'
			or m.name like '%피자%'
		ORDER BY CASE
            WHEN 1=1 THEN r.no
           		else r.overall_score
    	end desc NULLS LAST FETCH FIRST 10 ROWS ONLY;

    select * from district;

	SELECT * FROM gather g
			left join (SELECT count(*) as attend, gather_no
					from member_gather group by gather_no) c
			on g.no = c.gather_no
            left join district d on g.district_code = d.code
				where (g.title like '% %' or g.content like '% %' or d.name like '% %') -- 여기에 keyword
                        and (0 <= g.age_Restriction_Top)
                        and (0 >= g.age_Restriction_Bottom)
                        and g.count < 4;
                        
                        
                        	SELECT
    rv.no no,
    m.name userName,
    rr.name restaurantName,
    rr.address address,
    rv.overall_score overallScore,
    rv.taste_score tasteScore,
    rv.price_score priceScore,
    rv.service_score serviceScore,
    rv.content content,
    rr.district_code districtCode,
    f.code foodType
    FROM review rv 
        join restaurant rr on rv.restaurant_no = rr.no 
        join member m on rv.user_no = m.no
        join district d on rr.district_code = d.code
        join food_type f on rr.food_code = f.code
    where (m.name like '%%' or rr.name like '%%'
                or rv.content like '%%' or rr.address like '%%'
                or rr.menu like '%%')
    and rv.overall_score > 1
    and rv.taste_score > 1
    and rv.price_score > 1
    and rv.service_score > 1;
    
    SELECT * FROM restaurant;
    
    select count(*) as total,
            g.*,
            c.*,
            d.code districtCode,
            d.name districtName,
            rr.name restaurantName,
            rr.address restaurantaddress,
            m.name userName,
            f.type foodType
    from (
    	SELECT 
            *
        FROM gather g
			left join (SELECT count(*) as attend, gather_no from member_gather group by gather_no) c on g.no = c.gather_no
            left join restaurant rr on rr.no = g.restaurant_no 
            left join district d on g.district_code = d.code
            left join review_image ri on ri.restaurant_no = rr.no
            left join member m on m.no = g.user_no
            left join food_type f on f.code = rr.food_code
				where (g.title like '%%' or g.content like '%%' or d.name like '%%')
                        and 30 >= g.age_Restriction_Top
                        and  g.age_Restriction_Bottom >= 0
                        and g.count < 999);
                        
    	SELECT 
            count(*)
        FROM gather g
			left join (SELECT count(*) as attend, gather_no from member_gather group by gather_no) c on g.no = c.gather_no
            left join restaurant rr on rr.no = g.restaurant_no 
            left join district d on g.district_code = d.code
            left join review_image ri on ri.restaurant_no = rr.no
            left join member m on m.no = g.user_no
            left join food_type f on f.code = rr.food_code
				where (g.title like '%%' or g.content like '%%' or d.name like '%%')
                        and 30 >= g.age_Restriction_Top
                        and  g.age_Restriction_Bottom >= 0
                        and g.count < 999;
                
                select * from gather;
                SELECT
	rr.name name, 
	rr.address address, 
	rr.work_hours hours, 
	rr.menu menu, 
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop pop,
	rn.rwn rwn,
    rv.overall_score overall,
    rv.taste_score tastes,
    rv.price_score price,
    rv.service_score servicee,
    ri.image_name imagename,
    d.code districtcode
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
    left join REVIEW_IMAGE  ri on ri.review_no = rv.no
    left join district d on rr.district_code = d.code;
    
    
    
    
    SELECT
	rr.name name, 
	rr.address address,
	rr.work_hours hours,
	rr.menu menu,
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop pop,
	rn.rwn rwn,
    rv.overall_score overall,
    rv.taste_score tastes,
    rv.price_score price,
    rv.service_score servicee,
    ri.image_name imagename,
    d.code districtcode
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
    left join REVIEW_IMAGE  ri on ri.review_no = rv.no
    left join district d on rr.district_code = d.code;
    
select count(*) from    
(SELECT
    *
    FROM review rv 
        join restaurant rr on rv.restaurant_no = rr.no 
        join member m on rv.user_no = m.no
        join district d on rr.district_code = d.code
        join food_type f on rr.food_code = f.code
        where (m.name like '%%' or rr.name like '%%'
                or rv.content like '%%' or rr.address like '%%'
                or rr.menu like '%%')
    and rv.overall_score >1
    and rv.taste_score > 1
    and rv.price_score >1
    and rv.service_score > 1);
    
    
    
    	SELECT
    rv.no no,
    m.name userName,
    rr.name restaurantName,
    rr.address address,
    rv.overall_score overallScore,
    rv.taste_score tasteScore,
    rv.price_score priceScore,
    rv.service_score serviceScore,
    rv.content content,
    rr.district_code districtCode,
    f.code foodType
    FROM review rv 
        join restaurant rr on rv.restaurant_no = rr.no 
        join member m on rv.user_no = m.no
        join district d on rr.district_code = d.code
        join food_type f on rr.food_code = f.code;
        
        
        select * from gather;
        
        	SELECT * FROM gather g
			left join (SELECT count(*) as attend, gather_no
					from member_gather group by gather_no) c
			on g.no = c.gather_no
            left join district d on g.district_code = d.code;
            
            SELECT 
            g.*,
            c.attend,
            ri.*,
            d.code districtCode,
            d.name districtName,
            rr.name restaurantName,
            rr.address address,
            m.name userName,
            f.type foodType
        FROM gather g
			left join (SELECT count(*) as attend, gather_no from member_gather group by gather_no) c on g.no = c.gather_no
            left join restaurant rr on rr.no = g.restaurant_no 
            left join district d on g.district_code = d.code
            left join review rv on rv.user_no = g.user_no
            left join review_image ri on ri.restaurant_no = rr.no
            left join member m on m.no = g.user_no
            left join food_type f on f.code = rr.food_code
            where rv.user_no = g.user_no;
            
SELECT DISTINCT
            g.title,
            c.attend,
            d.code districtCode,
            d.name districtName,
            rr.name restaurantName,
            rr.address address,
            m.name userName,
            f.type foodType
        FROM gather g
			left join (SELECT count(*) as attend, gather_no from member_gather group by gather_no) c on g.no = c.gather_no
            left join restaurant rr on rr.no = g.restaurant_no 
            left join district d on g.district_code = d.code
            left join review rv on rv.restaurant_no = g.restaurant_no
            left join member m on m.no = g.user_no
            left join food_type f on f.code = rr.food_code;

            select * from review; -- 여기 리뷰 넘버
            
            select * from review_image; -- 여기 리뷰 넘버
            select * from gather; -- 여기 유저 넘버
            
            select * from gather g left join restaurant rr on rr.no = g.restaurant_no
            left join review rv on rv.user_no = g.user_no
            where g.user_no = rv.user_no and ;
            
            select * from restaurant rr left join gather g on rr.no = g.restaurant_no;
            
            SELECT count(*) as attend, gather_no from member_gather group by gather_no;
            
            
            
            SELECT
	rr.name name, 
	rr.name no,
	rr.address address,
	rr.work_hours hours,
	rr.menu menu,
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop pop,
	rn.rwn rwn,
    rv.overall_score overall,
    rv.taste_score tastes,
    rv.price_score price,
    rv.service_score servicee,
    ri.image_name imagename,
    d.code districtcode
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
    left join REVIEW_IMAGE  ri on ri.review_no = rv.no
    left join district d on rr.district_code = d.code
    order by rr.no;
    
    
    	SELECT
    rv.no no,
    m.name userName,
    rr.name restaurantName,
    rr.address address,
    rv.overall_score overallScore,
    rv.taste_score tasteScore,
    rv.price_score priceScore,
    rv.service_score serviceScore,
    rv.content content,
    rr.district_code districtCode,
    f.code foodType,
    ri.image_name imageName
    FROM review rv 
        left join restaurant rr on rv.restaurant_no = rr.no 
        left join member m on rv.user_no = m.no
        left join district d on rr.district_code = d.code
        left join food_type f on rr.food_code = f.code
        left join review_image ri on ri.review_no = rv.no;
            
            
SELECT
	rr.name name, 
	rr.address address,
	rr.work_hours hours,
	rr.menu menu,
	rr.phone phone, 
	rr.naver_food_type type,
	gc.pop pop,
	rn.rwn rwn,
    o.overall overall,
    o.taste tastes,
    o.price price,
    o.service service,
    ri.image_name imagename,
    d.code districtcode
FROM restaurant rr
	left join review rv on rr.no = rv.restaurant_no
	left join (select count(*) as pop, restaurant_no
				from gather group by restaurant_no) gc 
					on rr.no = gc.restaurant_no
	left join (select ROWNUM as rwn, r.*
  		from RESTAURANT r) rn
 			on rn.no = rr.no
    left join REVIEW_IMAGE  ri on ri.review_no = rv.no
    left join district d on rr.district_code = d.code
    left join (select avg(overall_score)overall,avg(taste_score) taste,
    avg(service_score) service, avg(price_score) price, restaurant_no from review group by restaurant_no) o
    on o.restaurant_no = rv.restaurant_no;

            
            SELECT
	rr.*
FROM restaurant rr
left join selreview rv on rr.name = ;
            select * from restaurant where name like '%뭉치치%';
            select * from  district;
            
            
CREATE TABLE VISITANT_COUNT (
	visitants_date	date		NOT NULL,
	visitants_number	number		NOT NULL,
CONSTRAINT pk_VISITANT_COUNT_visitants_date PRIMARY KEY(visitants_date)
);


-- 방문자 수 조회하기
    select count(*) as count,
            to_char(v.visitants_date, 'YYYYMMDD') as day
    from VISITANT_COUNT v
    group by to_char(v.visitants_date, 'YYYYMMDD');

-- 방문자 수 추가하기
    insert into VISITANT_COUNT values(sysdate, (select max(visitants_number) from VISITANT_COUNT
    where to_char(visitants_date, 'YYYYMMDD') = to_char(sysdate,'YYYYMMDD')));
    
    select avg(rv.overallNum) from
    (select * from restaurant rr
    join review rv
    on rv.restaurant_no = rr.no) c;

select avg(overall_score) overall,avg(taste_score) taste,
    avg(service_score) service, avg(price_score) price, restaurant_no from review rv group by restaurant_no;

select
rr.name,
at.overall,
at.taste,
at.service,
at.price
from restaurant rr
join 

select * from restaurant rr
join
() bb
on rr.no =   bb.restaurant_no;
order by 2 desc;

select
round(avg(overall_score),2) overall,
round(avg(service_score),2) service,
round(avg(taste_score),2) taste,
round(avg(price_score),2) price
from review;



select from review;

select
r.name,
s.score
from restaurant r
join
(select sum(overall + taste + service + price)/4 as score,restaurant_no from(
(select avg(overall_score) overall,avg(taste_score) taste,
    avg(service_score) service, avg(price_score) price, restaurant_no
    from review rv group by restaurant_no)) group by restaurant_no) s
on r.no = s.restaurant_no;

select sum(overall_score + price_score + service_score + taste_score), restaurant_no from review group by restaurant_no;

select avg(overall_score) overall,avg(taste_score) taste,
    avg(service_score) service, avg(price_score) price, restaurant_no
    from review rv group by restaurant_no;

select * from member;
select count(*),to_char(enrolled_at,'YYYYMMDD') as enroll from member group by to_char(enrolled_at,'YYYYMMDD');

select count(*),to_char(deleted_at,'YYYYMMDD') as deleted from member group by to_char(deleted_at,'YYYYMMDD');

select
round(avg(overall_score),2) overall,
round(avg(service_score),2) service,
round(avg(taste_score),2) taste,
round(avg(price_score),2) price
from review;

select * from review;

-- 회원 가입 수
select count(*) as count, to_date(enrolled_at,'YYYY-MM-DD') as day from member group by to_date(enrolled_at, 'YYYY-MM-DD');

-- 모임 수
select to_date(meet_date,'YYYY-MM-DD') as day, count(*) as count from gather group by to_date(meet_date,'YYYY-MM-DD')
order by to_date(meet_date,'YYYY-MM-DD');

-- 이게 현재 모임 참여자 수다
select count(*)
from
(select * from member_gather mg
left join gather g on mg.gather_no = g.no
where g.meet_date > sysdate);

-- 이게 전날 모임 참여자 수다
select count(*)
from
(select * from member_gather mg
left join gather g on mg.gather_no = g.no
where g.meet_date > sysdate-1);



-- 현재 활동 중인 모임 수
select count(*)
from
(select * from gather
where meet_date > sysdate);

-- 전일 대비
select count(*)
from
(select * from gather
where meet_date > sysdate);


select
round(avg(overall_score),2) overall,
round(avg(service_score),2) service,
round(avg(taste_score),2) taste,
round(avg(price_score),2) price
from review;


select
d.name,
count(d.name)
from gather g
left join district d
on g.district_code = d.code
group by d.name;

left join restaurant rr
on g.restaurant_no = rr.no;


select * from review_image ri
left join review rv on ri.review_no = rv.no;
	to_date(meet_date,'YYYY-MM-DD') as day,
	count(*) as count
from
	gather group by to_date(meet_date,'YYYY-MM-DD')
	order by to_date(meet_date,'YYYY-MM-DD');