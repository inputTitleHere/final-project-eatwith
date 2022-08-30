-- TEST TABLE
create table tester_table(
    no number
);
insert into tester_table values(20);
commit;
select * from tester_table;

-- 백승윤 START

CREATE TABLE MEMBER (
	no	number		NOT NULL,
	id	varchar2(30)		NOT NULL,
	name	varchar2(30)		NOT NULL,
	password	varchar2(300)		NOT NULL,
	email	varchar2(128)		NOT NULL,
	phone	char(11)		NOT NULL,
	enrolled_at	Date	DEFAULT sysdate	NOT NULL,
	role	char(1)	DEFAULT 'U'	NOT NULL,
	point	number	DEFAULT 0	NOT NULL,
	age	number		NOT NULL,
	gender	char(1)		NOT NULL,
  CONSTRAINT pk_member_no PRIMARY KEY(no)
);
select * from member;
--alter table member add deleted_at date;

COMMENT ON COLUMN MEMBER.no IS 'seq_member_no.nextval';
COMMENT ON COLUMN MEMBER.id IS '아이디는 로그인용';
COMMENT ON COLUMN MEMBER.name IS '닉네임은 표시용';
COMMENT ON COLUMN MEMBER.role IS '어드민 계정은 sqlDev으로 만들기';

CREATE TABLE GATHER (
	no	number		NOT NULL,
	restaurant_no	char(22)		NOT NULL,
	title	varchar2(30)		NOT NULL,
	count	number		NOT NULL,
	meet_date	Date		NOT NULL,
	food_code	char(3)		NOT NULL,
	district_code	char(7)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	user_no	number		NOT NULL,
	age_restriction_top	number		NULL,
	age_restriction_bottom	number		NULL,
	gender_restriction	char(1)		NULL,
  CONSTRAINT pk_gather_no PRIMARY KEY(no),
  CONSTRAINT fk_gather_restaurant_no FOREIGN KEY(restaurant_no) references RESTAURANT(no) on delete cascade,
  CONSTRAINT fk_gather_food_code FOREIGN KEY(food_code) references FOOD_TYPE(code) on delete set null,
  CONSTRAINT fk_gather_district_code FOREIGN KEY(district_code) references DISTRICT(code) on delete set null,
  CONSTRAINT fk_gather_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete cascade
);

COMMENT ON COLUMN GATHER.no IS 'seq_gather_no.nextval';
COMMENT ON COLUMN GATHER.user_no IS 'seq_member_no.nextval';

CREATE TABLE NOTIFICATION (
	no	number		NOT NULL,
	user_no	number		NOT NULL,
	content	varchar2(4000)	DEFAULT '내용물이 없습니다.'	NOT NULL,
	sent_at	Date	DEFAULT sysdate	NOT NULL,
	read_at	Date		NULL,
	deleted_at	Date		NULL,
  CONSTRAINT pk_notification_no PRIMARY KEY(no),
  CONSTRAINT fk_notification_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete cascade
);

COMMENT ON COLUMN NOTIFICATION.no IS 'seq_notification_no.nextval';
COMMENT ON COLUMN NOTIFICATION.user_no IS 'seq_member_no.nextval';
COMMENT ON COLUMN NOTIFICATION.content IS '여기 내용에 링크 등 필요한거 다 걸어서 그냥 넣기';

CREATE TABLE NOTICE (
	notice_no	number		NOT NULL,
	notice_title	varchar2(100)		NOT NULL,
	notice_contents	varchar2(500)		NOT NULL,
	notice_date	Date	DEFAULT sysdate	NOT NULL,
	deleted_at	Date		NULL,
	updated_at	Date		NULL,
  CONSTRAINT pk_notice_notice_no PRIMARY KEY(notice_no)
);

COMMENT ON COLUMN NOTICE.notice_no IS 'seq_notice_no';

CREATE TABLE DISTRICT (
	code	char(7)		NOT NULL,
	name	varchar2(15)		NOT NULL,
  CONSTRAINT pk_district_code PRIMARY KEY(code)
);

CREATE TABLE VISITANT_COUNT (
	visitants_date	date		NOT NULL,
	visitants_number	number		NOT NULL,
  CONSTRAINT pk_VISITANT_COUNT_visitants_date PRIMARY KEY(visitants_date)
);

COMMENT ON COLUMN VISITANT_COUNT.visitants_date IS '자바코드 관리';
COMMENT ON COLUMN VISITANT_COUNT.visitants_number IS '자바코드 관리';

