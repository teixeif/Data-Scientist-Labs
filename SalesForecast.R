#Open file: saleForecastTabular.txt
myFile <- file.choose()

#Read file using ";" as separator and setting header.
df <- read.table(myFile, header = TRUE, sep = ";" )

#Sum values by weeks
dfSum <- aggregate(df[, 1], list(df$weekNumber), sum)

print('Grouping sales sum for weeks')
dfSum

#Linear Model Fitting
revenue_fit <- lm(x ~ Group.1, data=dfSum)

#Forecasting 1 Week Ahead
data_ahead  <- data.frame(Group.1=c(length(dfSum$Group.1)+1))
forecast_1w <- predict(revenue_fit, data_ahead)

paste("Sales forecast for the next week:", round(forecast_1w, digits = 2), sep=" ")

