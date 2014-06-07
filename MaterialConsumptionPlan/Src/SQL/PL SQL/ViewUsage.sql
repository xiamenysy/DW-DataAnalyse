视图实际上是一个或多个表上的预定义查询，这些表称为基表。
视图并不存储数据，只是在查询视图时才访问基表。
视图的优点：
    ·限制用户只能通过视图检索数据，对用户屏蔽基表
    ·可以将复杂的查询编写为视图，减少用户查询的复杂度
    ·限制某个视图只能访问基表中的部分数据，提高了安全性
//
创建视图
create [or replace] [{force|noforce}] view view_name
[(alias_name[,alias_name...])]
as subquery
[with {check option|read only} constraint constraint_name]
or replace:如果视图存在就替换它。
force:即使基表不存在也要建立该视图。
noforce:若基表不存在就不建立此视图，默认值。
view_name:视图名称。
alias_name:为自查询中的表达式指定一个别名，别名个数与子查询中列数相同。
subquery:指定一个子查询，它对基表进行查询，如果已经提供别名，可以在select子句之后的列表中使用别名
with check option:表名只有子查询检索的行才能被插入、删除、更新，
                  默认情况下，在插入、删除、更新行之前并不会检查这些行是否被子查询检索。
constraint_name:指定with check option或read only约束的名称。
with read only:说明只能对基表中的行进行只读访问。
//
视图有两种基表类型
·简单视图，包含一个子查询，它只能从一个基表中检索数据
·复杂视图，包含一个子查询，有以下特点：
  ·从多个基表中检索数据
  ·使用group by或distinct子句对行进行分组
  ·包含函数调用
//
实例1:
//
测试数据:
SQL> select * from emp;
EMPNO ENAME      JOB         MGR HIREDATE          SAL      COMM DEPTNO
----- ---------- --------- ----- ----------- --------- --------- ------
 7369 SMITH      CLERK      7902 1980-12-17     800.00               20
 7499 ALLEN      SALESMAN   7698 1981-2-20     1600.00    300.00     30
 7521 WARD       SALESMAN   7698 1981-2-22     1250.00    500.00     30
 7566 JONES      MANAGER    7839 1981-4-2      2975.00               20
 7654 MARTIN     SALESMAN   7698 1981-9-28     1250.00   1400.00     30
 7698 BLAKE      MANAGER    7839 1981-5-1      2850.00               30
 7782 CLARK      MANAGER    7839 1981-6-9      2450.00               10
 7788 SCOTT      ANALYST    7566 1987-4-19     3000.00               20
 7839 KING       PRESIDENT       1981-11-17    5000.00               10
 7844 TURNER     SALESMAN   7698 1981-9-8      1500.00      0.00     30
 7876 ADAMS      CLERK      7788 1987-5-23     1100.00               20
 7900 JAMES      CLERK      7698 1981-12-3      950.00               30
 7902 FORD       ANALYST    7566 1981-12-3     3000.00               20
 7934 MILLER     CLERK      7782 1982-1-23     1300.00               10
//
SQL> select * from dept;
DEPTNO DNAME          LOC
------ -------------- -------------
    10 ACCOUNTING     NEW YORK
    20 RESEARCH       DALLAS
    30 SALES          CHICAGO
    40 OPERATIONS     BOSTON
为emp表建立一个简单视图，访问emp表的属性(empno,ename,job,sal)，并且sal>1200的员工
create view view_emp as
select empno,ename,job,sal
from emp
where sal>1200;
//
select * from view_emp;
EMPNO ENAME      JOB             SAL
----- ---------- --------- ---------
 7499 ALLEN      SALESMAN    1600.00
 7521 WARD       SALESMAN    1250.00
 7566 JONES      MANAGER     2975.00
 7654 MARTIN     SALESMAN    1250.00
 7698 BLAKE      MANAGER     2850.00
 7782 CLARK      MANAGER     2450.00
 7788 SCOTT      ANALYST     3000.00
 7839 KING       PRESIDENT   5000.00
 7844 TURNER     SALESMAN    1500.00
 7902 FORD       ANALYST     3000.00
 7934 MILLER     CLERK       1300.00
/*从结果可知,我们将emp表中薪水大于1200的员工的empno,ename,sal查询了出来*/
实例2：
建立一个复杂视图
create or replace view view_emp_dept as
select d.deptno,d.dname,min(e.sal) min_sal,max(e.sal) max_sal
from emp e,dept d
where e.deptno=d.deptno(+)
group by d.deptno,d.dname;
//
select * from view_emp_dept;
DEPTNO DNAME             MIN_SAL    MAX_SAL
------ -------------- ---------- ----------
    10 ACCOUNTING           1300       5000
    20 RESEARCH              800       3000
    30 SALES                 950       2850
/*正如我们所期待的,我们将scott用户下的emp表和dept表连接起来:
emp.deptno=dept.deptno(+),左外连接,
既按照emp表中的部门来查询:
部门号(deptno),部门名称(dname),部门最低薪水(min_sal),部门最高薪水(max_sal).*/
修改视图
修改视图时加上or replace即可,例如:
create view view_emp_sal as
select ename,job,deptno,sal
from emp
where sal>1000;
//
create or replace view view_emp_sal as
select ename,job,deptno,sal*12
from emp
where sal>1000;
//
编译视图
当基表改变时,建立在基表上的视图就会无效,
我们可以通过下面这条语句从数据字典中查询无效的视图:
select 'alter view'||owner||'.'||object_name||'compile;'
from dba_objects
where status='INVALID' and object_type='VIEW';
//
删除视图
drop view view_name;
//
获取视图信息
通过查看user_views视图
SQL> desc user_views;
Name             Type           Nullable Default Comments                                                   
---------------- -------------- -------- ------- ---------------------------------------------------------- 
VIEW_NAME        VARCHAR2(30)                    Name of the view                                           
TEXT_LENGTH      NUMBER         Y                Length of the view text                                    
TEXT             LONG           Y                View text                                                  
TYPE_TEXT_LENGTH NUMBER         Y                Length of the type clause of the object view               
TYPE_TEXT        VARCHAR2(4000) Y                Type clause of the object view                             
OID_TEXT_LENGTH  NUMBER         Y                Length of the WITH OBJECT OID clause of the object view    
OID_TEXT         VARCHAR2(4000) Y                WITH OBJECT OID clause of the object view                  
VIEW_TYPE_OWNER  VARCHAR2(30)   Y                Owner of the type of the view if the view is a object view 
VIEW_TYPE        VARCHAR2(30)   Y                Type of the view if the view is a object view              
SUPERVIEW_NAME   VARCHAR2(30)   Y                Name of the superview, if view is a subview                
//
SQL> select view_name,text_length,text
  2  from user_views;
VIEW_NAME                      TEXT_LENGTH TEXT
------------------------------ ----------- --------------------------------------------------------------------------------
VIEW_EMP                                52 select empno,ename,job,sal
                                           from emp
                                           where sal>1200
VIEW_EMP_DEPT                          134 select d.deptno,d.dname,min(e.sal) min_sal,max(e.sal) max_sal
                                           from emp e,dept d
//