CREATE TABLE FOOD_TYPE (
	code	char(3)		NOT NULL,
	type	varchar2(45)		NOT NULL,
  CONSTRAINT pk_food_type_code PRIMARY KEY(code)
);

CREATE TABLE RESTAURANT (
	no	 char(22)		NOT NULL,
	district_code char(7)		NOT NULL,
	food_code	char(3)		NOT NULL,
	name	varchar2(256)		NOT NULL,
	dong 	varchar2(50)		NOT NULL,
	address	 varchar2(256)		NOT NULL,
	work_hours	varchar2(1024)		NULL,
	menu	varchar2(1024)		NULL,
	phone	varchar2(45)		NULL,
	naver_food_type	varchar2(60)		NULL,
  CONSTRAINT pk_restaurant_no PRIMARY KEY(no),
  CONSTRAINT fk_restaurant_destrict_code FOREIGN KEY(district_code) references DISTRICT(code) on delete set null,
  CONSTRAINT fk_restaurant_food_code FOREIGN KEY(food_code) references FOOD_TYPE(code) on delete set null
);

COMMENT ON COLUMN RESTAURANT.no IS '공공데이터의 사업자등록번호를 고유키로 사용';

CREATE TABLE REVIEW (
	no	number		NOT NULL,
	gather_no	number		NOT NULL,
	restaurant_no	char(22)		NOT NULL,
	overall_score	number		NOT NULL,
	taste_score	number		NOT NULL,
	price_score	number		NOT NULL,
	service_score	number		NOT NULL,
	content	varchar2(4000)		NOT NULL,
  CONSTRAINT pk_review_no PRIMARY KEY(no),
  CONSTRAINT fk_review_gather_no FOREIGN KEY(gather_no) references GATHER(no) on delete set null,
  CONSTRAINT fk_review_restaurant_no FOREIGN KEY(restaurant_no) references RESTAURANT(no) on delete set null
);

COMMENT ON COLUMN REVIEW.no IS 'seq_review_no';
COMMENT ON COLUMN REVIEW.gather_no IS 'seq_gather_no.nextval';

CREATE TABLE ENROLL_COUNT (
	user_no	number		NOT NULL,
	enroll_at	Date	DEFAULT sysdate	NOT NULL,
  CONSTRAINT fk_enroll_count_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete set null
);

COMMENT ON COLUMN ENROLL_COUNT.user_no IS 'seq_member_no.nextval';

CREATE TABLE FAVORITE_RESTAURANT (
	user_no	number		NOT NULL,
	restaurant_no	char(22)		NOT NULL,
  CONSTRAINT fk_favorite_restaurant_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete cascade,
  CONSTRAINT fk_favorite_restaurant_restaurant_no FOREIGN KEY(restaurant_no) references RESTAURANT(no) on delete cascade
);

COMMENT ON COLUMN FAVORITE_RESTAURANT.user_no IS 'seq_member_no.nextval';

CREATE TABLE REVIEW_IMAGE (
	no	number		NOT NULL,
	restaurant_no	char(22)		NOT NULL,
	review_no	number		NOT NULL,
	image_name	varchar2(30)		NOT NULL,
  CONSTRAINT pk_review_image_no PRIMARY KEY(no),
  CONSTRAINT fk_review_image_restaurant_no FOREIGN KEY(restaurant_no) references RESTAURANT(no) on delete set null,
  CONSTRAINT fk_review_image_review_no FOREIGN KEY(review_no) references REVIEW(no) on delete cascade
);

COMMENT ON COLUMN REVIEW_IMAGE.no IS 'seq_review_image_no';
COMMENT ON COLUMN REVIEW_IMAGE.review_no IS 'seq_review_no';

CREATE TABLE MEMBER_GATHER (
	user_no	number		NOT NULL,
	gather_no	number		NOT NULL,
	enroll_at	Date	DEFAULT sysdate	NOT NULL,
  constraint fk_member_gather_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete cascade,
  constraint fk_member_gather_gather_no FOREIGN KEY(gather_no) references GATHER(no) on delete cascade
);

COMMENT ON COLUMN MEMBER_GATHER.user_no IS 'seq_member_no.nextval';
COMMENT ON COLUMN MEMBER_GATHER.gather_no IS 'seq_gather_no.nextval';

CREATE TABLE AUTHORITY (
	auth	varchar2(50)		NOT NULL,
	no	number		NOT NULL,
  constraint pk_authority_auth PRIMARY KEY(auth),
  constraint fk_authority_no FOREIGN KEY(no) references MEMBER(no) on delete cascade
);

