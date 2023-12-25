cars <- read.csv("C:\\Users\\Mohammad Faizal\\Downloads\\Cars.csv")
df <- datasets::airquality
head(df)
head(df,25)
tail(df,10)


#### To get Summary ###
summary(df)
attach(df)
Ozone

### Scatter Plot ###

plot(x= Ozone, y= Temp)

plot(Ozone,Wind, xlab = "Level of Ozone", ylab = "Wind Values",
    main = " Rel between Wind and Ozone",
    col = "green", pch = 19 )


###   Plot all Points           ###
    plot(df)
    
    
## Horizontal Bar Plot ##
    barplot(Month)
    unique(Month)
fre <-    table(Month)
 barplot(fre, col = 'red')
 
 