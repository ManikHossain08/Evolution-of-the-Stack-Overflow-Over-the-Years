library(tidyr)
library(dplyr)
library(magrittr) # need to run every time you start R and want to use %>%
library(dplyr)    # alternative, this also loads %>%
library(tibble)
library(foreign)
library(caret)
library(car)
library(nlme)
library(rms)
library(e1071)
library(BiodiversityR)
library(moments)
library(randomForest)
library(ROCR)
library(pROC)
library(DMwR)
library(vioplot)
library(Hmisc)
library(psych)


################Yearly Review of Questions and Answer(Row data)####################

RQ2DF<-read.csv("Review Yearly.csv",TRUE,",")
#RangeInDF <- subset(RQ2DF, Years == 2008)
RangeInDF <- RQ2DF[order(RQ2DF$Years),]
#RangeInDF <- newdata

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$ReviewNumber))
ylim <- c(0, 1.1*max(RangeInDF$freqs))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = '#Year', width = 0.85, ylim = ylim,
              main = "Revision/Review Questions and Answer yearly", ylab = "#Review")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$ReviewNumber, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)
#pdf( "mygraph.pdf", width = 11, height = 8 )

################ version 1 :Review Yearly in percentage (OK)####################

RQ2DF<-read.csv("Review Yearly.csv",TRUE,",")
#RangeInDF <- subset(RQ2DF, Years == 2008)
RangeInDF <- RQ2DF[order(RQ2DF$Years),]
#RangeInDF <- newdata

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = '#Year', width = 0.85, ylim = ylim,
              main = "Review of Questions and Answer yearly", ylab = "#Review in Percentage")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$ReviewPercentage, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)

########### version 2: Revised Completed Review.csv #############
RQ2DF<-read.csv("RevisedCompletedReview.csv",TRUE,",")
#RangeInDF <- subset(RQ2DF, Years == 2008)
RangeInDF <- RQ2DF[order(RQ2DF$Years),]
#RangeInDF <- newdata

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = '#Year', width = 0.85, ylim = ylim,
              main = "Review of Questions and Answer yearly", ylab = "#Review in Percentage")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)



########### All Users vs Active users Yearly [combined csv file] ########
RQ2DF<-read.csv("AllUserVsActiveUsersYearly.csv",TRUE,",")
RangeInDF <- RQ2DF[order(RQ2DF$Years),]

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "New Users Yearly on SO", ylab = "Users in Percentage(%)")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)

    ##### Using total from users Table by sprecific year #####
RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentageQues))
ylim <- c(0, 1.1*max(RangeInDF$percentageQues))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "Active Users Yearly on SO", ylab = "Users in Percentage(%)")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatgeQues, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)

    ########## Using running total of users table ############
RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentageActiveRT))
ylim <- c(0, 1.1*max(RangeInDF$percentageActiveRT))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "Active Users Yearly on SO", ylab = "Users in Percentage(%)")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatgeActiveRT, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)


     #------Combined----------#
obs.type.name = c(RangeInDF$Years)
obs.type.count = c(RangeInDF$usersYearly)
obs.type.count.All = c( RangeInDF$percentageRound)
obs.type.count.Active = c(RangeInDF$percentageRoundQues)

obs.type.count.comb = rbind(obs.type.count.All, obs.type.count.Active)

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
RangeInDF$freqsAll <- as.numeric(as.character(RangeInDF$percentageQues))
ylim <- c(0, 1.1*max(RangeInDF$percentageRoundQues + RangeInDF$percentageRound))
xx <- barplot(obs.type.count.comb, xaxt = 'n', #col=colors()[c("#000000","#0000FF")],
              xlab = "All and Active Users Comparison Yearly", width = 0.85, 
              ylim = ylim, #main = "All and Active Reviewer Comparison Yearly", 
              ylab = "Users in Percentage(%)")
legend('topleft', legend=c("Active Users","All Users"), fill=c("grey","black"), cex = 0.6)
text(x = xx, y = RangeInDF$freqsAll, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "grey")
text(x = xx, y = 1.05*RangeInDF$freqs, label = RangeInDF$StringPercentatgeQues, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)


################Comments Ratio Yearly.csv####################
RQ2DF<-read.csv("CommentsRatioYearly.csv",TRUE,",")
#RangeInDF <- subset(RQ2DF, Years == 2008)
RangeInDF <- RQ2DF[order(RQ2DF$Years),]
#RangeInDF <- newdata

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "Comments Ratio Yearly", ylab = "Comments Ratio ( % )")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)


################NewQuestion_Vs_UnAnsweredQustion.csv [combined] ####################
RQ2DF<-read.csv("NewQuestion_Vs_UnAnsweredQustion.csv",TRUE,",")
#RangeInDF <- subset(RQ2DF, Years == 2008)
RangeInDF <- RQ2DF[order(RQ2DF$Years),]
#RangeInDF <- newdata

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "Comments Ratio Yearly", ylab = "Comments Ratio ( % )")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)


#------Combined----------#
obs.type.name = c(RangeInDF$Years)
obs.type.count = c(RangeInDF$QuestionsYearly)
obs.type.count.All = c( RangeInDF$percentageRound)
obs.type.count.UnAnswered = c(RangeInDF$percentageRoundUn)

