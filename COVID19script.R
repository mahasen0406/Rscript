rm(list = ls()) #removes all variables stored previously
install.packages("Hmisc")

data <- read.csv("~/Desktop/COVID19_line_list_data.csv")
describe(data) #Hmisc command

#cleaned up death column
data$death_dummy <- as.integer(data$death != 0)
#death rate
sum(data$death_dummy) / nrow(data)

#AGE
#Claim : people who die are older
dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)
mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)
#is this statistically significant
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
#since the p-value < 0.05 we reject the null hypothesis.
#conclude that this is statistically significant.


#GENDER
#Claim : gender has no effect
men = subset(data, gender == "male")
women = subset(data, gender == "female")
mean(men$death_dummy, na.rm = TRUE) #8.5%!
mean(women$death_dummy, na.rm = TRUE) #3.7%!
#is this statistically significant
t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.95)
#95% confidence: that men have from 1.7% - 7.8% higher chance of fatality rate
#since the p-value < 0.05 we reject the null hypothesis.
#conclude that this is statistically significant.
