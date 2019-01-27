# WHO-life-expectancy
I.	ABSTRACT
Average life expectancy can vary drastically between all 194 countries in the world. The goal of this project was to create a model that would estimate the average life expectancy of a country and to find out what factors influence the average life expectancy significantly. This is a regression problem. The data has sixteen different features which can be broadly classified into immunization factors, mortality factors, economical factors and social factors. The data was collected from the Global Health Observatory (GHO). Three different models have been used with varying errors.

II.	INTRODUCTION
This project was done to create a model that can predict the average life expectancy of a country based on sixteen different features. An additional goal was to find out the features which most greatly affect the average life expectancy. These features can be generally grouped into immunization factors, mortality factors, economical factors and social factors. The dataset was obtained from kaggle. It was scrapped from the Global Health Observatory (GHO) website. The GHO is an initiative of the World Health Organisation (WHO) which aims to share data on global health. Each country has sixteen observations, one for every year from 2000 to 2015 with some exceptions like South Sudan which became a country only in 2011. This analysis will allow us to find the factors which factors most greatly indicate a higher or lower average life expectancy. Usage of this information can show what countries need to strengthen in order to improve life expectancy. A detailed description of the data and the methods used will be given.

III.	BODY
A.	Data
The dataset, as mentioned in the introduction, was found on kaggle. It was scrapped from the Global Health Observatory (GHO) website. Each country had fifteen observations and each observation was from a particular year from 2000 to 2015. There are 194 countries included in the dataset which is all the countries officially recognized by the WHO. Most countries have data for every year from 2000-2015 with a few exceptions such as South Sudan which only became a country in 2011. There are 16 different features which can be broadly classified into immunization factors, mortality factors, economical factors and social factors. The features are listed below.

•	Status – if the nation is developed or developing
•	Adult.Mortality – the probability of dying between 15 and 60 years old per 1000 population
•	infant.deaths – number of infant deaths per 1000 population
•	Alcohol – alcohol consumption in litres per capita per year
•	percentage expenditure - Expenditure on health as a percentage of Gross Domestic Product per capita(%)
•	Hepatitis B - Hepatitis B (HepB) immunization coverage among 1-year-olds (%)
•	Measles – reported number of measles cases per 1000 population
•	BMI – Average body mass index of the entire population
•	under-five deaths - Number of under-five deaths per 1000 population
•	Polio - Polio (Pol3) immunization coverage among 1-year-olds (%)
•	Total expenditure - General government expenditure on health as a percentage of total      government expenditure (%)
•	Diphtheria - Diphtheria tetanus toxoid and pertussis (DTP3) immunization coverage among 1-year-olds (%)
•	HIV/AIDS - Deaths per 1000 live births HIV/AIDS (0-4 years)
•	GDP- Gross Domestic Product per capita (in USD)
•	Population – population of the country
•	thinness  1-19 years - Prevalence of thinness among children and adolescents for Age 10 to 19 (% )
•	thinness 5-9 years - Prevalence of thinness among children and adolescents for Age 5 to 9 (% )
•	Income composition of resources - Human Development Index in terms of income composition of resources (index ranging from 0 to 1)
•	Schooling – Number of years of schooling

B.	Methods
Three different algorithms were used, namely linear regression, polynomial regression and random forest. Only observations from 2014 were used due to individual countries being grouped in the same leaf when multiple years were used. A few observations had missing features; these observations were removed as there were not too many of them. 174 countries were left out of the original 194.

For the linear and polynomial regression models, initially all the features were used. Then a function to find the best possible subset in terms of R2 was used for feature selection. The plot for the subsets of the linear model is given below.
 
The RMSE for both these models was calculated using 10 fold cross-validation. 

For the random forest model, initially all the features were used. Then using grid search, the model was tuned. The only hyperparameter that needed tuning was the number of variables used at each branch. Using the variable importance of the created model, the most important features could be seen. 
 
A number of models were created with a varying number of features. The final model only had five features compared to the original sixteen.
 

C.	Results
The RMSE of the linear model was 3.28 and the RMSE of the polynomial model was 2.92. The random forest model had a marginally better RMSE of 2.54 which reduced to 2.51 after feature selection. The five features used in the random forest model with the least RMSE are namely,

•	Income composition of resources - Human Development Index in terms of income composition of resources (index ranging from 0 to 1)
•	Schooling – Number of years of schooling
•	Adult.Mortality – the probability of dying between 15 and 60 years old per 1000 population
•	HIV/AIDS - Deaths per 1000 live births HIV/AIDS (0-4 years)
•	thinness 5-9 years - Prevalence of thinness among children and adolescents for Age 5 to 9 (%)

