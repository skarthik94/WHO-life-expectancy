original_data=read.csv('C:/Users/Karthik/Desktop/MSDA/sem 3-summer 2018/data mining 2/project/clean_who_data.csv') #do not modify this variable
who_data=original_data #data to be used
set.seed(100)

#train-test split
smp_size = floor(0.8 * nrow(who_data))
train_ind = sample(seq_len(nrow(who_data)), size = smp_size)
train <- who_data[train_ind, ]
test <- who_data[-train_ind, ]

#linear model
fit_linear = lm(Life.expectancy ~ Status + Adult.Mortality + infant.deaths + Alcohol + percentage.expenditure + Measles + BMI + under.five.deaths + Polio 
         + Total.expenditure + Diphtheria + HIV.AIDS + thinness..1.19.years + thinness.5.9.years + Income.composition.of.resources + Schooling, data = train)
summary(fit_linear)
MSE_linear = mean((test$Life.expectancy - predict(fit_linear,test))^2)

#polynomial model
fit_poly = lm(Life.expectancy ~ Status + poly(Adult.Mortality,3,raw = TRUE) + poly(infant.deaths,3,raw = TRUE) + poly(Alcohol,3,raw = 3) 
         + poly(percentage.expenditure,3,raw = TRUE) + poly(Measles,3,raw = TRUE) + poly(BMI,3,raw = TRUE) + poly(under.five.deaths,3,raw = TRUE) 
         + poly(Polio,3,raw = TRUE)  + poly(Total.expenditure,3,raw = TRUE) + poly(Diphtheria,3,raw = TRUE) + poly(HIV.AIDS,3,raw = TRUE) 
         + poly(thinness..1.19.years,3,raw = TRUE) + poly(thinness.5.9.years,3,raw = TRUE) + poly(Income.composition.of.resources,3,raw = TRUE) 
         + poly(Schooling,3,raw = TRUE), data = train)
summary(fit_poly)
MSE_poly = mean((test$Life.expectancy - predict(fit_poly,test))^2)

#random forest
require(randomForest)
fit_rf = randomForest(Life.expectancy ~ Status + Adult.Mortality + infant.deaths + Alcohol + percentage.expenditure + Measles + BMI + under.five.deaths + Polio 
                      + Total.expenditure + Diphtheria + HIV.AIDS + thinness..1.19.years + thinness.5.9.years + Income.composition.of.resources + Schooling
                      , data = who_data)
fit_rf$
MSE_rf = mean(fit_rf$mse)
range(who_data$Life.expectancy)
