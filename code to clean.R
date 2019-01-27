original_data=read.csv('C:/Users/Karthik/Desktop/MSDA/sem 3-summer 2018/data mining 2/project/life-expectancy-who/Life Expectancy Data.csv') #do not modify this variable
who_data=original_data #data to be used

nrow(who_data) #2938
ncol(who_data) #22

#CLEANING AND EXPLORATION
#see number of na
sum(is.na(who_data)) #see number of na

#check for na

sum(is.na(who_data$Life.expectancy)) #10, as this is the dependent variable, all these rows will be eliminated
who_data = who_data[is.na(who_data$Life.expectancy)==0,] 

#see the number of na values by column
na_by_col=colSums(is.na(who_data))
View(na_by_col) #population, Hepatitis.B, GDP have too many na values so they will be removed
who_data=subset(who_data, select = -c(Population,Hepatitis.B,GDP))
sum(is.na(who_data)) #see number of na

#see missing data by row
table(rowSums(is.na(who_data)))

#see the number of na values by country
country_na=aggregate(rowSums(is.na(who_data)), by=list(Country=who_data$Country),FUN=sum)
country_na_year_avg=country_na
country_na_year_avg$x=country_na_year_avg$x/16
#South sudan, sudan, Somalia, Democratic People's Republic of Korea, Côte d'Ivoire,Czechia,Democratic Republic of the Congo,Republic of Korea,Republic of Moldova,United Republic of Tanzania,United States of America, and United Kingdom of Great Britain and Northern Ireland have too many na values, so they will be removed
countries_to_remove = c('South Sudan','Sudan','Democratic People\'s Republic of Korea','Somalia','Côte d\'Ivoire','Czechia','Democratic Republic of the Congo','Republic of Korea','Republic of Moldova','United Republic of Tanzania','United States of America', 'United Kingdom of Great Britain and Northern Ireland')
who_data=who_data[!(who_data$Country %in% countries_to_remove),]
sum(is.na(who_data)) #see number of na

sum(is.na(who_data$Country)) #0
sum(is.na(who_data$Year)) #0
sum(is.na(who_data$Status)) #0
sum(is.na(who_data$Adult.Mortality))#0
sum(is.na(who_data$infant.deaths))#0

sum(is.na(who_data$Alcohol))#167
alcohol_country_table_na=table(who_data[is.na(who_data$Alcohol)==1,]$Country)
View(alcohol_country_table_na) 
alcohol_year_table_na=table(who_data[is.na(who_data$Alcohol)==1,]$Year)
View(alcohol_year_table_na) #almost all the na values are from 2015, and no country gets eliminated fully
who_data=who_data[!(is.na(who_data$Alcohol)),]
sum(is.na(who_data)) #see number of na

who_data[rowSums(is.na(who_data))>0,] #to see rows with na values
#as each country has 16 entries, I think it's reasonable to remove the remaining rows that have na values as the values don't change drastically between years and all the countries are well represented despite these entries being removed
who_data=who_data[rowSums(is.na(who_data))==0,]
sum(is.na(who_data)) #see number of na

write.csv(who_data, file = 'clean_who_data.csv')