Given how marginal the reduction in RMSE is from the polynomial to the random forest model it may be preferable to use the polynomial model due to increased interpretability. 

IV.	CONCLUSIONS/DISCUSSION
•	Models were created that were able to predict the average life expectancy of a country with a neglible amount of error.
•	There are a few key features that largely determine the average life expectancy of a country.
•	On retrospection and input from my peers, it seems like population density might also factor in heavily instead of population as a whole. This would require getting the area of each country which is not available in this dataset but can be easily obtained.

V.	APPENDIX
A.	Miscellaneous Terms
BMI – This stands for Body Mass Index. It is a generalised method of determining whether a person is of the right weight with respect to their height. A healthy BMI is between 19 and 25. Over 25 is considered to be obese and under 19 is considered to be underweight though this is not absolute. It is possible to be outside of this range and be of a healthy composition. For example, a person with a large amount of muscle mass is likely to have a BMI greater than 25 and would be completely healthy.

Human Development Index – According to the United Nations Development Programme, “The Human Development Index (HDI) is a summary measure of average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living.”

Thinness – Thinness is when one is underweight, it is generally indicated by a BMI less than 19 but this varies at different age groups.

Linear Model
The linear model was run using all the variables that could be used, 16 in number. The MSE is 16.67 with a R2 of 0.835. Due to the simplicity of this model, it is unlikely to be the best way to go about this problem. A MSE of 16.67 is not acceptable as the range of average life expectancy is (36.3,89.0).

Coefficients:
                                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)                      5.319e+01  7.374e-01  72.130  < 2e-16 ***
StatusDeveloping                -1.250e+00  3.130e-01  -3.993 6.75e-05 ***
Adult.Mortality                 -1.532e-02  9.000e-04 -17.025  < 2e-16 ***
infant.deaths                    8.531e-02  8.625e-03   9.891  < 2e-16 ***
Alcohol                         -3.259e-02  2.954e-02  -1.103    0.270    
percentage.expenditure           3.063e-04  4.764e-05   6.429 1.60e-10 ***
Measles                         -7.271e-06  8.649e-06  -0.841    0.401    
BMI                              3.485e-02  5.810e-03   5.998 2.37e-09 ***
under.five.deaths               -6.363e-02  6.376e-03  -9.979  < 2e-16 ***
Polio                            2.289e-02  5.095e-03   4.491 7.47e-06 ***
Total.expenditure                3.780e-02  3.899e-02   0.969    0.332    
Diphtheria                       2.153e-02  5.151e-03   4.180 3.04e-05 ***
HIV.AIDS                        -4.851e-01  1.821e-02 -26.645  < 2e-16 ***
thinness..1.19.years            -5.262e-02  5.385e-02  -0.977    0.329    
thinness.5.9.years               2.062e-02  5.326e-02   0.387    0.699    
Income.composition.of.resources  7.075e+00  6.971e-01  10.149  < 2e-16 ***
Schooling                        9.164e-01  4.984e-02  18.385  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.809 on 2027 degrees of freedom
Multiple R-squared:  0.8361,	Adjusted R-squared:  0.8348 
F-statistic: 646.1 on 16 and 2027 DF,  p-value: < 2.2e-16


Polynomial Model
The polynomial model was run using all the variables as well as the same variables with degrees up to 3. The MSE is 9.32 with a R2 of 0.90 which is an improvement from the linear model but this is not acceptable as well given the range of average life expectancy. As the number of variable is much greater than the linear model, I haven’t included the coefficients for each variable.

Residual standard error: 2.961 on 1997 degrees of freedom
Multiple R-squared:  0.9024,	Adjusted R-squared:  0.9002 
F-statistic: 401.5 on 46 and 1997 DF,  p-value: < 2.2e-16


Random Forest Model
The random forest model was run using all the variables. The default parameters given by R were used. The MSE is 3.03 with an R2 of 0.966. This is obviously the best model amongst all the models and the MSE is more acceptable, however we can do better. This model can be improved by tuning the model parameters. Dimensionality reduction can also be used as it can be seen that not all the variables are significant. I would also use K-fold cross validation to further tune the model and reduce the MSE.

Call:
 randomForest(formula = Life.expectancy ~ Status + Adult.Mortality +      infant.deaths + Alcohol + percentage.expenditure + Measles +      BMI + under.five.deaths + Polio + Total.expenditure + Diphtheria +      HIV.AIDS + thinness..1.19.years + thinness.5.9.years + Income.composition.of.resources +      Schooling, data = who_data) 
               Type of random forest: regression
                     Number of trees: 500
No. of variables tried at each split: 5

          Mean of squared residuals: 3.030365
                    % Var explained: 96.57