COMMENT ON COLUMN AUTHORITY.auth IS '유저번호와 함께 복합PK이룸';
COMMENT ON COLUMN AUTHORITY.no IS 'is PK and FK';

CREATE TABLE FAVORITE_FOOD (
	no	number		NOT NULL,
	code	char(3)		NOT NULL,
  constraint fk_favorite_food_no FOREIGN KEY(no) references MEMBER(no) on delete cascade,
  constraint fk_favorite_food_code FOREIGN KEY(code) references FOOD_TYPE(code) on delete cascade
);

COMMENT ON COLUMN FAVORITE_FOOD.no IS 'seq_member_no.nextval';

CREATE TABLE FAVORITE_DISTRICT (
	no	number		NOT NULL,
	code	char(7)		NOT NULL,
  constraint fk_favorite_district_no FOREIGN KEY(no) references MEMBER(no) on delete cascade,
  constraint fk_favorite_district_code FOREIGN KEY(code) references DISTRICT(code) on delete cascade
);

COMMENT ON COLUMN FAVORITE_DISTRICT.no IS 'seq_member_no.nextval';

-- 이거는 일단 보류------------------------------------------------------------------
-- CREATE TABLE QUIT_MEMBER (
-- 	no	number		NOT NULL,
-- 	id	varchar2(30)		NOT NULL,
-- 	name	varchar2(30)		NOT NULL,
-- 	passoword	varchar2(300)		NOT NULL,
-- 	email	varchar2(128)		NOT NULL,
-- 	phone	char(11)		NOT NULL,
-- 	enrolled_at	Date	DEFAULT sysdate	NOT NULL,
-- 	role	char(1)	DEFAULT 'U'	NOT NULL,
-- 	point	number	DEFAULT 0	NOT NULL,
-- 	age	number		NOT NULL,
-- 	gender	char(1)		NOT NULL,
-- 	quit_at	Date		NOT NULL
-- );

-- COMMENT ON COLUMN QUIT_MEMBER.no IS 'seq_member_no.nextval';
-- COMMENT ON COLUMN QUIT_MEMBER.id IS '아이디는 로그인용';
-- COMMENT ON COLUMN QUIT_MEMBER.name IS '닉네임은 표시용';
-- COMMENT ON COLUMN QUIT_MEMBER.role IS '어드민 계정은 sqlDev으로 만들기';

CREATE TABLE CHAT_MEMBER (
	chatroom_id	varchar2(50)		NOT NULL,
	user_no	number		NOT NULL,
	last_check	number		NULL,
	joined_at	Date	DEFAULT sysdate	NULL,
	deleted_at	Date		NULL,
  constraint pk_chat_member_chatroom_id_user_no PRIMARY KEY(chatroom_id,user_no),
  constraint fk_chat_member_user_no FOREIGN KEY(user_no) references MEMBER(no) on delete cascade
);

COMMENT ON COLUMN CHAT_MEMBER.chatroom_id IS 'java단에서 난수생성';
COMMENT ON COLUMN CHAT_MEMBER.user_no IS '복합 pk으로 사용';

CREATE TABLE CHAT_LOG (
	no	number		NOT NULL,
	chatroom_id	varchar2(50)		NOT NULL,
	user_no	number		NOT NULL,
	msg	varchar2(4000)		NULL,
	time	number		NULL,
  constraint pk_chat_log_no PRIMARY KEY(no),
  constraint fk_chat_log_chatroom_id FOREIGN KEY(chatroom_id,user_no) references CHAT_MEMBER(chatroom_id,user_no) on delete cascade
);

COMMENT ON COLUMN CHAT_LOG.no IS 'seq_chat_log_no';
COMMENT ON COLUMN CHAT_LOG.user_no IS 'seq_member_no.nextval';

create sequence test_seq;
select test_seq.nextval from dual;
select test_seq.currval from dual;

-- member 시퀀스
create sequence seq_member_no;
select seq_member_no.currval from dual;
-- gather 시퀀스
create sequence seq_gather_no;

-- notification 시퀀스
create sequence seq_notification_no;

-- review 시퀀스
create sequence seq_review_no;

-- review image 시퀀스
create sequence seq_review_image_no;

-- notice 시퀀스
create sequence seq_notice_no;

-- chat_log 시퀀스
create sequence seq_chat_log_no;




-- 백승윤 END

-- 박우석 START

-- 박우석 END

-- 신유경 START

-- 신유경 END

-- 임규완 START

-- 임규완 END



































