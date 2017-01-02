
myFile <- file.choose()

df <- read.table(myFile, header = TRUE, sep = ";" )
dfSum <- aggregate(df[, 1], list(df$weekNumber), sum)

print('Grouping sales sum for weeks')
dfSum

revenue_fit <- lm(x ~ Group.1, data=dfSum)

data_ahead  <- data.frame(Group.1=c(length(dfSum$Group.1)+1))
forecast_1w <- predict(revenue_fit, data_ahead)

paste("Sales forecast for the next week:", round(forecast_1w, digits = 2), sep=" ")

