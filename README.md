# SOEN-6611 Project on Stack Overflow (SO)

# Abstract: 
Stack Overflow accumulates an enormous amount of software engineering knowledge on different kinds of programming languages and programming related topics over the last decade. However, at the beginning of the years of the stack overflow community users were so much active, but over the years the activities of the users have been decreased significantly. Similarly, the number of posted questions and answers are also declining in the similar trend over the years on stack overflow. In this paper, we investigate the rise and fall of stack overflow over the years through two RQs. We found that: 1) the number of answers and users activity on stack overflow is decreasing drastically, although users are posting questions. Therefore, huge numbers of questions remain unanswered over the years. 2) Users are frequently changing the topics on Stack Overflow due to the popularity of the tags or programming language. 


# Data Collection :
Here we will describe how we collect the dataset that we used to answer the research questions. To understand the growing trend of Stack Overflow we collect the data dump from archive.org [7]. The data was published on March 04, 2019 by the Stack Exchange community. The data contains information about badges, comments, post history, post links, posts, tags, users, and votes and we import the data dump into MSSQL to facilitate our study. Finally, we generate the .csv file using SQL query in MSSQL [8] and used that .csv file in R studio in order to generate necessary graphs and figures to evaluate our metrics. Using our selection criteria, we ended up with 9,810,623 (around 10 million) users, 16,867,398 (over 16.5 million) questions and 26,056,531 (over 26 million) answers along with 9,001,281 (over 9 million) accepted answer of total Questions from 2008 to 2018 on yearly basis and we look at several dimensions of the growth of Stack Overflow. We published our data set including the necessary query online. 

# SO Data Dump Link
https://archive.org/details/stackexchange 

# SQL Query Link  
https://github.com/MMH08/SOEN6611_Project/blob/master/SOEN6611_Project_SQL_QUERY.sql 

# Gathered Data Link 
 - For RQ1 : https://docs.google.com/spreadsheets/d/1bp7eHWNyihg-0c2lzmGNUNiUTMTU2xtSmUUnL3X5GPI/edit#gid=0
 - For RQ2 : https://docs.google.com/spreadsheets/d/1HJNJs8nkkx_EjWdmdp_-9YeBfRcJhM-rp9h4XM-0O3I/edit#gid=0

# Plan & Progress with Professors, Online Doc
 - Version 1 : https://docs.google.com/document/d/16N48z7RVMObt5vpl18Cxyv5L_asDxR2U2OhoLcsWzBA/edit
 - Version 2 : https://docs.google.com/document/d/1pdOeoj74PQR93KLjTcNNqiST0n-WPXuGlUSYdEoKmNg/edit 
