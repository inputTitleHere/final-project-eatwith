select * from gather order by no;
select*from restaurant;
select*from food_type;
select*from member;

insert into gather values(seq_gather_no.nextval,'3220000-101-1997-12699','이동네 최고 중국집 당장가실분 =3',2,to_date('2022-09-11 11:30','YYYY-MM-DD hh24:mi'),'001','3220000','중국집조질사람구함',146,null,null,null);
insert into gather values(seq_gather_no.nextval,'3220000-101-2022-00526','족발은 살안쪄',3,to_date('2022-09-11 11:30','YYYY-MM-DD hh24:mi'),'007','3220000','귀한족발에서 족발 한번 조집시다.. 또래환영',142,24,27,null);


commit;