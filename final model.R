require(randomForest)
install.packages("bootstrap")
library(bootstrap)
install.packages("DAAG")
library(DAAG)
install.packages('leaps')
library(leaps)
library(car)
library(MASS)
library(caret)
original_data=read.csv('C:/Users/Karthik/Desktop/MSDA/sem 3-summer 2018/data mining 2/project/clean_who_data.csv') #do not modify this variable
who_data=original_data #data to be used
set.seed(100)
table(original_data$Year)
#each country has 16 entries, due to this the random forest model tends to group these entries in the same leaf, making the model somewhat useless
#the data is limited to the observations for each country in 2014
who_data=who_data[who_data$Year==2014,]

#linear model using k-fold cross validation
fit_linear = lm(Life.expectancy ~ Status + Adult.Mortality + infant.deaths + Alcohol + percentage.expenditure + Measles + BMI + under.five.deaths + Polio 
                + Total.expenditure + Diphtheria + HIV.AIDS + thinness..1.19.years + thinness.5.9.years + Income.composition.of.resources + Schooling, data = who_data)
linear_cv = CVlm(data = who_data, fit_linear, m=10) #mse 11.5

#variable selection seeing subsets of each size
fit_leaps = regsubsets(Life.expectancy ~ Status + Adult.Mortality + infant.deaths + Alcohol + percentage.expenditure + Measles + BMI + under.five.deaths + Polio 
                       + Total.expenditure + Diphtheria + HIV.AIDS + thinness..1.19.years + thinness.5.9.years + Income.composition.of.resources + Schooling,
                       data = who_data, nbest = 10)
summary(fit_leaps)
plot(fit_leaps, scale = 'adjr2')
#the highest adjusted r2 is found by using the formula below
#linear model using k-fold cross validation
fit_linear_limited_var = lm(Life.expectancy ~ Status + Adult.Mortality + infant.deaths + under.five.deaths+ Total.expenditure + Diphtheria + HIV.AIDS 
                + Income.composition.of.resources, data = who_data)
linear_cv_limited_var = CVlm(data = who_data, fit_linear_limited_var, m=10) #mse 10.8

#polynomial model using k-fold cv
fit_poly = lm(Life.expectancy ~ Status + poly(Adult.Mortality,3,raw = TRUE) + poly(infant.deaths,3,raw = TRUE) + poly(Alcohol,3,raw = 3) 
              + poly(percentage.expenditure,3,raw = TRUE) + poly(Measles,3,raw = TRUE) + poly(BMI,3,raw = TRUE) + poly(under.five.deaths,3,raw = TRUE) 
              + poly(Polio,3,raw = TRUE)  + poly(Total.expenditure,3,raw = TRUE) + poly(Diphtheria,3,raw = TRUE) + poly(HIV.AIDS,3,raw = TRUE) 
              + poly(thinness..1.19.years,3,raw = TRUE) + poly(thinness.5.9.years,3,raw = TRUE) + poly(Income.composition.of.resources,3,raw = TRUE) 
              + poly(Schooling,3,raw = TRUE), data = who_data)
summary(fit_poly)
poly_cv = CVlm(data = who_data, fit_poly, m=10) #mse 20091 value returned here is unexpectantly high
#variable selection
fit_leaps_poly = regsubsets(Life.expectancy ~ Status + poly(Adult.Mortality,3,raw = TRUE) + poly(infant.deaths,3,raw = TRUE) + poly(Alcohol,3,raw = 3) 
                    + poly(percentage.expenditure,3,raw = TRUE) + poly(Measles,3,raw = TRUE) + poly(BMI,3,raw = TRUE) + poly(under.five.deaths,3,raw = TRUE) 
                    + poly(Polio,3,raw = TRUE)  + poly(Total.expenditure,3,raw = TRUE) + poly(Diphtheria,3,raw = TRUE) + poly(HIV.AIDS,3,raw = TRUE) 
                    + poly(thinness..1.19.years,3,raw = TRUE) + poly(thinness.5.9.years,3,raw = TRUE) + poly(Income.composition.of.resources,3,raw = TRUE) 
                    + poly(Schooling,3,raw = TRUE), data = who_data)
plot(fit_leaps_poly, scale = 'adjr2')
poly_leaps_sum=summary(fit_leaps_poly)
which.max(poly_leaps_sum$adjr2)
coef(fit_leaps_poly,8)
fit_poly_limited_var = lm(Life.expectancy ~ Status + poly(Adult.Mortality,3,raw = TRUE) + I(Total.expenditure^2) + I(Diphtheria^3)  
              + I(Income.composition.of.resources^3) , data = who_data)
poly_cv_limited_var = CVlm(data = who_data, fit_poly_limited_var,m=10) #mse 8.5

#randomForest
rf_who_data = who_data[, names(who_data) != 'Country'] 
rf_who_data = rf_who_data[, names(rf_who_data) != 'X']
rf_who_data = rf_who_data[, names(rf_who_data) != 'Year']

control <- trainControl(method="repeatedcv", number=10, repeats=3, search="grid")
tunegrid <- expand.grid(.mtry=c(1:15))
rf_gridsearch <- train(Life.expectancy~., data=rf_who_data, method="rf", metric="RMSE", tuneGrid=tunegrid, trControl=control) #RMSE 2.54
print(rf_gridsearch)
plot(rf_gridsearch)
varImpPlot(rf_gridsearch$finalModel)

rf_gridsearch2 <- train(Life.expectancy~Income.composition.of.resources + Schooling + Adult.Mortality + HIV.AIDS
                          , data=rf_who_data, method="rf", metric="RMSE", tuneGrid=tunegrid, trControl=control) #RMSE 2.64
print(rf_gridsearch2)
plot(rf_gridsearch2)
varImpPlot(rf_gridsearch2$finalModel)

#least RMSE
rf_gridsearch3 <- train(Life.expectancy~Income.composition.of.resources + Schooling + Adult.Mortality + HIV.AIDS + thinness.5.9.years
                        , data=rf_who_data, method="rf", metric="RMSE", tuneGrid=tunegrid, trControl=control) #RMSE 2.51
print(rf_gridsearch3)
plot(rf_gridsearch3)
varImpPlot(rf_gridsearch3$finalModel)

rf_gridsearch4 <- train(Life.expectancy~Income.composition.of.resources + Schooling + Adult.Mortality + HIV.AIDS + thinness.5.9.years
                        + thinness..1.19.years
                        , data=rf_who_data, method="rf", metric="RMSE", tuneGrid=tunegrid, trControl=control) #RMSE 2.52
print(rf_gridsearch4)
plot(rf_gridsearch4)
varImpPlot(rf_gridsearch4$finalModel)

min(who_data$Schooling)

