----####SQL: for new Users Yearly###----
SELECT datepart(year,creationdate) Years, count(*) Users FROM users
where datepart(year,creationdate) <= 2018
group by datepart(year,creationdate)

--### SQL: Yearly questions posted on SO### --
SELECT datepart(year,creationdate) Years, count(*) Questions FROM posts
where posttypeid = 1 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 


--######### Yearly question in percentage###########----------
		
		-----#### Version1: Yearly unasnwered Question ###-----
		-- total Questions : 16867398
		select datepart(year,creationdate) Years, count(*) QuestionsYearly,
		(count(*)/cast(16867398 as float))*100 as percentage,
		cast(round((count(*)/cast(16867398 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(*) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(*)/cast(16867398 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge  FROM posts
		where posttypeid = 1 and datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate) 
		
		-----#### Version 2: Yearly unasnwered Question ###-----
		-- total Questions : 16867398 we also include unasnwered question and non accepteded answer combindly 
		select datepart(year,creationdate) Years, count(*) UnAnsweredYearly,
		(count(*)/cast(16867398 as float))*100 as percentage,
		cast(round((count(*)/cast(16867398 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(*) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(*)/cast(16867398 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge  from posts 
		where id not in (SELECT distinct id  FROM posts
		where posttypeid = 1 and AcceptedAnswerId is not null and datepart(year,creationdate) <= 2018  
		) and posttypeid = 1  and datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate)  
		

--- ### Yearly Answer ###------
SELECT datepart(year,creationdate) Years, count(*) Answers  FROM posts
where posttypeid = 2 and datepart(year,creationdate) <= 2018 --posttype = 2 means Answer
group by datepart(year,creationdate) 

-----### NUMBER of answer yearly in percentage ###
		-- total Questions : 16867398
		select datepart(year,creationdate) Years, count(*) Answers,
		(count(*)/cast(26056531 as float))*100 as percentage,
		cast(round((count(*)/cast(26056531 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(*) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(*)/cast(26056531 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge FROM posts
		where posttypeid = 2 and datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate)

----###Commments per year In Percentage###---
SELECT datepart(year,creationdate), count(*)  FROM comments
group by datepart(year,creationdate) 

		----## In Percentage ####
				
		--select 16867398 + 26056531 -- total: 42923929 (Q+A)
		select datepart(year,creationdate) Years, count(*) commentsRatioYearly,
		(count(*)/cast(42923929 as float))*100 as percentage,
		cast(round((count(*)/cast(42923929 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(*) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(*)/cast(42923929 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge  from comments
		where datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate)



---###unasnwered Questions yearly###---
select datepart(year,creationdate) Years, count(*) QuestionsNotAnswered  from posts 
where id not in (SELECT distinct parentid  FROM posts
where posttypeid = 2 and parentid is not null 
) and posttypeid = 1 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 


---- ###question with 0 score###-----
select datepart(year,creationdate) Years, count(*) QuestionsGotZero  from posts 
where posttypeid = 1 and score = 0 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 

---- ###Answer with 0 score###-----
select datepart(year,creationdate) Years, count(*) AnswersGotZero  from posts 
where posttypeid = 2 and score = 0 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 

----###Accepted Answer yearly###---
select datepart(year,creationdate) Years, count(*) acceptedAnsswer  from posts 
where posttypeid = 1 and AcceptedAnswerId is not null 
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 


-------Active Users asked Question  5 or more yearly---
select count(*) totalUsers from users where year(creationdate) <= 2018  -- 9810623
select resulttable.Years, count(resulttable.OwnerUserId) YearlyActiveuserbyQuestion from (
select datepart(year,creationdate) Years, OwnerUserId,  count(*) AskedQuestion5  from posts 
where posttypeid = 1 and OwnerUserId is not null 
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), OwnerUserId
having count(OwnerUserId) > 4
) resulttable 
group by resulttable.Years

---#######Users yearly in percentage#######-----
	   
		select datepart(year,creationdate) Years, count(*) usersYearly,
		(count(*)/cast(9810623 as float))*100 as percentage,
		cast(round((count(*)/cast(9810623 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(*) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(*)/cast(9810623 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge FROM users
		where datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate)
		order by datepart(year,creationdate)

----#######Active user yearly in percentage#######----
		
		select resulttable.Years Years, count(resulttable.OwnerUserId) ActiveusersByQuesYearly,
		(count(resulttable.OwnerUserId)/cast(9810623 as float))*100 as percentage,
		cast(round((count(resulttable.OwnerUserId)/cast(9810623 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(resulttable.OwnerUserId) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
		+cast( cast(round((count(resulttable.OwnerUserId)/cast(9810623 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge  from (
		select datepart(year,creationdate) Years, OwnerUserId,  count(*) AskedQuestion5  from posts 
		where posttypeid = 1 and OwnerUserId is not null 
		and datepart(year,creationdate) <= 2018
		group by datepart(year,creationdate), OwnerUserId
		having count(OwnerUserId) > 4
		) resulttable 
		group by resulttable.Years
		
		
---########### Considering running total of users to get active users #######----

		select resulttable.Years Years, count(resulttable.OwnerUserId) ActiveusersByQuesYearly,
		(count(resulttable.OwnerUserId)/(select cast(count(*) as float) from users where year(creationdate) <= resulttable.Years))*100 as percentage,
		cast(round((count(resulttable.OwnerUserId)/(select cast(count(*) as float) from users where year(creationdate) <= resulttable.Years)*100 ),2) as NUMERIC(15,2)) percentageRound,
		cast(count(resulttable.OwnerUserId) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
        +cast( cast(round((count(resulttable.OwnerUserId)/(select cast(count(*) as float) from users where year(creationdate) <= resulttable.Years)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
		'%)' StringPercentatge,
		runningTotalUsers = (select count(*) from users where year(creationdate) <= resulttable.Years)
		from (
		select datepart(year,posts.creationdate) Years, OwnerUserId,  count(*) AskedQuestion5  
        from posts where OwnerUserId is not null 
		and datepart(year,posts.creationdate) <= 2018
		group by datepart(year,posts.creationdate), posts.OwnerUserId
		having count(posts.OwnerUserId) > 4
		) resulttable 
		group by resulttable.Years
        order by resulttable.Years


----###Active User post 5 or more answers yearly###---
select resulttable.Years, count(resulttable.OwnerUserId) YearlyActiveuserbyAnswer from (
select datepart(year,creationdate) Years, OwnerUserId,  count(*) postAnswer5  from posts 
where posttypeid = 2 and OwnerUserId is not null 
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), OwnerUserId
having count(OwnerUserId) > 4
) resulttable 
group by resulttable.Years


-------###OneTime Question answerer yearly until 2018###---

select resulttable.Years, count(resulttable.OwnerUserId) OneTimeQanswerer from (
select datepart(year,creationdate) Years, OwnerUserId,  count(*) postAnswer5  from posts 
where posttypeid = 2 and OwnerUserId is not null 
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), OwnerUserId
having count(OwnerUserId) = 1
) resulttable 
group by resulttable.Years

-------###OneTime post Questions Users yearly until 2018###---

select resulttable.Years, count(resulttable.OwnerUserId) OneTimePostQuestions from (
select datepart(year,creationdate) Years, OwnerUserId,  count(*) postAnswer5  from posts 
where posttypeid = 1 and OwnerUserId is not null 
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), OwnerUserId
having count(OwnerUserId) = 1
) resulttable 
group by resulttable.Years


---###Did Not Answered AnyQuestion###-------

select datepart(year,creationdate) Years, count(*) DidNotAnsweredAnyQuestion  from users 
where id not in (SELECT distinct OwnerUserId  FROM posts
where posttypeid = 2 and OwnerUserId is not null) and 
datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 

---###Did Not Asked Any Question###-------

select datepart(year,creationdate) Years, count(*) DidNotAskedAnyQuestion  from users 
where id not in (SELECT distinct OwnerUserId  FROM posts
where posttypeid = 1 and OwnerUserId is not null) and 
datepart(year,creationdate) <= 2018
group by datepart(year,creationdate)  

---###registered on 2008 and asked question each year###---------
select OwnerUserId, count(*) ASkedQ2018
from Posts where OwnerUserId in 
(SELECT  Id  FROM users
where datepart(year,creationdate) = 2008) 
and datepart(year,creationdate) = 2018 and posttypeId = 1
group by OwnerUserId 
having count(*) >5
--order by count(*) desc
order by OwnerUserId asc


---###Posted Questions Of 2008 Users Yearly###--------

select datepart(year,creationdate) Years, count(*) PostedAnswersOf2017UsersYearly
from Posts where OwnerUserId in 
(SELECT  Id  FROM users
where datepart(year,creationdate) = 2017)
and posttypeid = 2 and datepart(year,creationdate) between 2017 and 2018
group by datepart(year,creationdate) 
having count(*) >5

---###User Activity In percentage###---

select resultTable.Years, (cast(count(resultTable.OwnerUserId) as float)/
(SELECT cast(count(*) as float) FROM users 
where datepart(year,creationdate) = 2018))*100 ActiveUserOf2018Yearly
from (
    select datepart(year,creationdate) Years,OwnerUserId, count(*) 
    NoOfQuestionPost
    from Posts where OwnerUserId in 
    (SELECT  Id  FROM users
    where datepart(year,creationdate) = 2018)
    and posttypeid = 2 and datepart(year,creationdate) between 2018 and 2018
    group by datepart(year,creationdate), OwnerUserId 
    having count(*) > 5
) resultTable 
group by resultTable.Years
order by resultTable.Years



----###ASked Question 2018 of user 2008###--- 

select OwnerUserId, count(*) ASkedQ2018 from Posts where OwnerUserId in 
(SELECT Id FROM users where 
datepart(year,creationdate) = 2008) and datepart(year,creationdate) = 2018 
and posttypeId = 1
group by OwnerUserId 
having count(*) >5 
order by OwnerUserId asc

---###No Of Questions Post by 2008 users yearly###---

select datepart(year,creationdate) Years,OwnerUserId, count(OwnerUserId) 
NoOfQuestionPost
from Posts where OwnerUserId in 
(SELECT  Id  FROM users
where datepart(year,creationdate) = 2008)
and posttypeid = 1 and datepart(year,creationdate) < 2019
group by datepart(year,creationdate), OwnerUserId 
having count(*) >5
order by datepart(year,creationdate), OwnerUserId


---###Average Answer Per Questions###---

select a.Years, cast(avg(cast(a.questions as float)) as float) AvgAnsPerQuestion  from (
select datepart(year,creationdate) Years, parentid, count(*) questions from posts where posttypeid = 2 and parentid is not null
and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), parentid
) a group by a.Years 
order by a.Years asc

---###Average comments per posts###-----

select a.Years, cast(avg(cast(a.comments as float)) as float) 
AvgCommentPerPost  from (
select datepart(year,creationdate) Years, postid, count(*) comments from comments
where datepart(year,creationdate) <= 2018
group by datepart(year,creationdate), postid
) a group by a.Years 
order by a.Years asc



----##### version1: Response time for getting accepted answer ####---------

--declare @x INT = 2018 
SELECT datepart(year,question.creationdate) Years, 
DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays
--count(*) HowManyQuestion 
FROM posts question 
inner join posts asnswer 
on question.AcceptedAnswerId = asnswer.id
where datepart(year,question.creationdate) <= 2018
--and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
group by datepart(year,question.creationdate),
DATEDIFF(day, question.creationdate, asnswer.creationdate)
order by datepart(year,question.creationdate),
DATEDIFF(day, question.creationdate, asnswer.creationdate)
desc
			 ###############InRange################
			select b.Years, SUBSTRING(b.Groups, CHARINDEX('-', b.Groups) + 1, 10) OrderRange, 
			b.Groups,sum(b.HowManyQuestion) numberofQues from (
			select a.Years, 
			 case 
				  WHEN a.ResponseInDays between  0 and 0 then '0 to 0'
				  WHEN a.ResponseInDays between 1 AND 5 THEN '1 to 5' 
				  WHEN a.ResponseInDays between 6 AND 10 THEN '6-10'
				  WHEN a.ResponseInDays between 11 AND 20 THEN '11-20'
				  WHEN a.ResponseInDays between 21 AND 51 THEN '21-50' 
				  WHEN a.ResponseInDays between 51 AND 100 THEN '51-100'
				  WHEN a.ResponseInDays between 101 AND 150 THEN '101-150'
				  WHEN a.ResponseInDays between 151 AND 200 THEN '151-200'
				  WHEN a.ResponseInDays between 201 AND 250 THEN '201-250'
				  WHEN a.ResponseInDays between 251 AND 365 THEN '251-365'
				  ELSE '366-3677'
				  END as Groups, a.ResponseInDays, sum(HowManyQuestion) HowManyQuestion from (

			SELECT datepart(year,question.creationdate) Years,
			DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,
			count(*) HowManyQuestion
			FROM posts question
			inner join posts asnswer
			on question.AcceptedAnswerId = asnswer.id
			where datepart(year,question.creationdate) <= 2018
			and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
			group by datepart(year,question.creationdate),
			DATEDIFF(day, question.creationdate, asnswer.creationdate)
			) a 
			group by a.Years, a.ResponseInDays
			) b 
			group by b.Years,b.Groups
			order by b.Years,b.Groups


-------### version2: Response time for getting accepted answer###------
			
			--cast(round((sum(b.HowManyQuestion)/(select cast(count(*) as float) from posts where AcceptedAnswerId is not null and year(creationdate) = b.Years)*100 ),2) as NUMERIC(15,2)) FirstPercentage
			
			select b.Years, b.Groups FirstAnswerGroup,
			sum(b.HowManyQuestion) FirstAnswerNoOfQuestions,
			cast(round((sum(b.HowManyQuestion)/cast(9001281 as float)*100 ),2) as NUMERIC(15,2)) FirstPercentage
			from (
									select a.Years, 
									 case 
										  WHEN a.ResponseInDays between  0 and 0 then 00
										  WHEN a.ResponseInDays between 1 AND 10 THEN 0110 
										  WHEN a.ResponseInDays between 11 AND 30 THEN 1130
										  WHEN a.ResponseInDays between 31 AND 90 THEN 3190
										  WHEN a.ResponseInDays between 91 AND 180 THEN 91180 
										  ELSE 181000
										  END as Groups, a.ResponseInDays, sum(HowManyQuestion) HowManyQuestion from (

									SELECT datepart(year,question.creationdate) Years,
									DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,
									count(*) HowManyQuestion
									FROM posts question
									inner join posts asnswer
									on question.AcceptedAnswerId = asnswer.id
									where datepart(year,question.creationdate) <= 2018
									and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
									group by datepart(year,question.creationdate),
									DATEDIFF(day, question.creationdate, asnswer.creationdate)
									) a 
									group by a.Years, a.ResponseInDays
					) b 
					group by b.Years,b.Groups
					order by b.Years,b.Groups
					
------ ############ Yearly basis response time of accepted ANSWER ###########---------
					select b.Years, b.Groups AcceptedAnswerGroup,
					sum(b.HowManyQuestion) AcceptedAnswerNoOfQuestions,
					--yearlytotal = (select count(*) from posts where AcceptedAnswerId is not null and year(creationdate) = b.Years)
					cast(round((sum(b.HowManyQuestion)/cast(839488 as float)*100 ),2) as NUMERIC(15,2)) FirstPercentage
					from (
						 select a.Years, 
						case 
						WHEN a.ResponseInDays between  0 and 0 then 00
						WHEN a.ResponseInDays between 1 AND 10 THEN 0110 
						WHEN a.ResponseInDays between 11 AND 30 THEN 1130
						WHEN a.ResponseInDays between 31 AND 90 THEN 3190
					    WHEN a.ResponseInDays between 91 AND 180 THEN 91180 
					    ELSE 181000
					    END as Groups, a.ResponseInDays, sum(HowManyQuestion) HowManyQuestion from (

					      SELECT datepart(year,question.creationdate) Years,
						  DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,count(*) HowManyQuestion
						  FROM posts question
						  inner join posts asnswer
						  on question.AcceptedAnswerId = asnswer.id
						  where datepart(year,question.creationdate) = 2018
						  and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
					      group by datepart(year,question.creationdate),
						  DATEDIFF(day, question.creationdate, asnswer.creationdate)
							) a group by a.Years, a.ResponseInDays
								) b group by b.Years,b.Groups
						 order by b.Years,b.Groups
					
					
					
					

----#### version1: Marking time as an accepted answer ###-------

SELECT datepart(year,question.creationdate) Years, 
DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,
count(*) HowManyQuestion 
FROM posts question 
inner join votes asnswer 
on question.id = asnswer.postid and asnswer.votetypeid = 1
where datepart(year,question.creationdate) <= 2018
and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
group by datepart(year,question.creationdate),
DATEDIFF(day, question.creationdate, asnswer.creationdate)
order by datepart(year,question.creationdate),
DATEDIFF(day, question.creationdate, asnswer.creationdate)
desc

--### version2: Marking time as an accepted answer in Grouped and InRange ####------

select b.Years, SUBSTRING(b.Groups, CHARINDEX('-', b.Groups) + 1, 10) OrderRange, 
b.Groups,sum(b.HowManyQuestion) numberofQues from (
select a.Years, 
 case 
      WHEN a.ResponseInDays between  0 and 0 then '0-0'
      WHEN a.ResponseInDays between 1 AND 5 THEN '1-5' 
      WHEN a.ResponseInDays between 6 AND 10 THEN '6-10'
      WHEN a.ResponseInDays between 11 AND 20 THEN '11-20'
      WHEN a.ResponseInDays between 21 AND 51 THEN '21-50' 
      WHEN a.ResponseInDays between 51 AND 100 THEN '51-100'
      WHEN a.ResponseInDays between 101 AND 150 THEN '101-150'
      WHEN a.ResponseInDays between 151 AND 200 THEN '151-200'
      WHEN a.ResponseInDays between 201 AND 250 THEN '201-250'
      WHEN a.ResponseInDays between 251 AND 365 THEN '251-365'
      ELSE '366-3677'
      END as Groups, a.ResponseInDays, sum(HowManyQuestion) HowManyQuestion from (

SELECT datepart(year,question.creationdate) Years, 
DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,
count(*) HowManyQuestion 
FROM posts question 
inner join votes asnswer 
on question.id = asnswer.postid and asnswer.votetypeid = 1
where datepart(year,question.creationdate) <= 2018
and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
group by datepart(year,question.creationdate),
DATEDIFF(day, question.creationdate, asnswer.creationdate)

) a 
group by a.Years, a.ResponseInDays
) b 
group by b.Years,b.Groups
order by b.Years,b.Groups

---#### version3: marking time as  Acccepted ANSWER, Change logic after discussing with Professor Dr. PETER ####-------
						-- Marking accepted answer's time, total Accepted answer: 9001281
			select b.Years,b.Groups MarkedAcceptedGroup, sum(b.HowManyQuestion) MarkedNoOFQuestions,
			cast(round((sum(b.HowManyQuestion)/cast(9001281 as float)*100 ),2) as NUMERIC(15,2)) MarkedPercentage
			from (
			select a.Years, 
			 case 
				   WHEN a.ResponseInDays between  0 and 0 then 00
				   WHEN a.ResponseInDays between 1 AND 10 THEN 0110 
				   WHEN a.ResponseInDays between 11 AND 30 THEN 1130
				   WHEN a.ResponseInDays between 31 AND 90 THEN 3190
				   WHEN a.ResponseInDays between 91 AND 180 THEN 91180 
				   ELSE 181000
				  END as Groups, a.ResponseInDays, sum(HowManyQuestion) HowManyQuestion from (

			SELECT datepart(year,question.creationdate) Years, 
			DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays,
			count(*) HowManyQuestion 
			FROM posts question 
			inner join votes asnswer 
			on question.id = asnswer.postid and asnswer.votetypeid = 1
			where datepart(year,question.creationdate) <= 2018
			and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
			group by datepart(year,question.creationdate),
			DATEDIFF(day, question.creationdate, asnswer.creationdate)

			) a 
			group by a.Years, a.ResponseInDays
			) b 
			group by b.Years,b.Groups
			order by b.Years,b.Groups


----### Time series analysis: TIME FRAME model###----------

DECLARE @STARTDATE DATETIME = '2008-01-01'
DECLARE @UNTILDATE DATETIME = '2009-03-31'
DECLARE @HOWMANYMONTH INT = 2
DECLARE @ENDDATE DATETIME 
SET @ENDDATE = DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)

WHILE @ENDDATE <= @UNTILDATE
BEGIN
   
  SELECT question.creationdate Years,
  --datepart(year,question.creationdate) Years, 
  DATEDIFF(day, question.creationdate, asnswer.creationdate) ResponseInDays
  --count(*) HowManyQuestion 
  FROM posts question 
  inner join posts asnswer 
  on question.AcceptedAnswerId = asnswer.id
  where question.creationdate BETWEEN @STARTDATE AND @ENDDATE
  --datepart(year,question.creationdate)= 2010
  and DATEDIFF(day, question.creationdate, asnswer.creationdate) >= 0
  --group by datepart(year,question.creationdate)
  --DATEDIFF(day, question.creationdate, asnswer.creationdate)
  --order by datepart(year,question.creationdate)
  --DATEDIFF(day, question.creationdate, asnswer.creationdate)
  --desc
   
   
   PRINT CAST(@STARTDATE AS VARCHAR(50)) +'  ' +  CAST(@ENDDATE  AS VARCHAR(50))
   SET @STARTDATE = DATEADD(day,1, @ENDDATE)
   SET @ENDDATE =  DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)
       
END

---### TIME FRAME analysis of accepted ANSWER ###----
DECLARE @STARTDATE DATETIME = '2008-01-01'
DECLARE @UNTILDATE DATETIME = '2009-03-31'
DECLARE @HOWMANYMONTH INT = 2
DECLARE @ENDDATE DATETIME 
SET @ENDDATE = DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)

WHILE @ENDDATE <= @UNTILDATE
BEGIN
   
   
  SELECT COUNT(*) NOOFANSWERS, @STARTDATE STARTDATE, @ENDDATE ENDDATE  FROM POSTS ANSWER
  INNER JOIN POSTS QUESTIONS 
  ON ANSWER.PARENTID = QUESTIONS.ID AND QUESTIONS.AcceptedAnswerId IS NOT NULL 
  AND ANSWER.CreationDate BETWEEN @STARTDATE AND @ENDDATE
  
 
   --PRINT CAST(@STARTDATE AS VARCHAR(50)) +'  ' +  CAST(@ENDDATE  AS VARCHAR(50))
   SET @STARTDATE = DATEADD(day,1, @ENDDATE)
   SET @ENDDATE =  DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)
       
END

---### TIME FRAME COMMENTS analysis ###----

DECLARE @STARTDATE DATETIME = '2008-01-01'
DECLARE @UNTILDATE DATETIME = '2009-03-31'
DECLARE @HOWMANYMONTH INT = 2
DECLARE @ENDDATE DATETIME 
SET @ENDDATE = DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)

WHILE @ENDDATE <= @UNTILDATE
BEGIN
   
      SELECT COUNT(*) NOOFCOMMENTS,@STARTDATE STARTDATE, @ENDDATE ENDDATE FROM COMMENTS COMMENT
      INNER JOIN POSTS ANSWER 
      ON COMMENT.PostId = ANSWER.ID AND COMMENT.CreationDate BETWEEN @STARTDATE AND @ENDDATE
      INNER JOIN (
      SELECT DISTINCT AcceptedAnswerId FROM POSTS WHERE AcceptedAnswerId IS NOT NULL 
      ) ACCEPTANSWER
      ON ANSWER.ID = ACCEPTANSWER.AcceptedAnswerId
      WHERE COMMENT.CreationDate BETWEEN @STARTDATE AND @ENDDATE  
   
   
   --PRINT CAST(@STARTDATE AS VARCHAR(50)) +'  ' +  CAST(@ENDDATE  AS VARCHAR(50))
   SET @STARTDATE = DATEADD(day,1, @ENDDATE)
   SET @ENDDATE =  DATEADD(month, ((YEAR(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)) - 1900) * 12) + MONTH(DATEADD(Month, @HOWMANYMONTH, @STARTDATE)), -1)
       
END
      
      

----#### version1: Response time of GETting FIRST ANSWER (TIME series anlysis) FROM ANSWER USING CTE-------

 ;WITH cte AS
      (
         SELECT ParentId,creationdate ,
               ROW_NUMBER() OVER (PARTITION BY ParentId 
               ORDER BY creationdate ASC) AS rn
         FROM posts 
      )
      SELECT TOP 10 question.ID,question.creationdate Years, ANSWER.creationdate,
      DATEDIFF(day, question.creationdate, ANSWER.creationdate) ResponseInDays
      FROM cte ANSWER
      INNER JOIN POSTS question
      ON ANSWER.ParentId = question.ID AND datepart(year,ANSWER.creationdate) <= 2018  
      WHERE rn = 1 
      
	---####### version2 : GETting FIRST ANSWER In grouped ########
    ;WITH cte AS
      (
         SELECT ParentId,creationdate ,
               ROW_NUMBER() OVER (PARTITION BY ParentId 
               ORDER BY creationdate ASC) AS rn
         FROM posts 
      )
      SELECT datepart(year,question.creationdate) Years,
      --ANSWER.creationdate,
      DATEDIFF(day, question.creationdate, ANSWER.creationdate) ResponseInDays,
      count(*) HowManyQuestion 
      FROM cte ANSWER
      INNER JOIN POSTS question
      ON ANSWER.ParentId = question.ID AND datepart(year,ANSWER.creationdate) <= 2018  
      WHERE rn = 1 and DATEDIFF(day, question.creationdate, ANSWER.creationdate) >= 0
      group by datepart(year,question.creationdate),
      DATEDIFF(day, question.creationdate, ANSWER.creationdate)

	  
	  
	------#### version3: RESPONSE TIME OF GETTING FIRST ANSWER ### -----
		  declare @2018DataInRange table (Years int,Groups int ,Days int , HowManyQuestion int) 
	 
	 
		 ;WITH cte AS
			  (
				 SELECT ParentId,creationdate ,
					   ROW_NUMBER() OVER (PARTITION BY ParentId 
					   ORDER BY creationdate ASC) AS rn
				 FROM posts 
			  )
			  insert into @2018DataInRange 
			  SELECT datepart(year,question.creationdate) Years,
			  --ANSWER.creationdate,
			  case 
			   WHEN DATEDIFF(day, question.creationdate, ANSWER.creationdate) between  0 and 0 then 00
			   WHEN DATEDIFF(day, question.creationdate, ANSWER.creationdate) between 1 AND 10 THEN 0110 
			   WHEN DATEDIFF(day, question.creationdate, ANSWER.creationdate) between 11 AND 30 THEN 1130
			   WHEN DATEDIFF(day, question.creationdate, ANSWER.creationdate) between 31 AND 90 THEN 3190
			   WHEN DATEDIFF(day, question.creationdate, ANSWER.creationdate) between 91 AND 180 THEN 91180 
			   ELSE 181000
			  END as Groups, 
			  DATEDIFF(day, question.creationdate, ANSWER.creationdate) ResponseInDays,
			  count(*) HowManyQuestion

			  FROM cte ANSWER
			  INNER JOIN POSTS question
			  ON ANSWER.ParentId = question.ID AND datepart(year,ANSWER.creationdate) <= 2018  
			  WHERE rn = 1 and DATEDIFF(day, question.creationdate, ANSWER.creationdate) >= 0
			  group by datepart(year,question.creationdate),
			  DATEDIFF(day, question.creationdate, ANSWER.creationdate)
			  
			  select Years Year_First,Groups FirstAnswerGroup, sum(HowManyQuestion) FisrtAnsNoOfQuestions,
			  cast(round((sum(HowManyQuestion)/cast(9001281 as float)*100 ),2) as NUMERIC(15,2)) FirstAnsPercentage
			  from @2018DataInRange 
			  group by Years,Groups
	  
	  
	  
      
--###Yearly Revision ###--
select a.Years, sum(a.ReviewNumber) ReviewNumber from(
select datepart(year,ps.creationdate) Years, 
count(*) ReviewNumber from posthistory ps
inner join posts p
on ps.postid = p.id and p.posttypeid = 1 and p.acceptedAnswerId is not null
where datepart(year,ps.creationdate) <=2018
group by datepart(year,ps.creationdate)
union 
select datepart(year,ps.creationdate) Years, 
count(*) ReviewNumber from posthistory ps
inner join posts a
on ps.postid = a.id and a.posttypeid = 2
inner join posts q
on a.parentid = q.id and q.acceptedAnswerId is not null
where datepart(year,ps.creationdate) <=2018
group by datepart(year,ps.creationdate)
) a 
group by a.Years

---#### Active Revisioner Yearly ####---
select Years, count(a.userid) ActiveRevier from (
        select datepart(year,ps.creationdate) Years, ps.userid,
        count(ps.userid) ActiveRevier from posthistory ps
        inner join posts p
        on ps.postid = p.id and p.posttypeid = 1 and p.acceptedAnswerId is not null
        and ps.userid is not null
        where datepart(year,ps.creationdate) <=2018
        group by datepart(year,ps.creationdate), ps.userid
        having count(ps.userid) >= 5 
        union 
        select datepart(year,ps.creationdate) Years, ps.userid,
        count(ps.userid) ActiveRevier from posthistory ps
        inner join posts a
        on ps.postid = a.id and a.posttypeid = 2 and ps.userid is not null
        inner join posts q
        on a.parentid = q.id and q.acceptedAnswerId is not null
        where datepart(year,ps.creationdate) <=2018
        group by datepart(year,ps.creationdate), ps.userid
        having count(ps.userid) >= 5
    )a group by a.Years
      
 ---#### Yearly Review ###---
 --In general total review : 13475777 , completed total review= 10807488
select count(*) totalCompletedReview from ReviewTasks rt 
inner join posts p
on rt. postid = p.id and rt.ReviewTaskStateId = 2 --complete status
where datepart(year,rt.creationdate) <=2018 
--group by datepart(year,rt.creationdate) 

DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
select datepart(year,rt.creationdate) Years,count(*) ReviewNumber,
(count(*)/cast(13475777 as float))*100 as percentage,
cast(round((count(*)/cast(13475777 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(*) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((count(*)/cast(13475777 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge
from ReviewTasks rt 
inner join posts p
on rt. postid = p.id 
where datepart(year,rt.creationdate) <=2018 and rt.ReviewTaskStateId = 2 --complete status
group by datepart(year,rt.creationdate)  



---### version1: Question Rate of top 20 tags ####---
--- total number of Question : 16867398 (without accepted)
---- accepted : 9001281

DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
select year(CreationDate) Years,t.tagName TagName, count(questions.id) NumQuestions,
(count(questions.id)/cast(9001281 as float))*100 as percentage,
cast(round((count(questions.id)/cast(9001281 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(questions.id) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((count(questions.id)/cast(9001281 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge
 from PostTags pt
inner join posts questions 
on  pt.postid = questions.id and questions.posttypeid = 1  
and year(questions.CreationDate) <= 2018 and questions.AcceptedAnswerId is not null
inner join tags t
ON t.Id=pt.TagId and t.tagName in (select top 20 TagName from tags order by count desc)
group by year(CreationDate),t.tagName 


---#### version2: Question rate for top 20 tags (Updated query for year basis percentage) ###----
DECLARE @TOTAL INT = select count(*) from posts where posttypeid = 1 and AcceptedAnswerId is not null and datepart(year,creationdate) = 2018
DECLARE @YEAR INT = 2018

select year(questions.CreationDate) Years,t.tagName TagName, count(questions.id) NumQuestions,
(count(questions.id)/cast(@TOTAL as float))*100 as percentage,
cast(round((count(questions.id)/cast(@TOTAL as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(questions.id) as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
+cast( cast(round((count(questions.id)/cast(@TOTAL as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge

from PostTags pt
inner join posts questions 
on  pt.postid = questions.id and questions.posttypeid = 1  
and year(questions.CreationDate) = @YEAR and questions.AcceptedAnswerId is not null
inner join tags t
ON t.Id=pt.TagId and t.tagName in (select top 20 TagName from tags order by count desc)
group by year(questions.CreationDate),t.tagName 


---#### version1: answer rate of TOP 20 TAGS ### ----
----- NUMBER OF ANSWERS UNTILL 2018 : 26056531
SELECT TOP 20 B.TAGNAME FROM (
        SELECT A.TAGID, A.TAGNAME, SUM(A.ANSWERNUMBER) ANSWERNUMBER FROM (
            SELECT  PT.TAGID, P.ID,T.TAGNAME,
            ANSWERNUMBER = (SELECT COUNT(*) FROM POSTS WHERE PARENTID = P.ID)
            FROM  PostTAGS PT  
            INNER JOIN POSTS P
            ON PT.POSTID = P.ID AND P.POSTTYPEID = 1
            INNER JOIN TAGS T
            ON PT.TAGID = T.ID
            WHERE YEAR(P.CREATIONDATE) <= 2018
      ) A 
      GROUP BY A.TAGID, A.TAGNAME 
) B ORDER BY B.ANSWERNUMBER DESC

---### version2: Answer rate of top 20 most tags ####---

DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
select B.Years,B.TAGNAME TagName, SUM(B.ANSWERNUMBER) ANSWERNUMBER,
(SUM(B.ANSWERNUMBER)/cast(26056531 as float))*100 as percentage,
cast(round((SUM(B.ANSWERNUMBER)/cast(26056531 as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(SUM(B.ANSWERNUMBER) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((SUM(B.ANSWERNUMBER)/cast(26056531 as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge
 FROM (
        SELECT A.Years, A.TAGID, A.TAGNAME, SUM(A.ANSWERNUMBER) ANSWERNUMBER FROM (
              SELECT  YEAR(P.CREATIONDATE) Years,PT.TAGID, P.ID,T.TAGNAME,
              ANSWERNUMBER = (SELECT COUNT(*) FROM POSTS WHERE PARENTID = P.ID)
              FROM  PostTAGS PT  
              INNER JOIN POSTS P
              ON PT.POSTID = P.ID AND P.POSTTYPEID = 1
              INNER JOIN TAGS T
              ON PT.TAGID = T.ID
              WHERE YEAR(P.CREATIONDATE) <= 2018 AND 
              t.tagName in (select aa.TagName from (
              select 'sql-server' TagName
              union
              select top 19 TagName from tags WHERE TAGNAME <> 'r' order by count desc
              ) aa )
            
      ) A 
      GROUP BY A.Years,A.TAGID, A.TAGNAME 
) B 
group BY B.Years,B.TAGNAME
ORDER BY B.Years,B.TAGNAME
 
---#### Combined: what percentage Questions got score(0,<,>) Yearly in time series analysis #############
DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
select datepart(year,creationdate) Years,Score= 'Negative_Scored_Questions', count(*) QuestionsCount,
(count(*)/cast(16867398  as float))*100 as percentage,
cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(*) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge from posts 
where posttypeid = 1 and score < 0 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 
union 

select datepart(year,creationdate) Years,Score='Positive_Scored_Questions', count(*) QuestionsCount,
(count(*)/cast(16867398  as float))*100 as percentage,
cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(*) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge  from posts 
where posttypeid = 1 and score > 0 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 
union 

select datepart(year,creationdate) Years,Score='Zero_Scored_Questions' , count(*) QuestionsCount,
(count(*)/cast(16867398  as float))*100 as percentage,
cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(count(*) as varchar(20))+ @NewLineChar +'(' 
+cast( cast(round((count(*)/cast(16867398  as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge  from posts 
where posttypeid = 1 and score = 0 and datepart(year,creationdate) <= 2018
group by datepart(year,creationdate) 
order by datepart(year,creationdate)



---### what percentage ANSWERs got score(0,<,>) Yearly in time series analysis ###-----

DECLARE @TOTAL INT = select count(*) from posts where posttypeid = 2 and  datepart(year,creationdate) = 2018
DECLARE @YEAR INT = 2008
select a.Years,a.Score, a.QuestionsCount,
(a.QuestionsCount/cast(@TOTAL  as float))*100 as percentage,
cast(round((a.QuestionsCount/cast(@TOTAL  as float)*100 ),2) as NUMERIC(15,2)) percentageRound,
cast(a.QuestionsCount as varchar(20))+ CHAR(13) + CHAR(10) +'(' 
+cast( cast(round((a.QuestionsCount/cast(@TOTAL  as float)*100 ),2) as NUMERIC(15,2))   as varchar(20))+
'%)' StringPercentatge  
from (
select datepart(year,creationdate) Years,Score='Negative_Scored_Answers', count(*) QuestionsCount
from posts 
where posttypeid = 2 and score < 0 and datepart(year,creationdate) = @YEAR
group by datepart(year,creationdate) 
--order by datepart(year,creationdate)
union 

select datepart(year,creationdate) Years,Score='Positive_Scored_Answers', count(*) QuestionsCount  
from posts 
where posttypeid = 2 and score > 0 and datepart(year,creationdate) = @YEAR
group by datepart(year,creationdate) 
--order by datepart(year,creationdate)
union 

select datepart(year,creationdate) Years,Score='Zero_Scored_Answers', count(*) QuestionsCount
from posts 
where posttypeid = 2 and score = 0 and datepart(year,creationdate) = @YEAR
group by datepart(year,creationdate) 
--order by datepart(year,creationdate)
) a 
group by a.Years,a.Score,a.QuestionsCount




------------------- query bank on SO ---------------------
 
Create  table :https://data.stackexchange.com/stackoverflow/query/466/most-controversial-posts-on-the-site
https://data.stackexchange.com/stackoverflow/query/987178/accepted-answer-rate-per-tag