obs.type.count.comb = rbind(obs.type.count.All, obs.type.count.UnAnswered)

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentageRound))
RangeInDF$freqsAll <- as.numeric(as.character(RangeInDF$percentageUn))
ylim <- c(0, 1.1*max(RangeInDF$percentageRound + RangeInDF$percentageRoundUn))
xx <- barplot(obs.type.count.comb, xaxt = 'n', #col=colors()[c("#000000","#0000FF")],
              xlab = "Yearly New Questions Vs UnAnswered Questions Yearly", width = 0.85, 
              ylim = ylim, #main = "All and Active Reviewer Comparison Yearly", 
              ylab = "Questions in Percentage(%)")
legend(x='topleft', legend=c("UnAnswered Questions","Yearly New Questions"),fill=c("grey","Black"), cex = 0.8)
text(x = xx, y = 0*RangeInDF$freqsAll, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "grey")
text(x = xx, y = 1.5*(RangeInDF$freqs), label = RangeInDF$StringPercentatgeUn, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)



################Answers Yearly on SO.csv [combined] ####################
RQ2DF<-read.csv("AnsweredYearlyonSO.csv",TRUE,",")
RangeInDF <- RQ2DF[order(RQ2DF$Years),]

RangeInDF$freqs <- as.numeric(as.character(RangeInDF$percentage))
ylim <- c(0, 1.1*max(RangeInDF$percentage))
xx <- barplot(RangeInDF$freqs, xaxt = 'n', xlab = 'Year', width = 0.85, ylim = ylim,
              main = "Answers Yearly", ylab = "Answer in Percentage ( % )")
text(x = xx, y = RangeInDF$freqs, label = RangeInDF$StringPercentatge, pos = 3, cex = 0.8, col = "black")
axis(1, at=xx, labels=RangeInDF$Years, tick=FALSE, las=2, line=-0.5, cex.axis=1.0)


#################Time series analysis: ACCEPTED Question Rate Of Top 20 Tag #################
RQ2DF<-read.csv("AcceptedQuetionsRateOfTopTags_Sure.csv",TRUE,",")
Data <- tibble(RQ2DF)

Question_Rate_in_Percentage_Per_Tag = RQ2DF$percentage
Top_20_Tags = RQ2DF$TagName
Years = RQ2DF$Years

# Multiple line plot
  ggplot(RQ2DF, aes(x = Years, y = Question_Rate_in_Percentage_Per_Tag)) + 
  ggtitle("Change of Topic on SO")+
  theme(plot.title = element_text(hjust = 3))+
  geom_line(aes(color = Top_20_Tags), size = 1.75) + 
  scale_color_manual(values = c('#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', 
  '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', 
  '#008080', '#e6beff', '#9a6324', '#800000', 
  '#808000', '#ffd8b1', '#000075', '#808080', 
  '#800000', '#000000')) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))


#################Time series analysis: ANSWER Rate Of Top 20 Tag #################
RQ2DF<-read.csv("AnswerOfTop20Tags.csv",TRUE,",")
Data <- tibble(RQ2DF)

Answer_Rate_in_Percentage_Per_Tag = RQ2DF$percentage
Top_20_Tags = RQ2DF$TagName
Years = RQ2DF$Years

# Multiple line plot
ggplot(RQ2DF, aes(x = Years, y = Answer_Rate_in_Percentage_Per_Tag)) + 
  #ggtitle("Change of Topic on SO")+
  theme(plot.title = element_text(hjust = 3))+
  geom_line(aes(color = Top_20_Tags), size = 1.75) + 
  scale_color_manual(values = c('#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', 
                                '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', 
                                '#008080', '#e6beff', '#9a6324', '#800000', 
                                '#808000', '#ffd8b1', '#000075', '#808080', 
                                '#800000', '#000000')) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))



#################Time series analysis: Questions Scored_Positive_Negative_Zero Scores #################
RQ2DF<-read.csv("QuestionsScored_P_N_Z.csv",TRUE,",")
Data <- tibble(RQ2DF)

Qustions_Rate_in_Percentage_For_Scores = RQ2DF$percentage
Questions_Score = RQ2DF$Score
Years = RQ2DF$Years

# Multiple line plot
ggplot(RQ2DF, aes(x = Years, y = Qustions_Rate_in_Percentage_For_Scores)) + 
  geom_line(aes(color = Questions_Score), size = 1) + 
  scale_color_manual(values = c("#FF0000", "blue", "black")) +
  theme_minimal()

#################Time series analysis: Answer Scored_Positive_Negative_Zeoro scores#################
RQ2DF<-read.csv("AnswerScored_P_N_Z.csv",TRUE,",")
Data <- tibble(RQ2DF)

Answer_Rate_in_Percentage_For_Scores = RQ2DF$percentage
Answers_Score = RQ2DF$Score
Years = RQ2DF$Years

# Multiple line plot
ggplot(RQ2DF, aes(x = Years, y = Answer_Rate_in_Percentage_For_Scores)) + 
  geom_line(aes(color = Answers_Score), size = 1) + 
  scale_color_manual(values = c("#FF0000", "blue", "black")) +
  theme_minimal()





















