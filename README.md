# Research Project on Stack Overflow (SO) Data Mining

# Abstract: 
Stack Overflow accumulates an enormous amount of software en- gineering knowledge on different kinds of programming languages and pro- gramming related topics over the last decade. However, at the beginning of the years of the stack overflow users contribute on the community to make it popular and prove it as a helpful as well life changing resource to the programmers , but from 2013 it seems that the activities of the users have been decreased significantly after analyzing the engagement of the users. Similarly, we found the number of posted answers of questions are declining over the years on Stack Overflow which accounted around 30% answers have been de- creased since 2013. In this paper, we investigate evolution of Stack Overflow and user engagement as well over the years through two RQs. We found that: 1) the number of answers decreased 30% and users activity on stack over- flow is decreasing drastically from 43.02% (2008) to 1.96% (2018), although users are posting questions per years in steady way. Therefore, in 2018, only 5% of the questions got accepted answers and 95% numbers of questions re- main unanswered. 2) Users are frequently changing the topics of discussion on Stack Overflow due to the popularity of the tags or programming language. To demonstrate, in the first year, 2008, C# and .net were popular. Consequently, people posted over 10% of total questions in 2008 related to C# and .net but in 2018, programmer posted new technologies (e.g. R, Python) related questions which accounted over 12% by replacing C# and .net. In addition, recently users are loving to post answer of questions related to R and Python programming language which indicates the changing of discussion topics on SO.

# Data Collection :
Here we will describe how we collect the dataset that we used to answer the research questions. To understand the growing trend of Stack Overflow we collect the data dump from archive.org [7]. The data was published on March 04, 2019 by the Stack Exchange community. The data contains information about badges, comments, post history, post links, posts, tags, users, and votes and we import the data dump into MSSQL to facilitate our study. Finally, we generate the .csv file using SQL query in MSSQL [8] and used that .csv file in R studio in order to generate necessary graphs and figures to evaluate our metrics. Using our selection criteria, we ended up with 9,810,623 (around 10 million) users, 16,867,398 (over 16.5 million) questions and 26,056,531 (over 26 million) answers along with 9,001,281 (over 9 million) accepted answer of total Questions from 2008 to 2018 on yearly basis and we look at several dimensions of the growth of Stack Overflow. We published our data set including the necessary query online. 

# Research Questions (RQs)
<img width="1061" alt="image" src="https://user-images.githubusercontent.com/45977153/122584851-d70aa380-d028-11eb-997d-463d2f6b4c98.png">


# Source of SO Data
- Data Dump download: https://archive.org/details/stackexchange 
- Stack Exchange Data Explorer: https://data.stackexchange.com/stackoverflow/query/new

# Source Code:
- SQL Query: https://github.com/MMH08/SOEN6611_Project/blob/master/SOEN6611_Project_SQL_QUERY.sql 
- R Code: https://github.com/MMH08/SOEN6611_Project/blob/master/SOEN-6611_Project_Figues_InR_.R

# Gathered Data Link
- For RQ1 : https://docs.google.com/spreadsheets/d/1bp7eHWNyihg-0c2lzmGNUNiUTMTU2xtSmUUnL3X5GPI/edit#gid=0 
- For RQ2 : https://docs.google.com/spreadsheets/d/1HJNJs8nkkx_EjWdmdp_-9YeBfRcJhM-rp9h4XM-0O3I/edit#gid=0


