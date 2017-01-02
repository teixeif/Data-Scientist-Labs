
myFile <- file.choose()

df <- read.table(myFile, header = TRUE, sep = ";")
dfColumns <- df[, c("valorTotal", "prod_vProd", "prod_vUnCom", "prod_qCom", "total_icmsTot_vTotTrib")]
set.seed(150)
split <- sample(seq_len(nrow(dfColumns)), size = floor(0.75 * nrow(dfColumns)) )
trainData <- dfColumns[split, ]
testData <- dfColumns[-split,]
head(testData)
predictionModel <- lm(valorTotal ~ prod_vProd + prod_vUnCom + prod_qCom + total_icmsTot_vTotTrib, data = trainData)
summary(predictionModel)
prediction <- predict(predictionModel, newdata = testData )
head(prediction)
head(testData$valorTotal)

SSE <- sum((testData$valorTotal - prediction)^2)
SST <- sum((testData$valorTotal - mean(testData$valorTotal)) ^ 2)

1 - SSE / SST          















