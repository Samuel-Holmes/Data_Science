# myfirstR 
setwd("C:/Users/sholm/Desktop/CETM72")

# Introductory basics 


x <- 17 # preferred way of assigning values to variables 
X <- 18

x == 17 # checking if it is equal to that number   

# r is case sensitive so be careful with what you label variables 

y <- c(5, 6, 7, 8, 9) # concatenation 

mean(y) # built in mean function 

sd(y) #built in standard deviation function 

staff <- c('jim', 'paul' , 'jeff', 'gary', 'john') # using strings 

sort(staff) # sorted alphabetically 

#type staff back into console to overwrite 

grep('paul',staff) #get regular expression, checking it exists in staff and gives you the index 

people <- c('jim', 'paul') #looking for multiple so creating new group then using match function to see if they exist in staff 

match(people,staff)





# USING R for descriptive statistics 

data(mtcars) #load in the data 
head(mtcars) # print the first six records 

mtcars # show full data set 

tail(mtcars) #shows last six records 

mean(mtcars$mpg) #use the dollar symbol to access the variables within the dataset 
sd(mtcars$mpg) 

auto <- subset(mtcars, am == 0)
manual <- subset(mtcars, am == 1)
mean(manual$mpg)
mean(auto$mpg)               #breaking them down into subsets to find out which has better mpg manual or automatic transmission.
                             #using subset to partition based upon whether car is auto or manual using existing variable 'am' and using '==' as relational test 
                             #then creating two new variables to hold the split in the data 

 #plotting a boxplot 

mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic", "Manual")
boxplot(mpg~am, data = mtcars)            

#we use the as.factor command to convert the integer values in the am variable into factor types
#then use the concatenation operator to create a vector of strings vector = an observation in a given data set
#rather than using ones and zeros we make the box plot more informative by converting the levels into names
#50% of the data is contained in the grey area the whiskers contain the remaining 50% 
#horizontal line indicates the median value sometimes the median is more informative than the mean especially if there are outliers.
#outliers are normally indicated by an asterisk

 
#plotting a scatterplot 

plot(mtcars$wt, mtcars$mpg, main="Scatterplot Example" , xlab="Car Weight", ylab="Miles Per Gallon", pch=19)


#Finding standard deviation for auto and manual type cars

sd(auto$mpg)
sd(manual$mpg)

# finding information on a command you use the ? symbol followed by the function itself i.e. ?mean

?mean





















