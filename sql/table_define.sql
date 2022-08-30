create table tester_table(
    no number
);

insert into tester_table values(20);
commit;

select * from tester_table;