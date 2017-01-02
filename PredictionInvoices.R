#Open file: customerWillSpendTabular.txt
myFile <- file.choose()

#Read file using ";" as separator and setting header.
df <- read.table(myFile, header = TRUE, sep = ";")

#Choose columns that will be used in model
dfColumns <- df[, c("valorTotal", "prod_vProd", "prod_vUnCom", "prod_qCom", "total_icmsTot_vTotTrib")]

#Set the seed so that the results are reproducible.
set.seed(150)

#Split the data into a training set and a testing set. 
#The training set is used to train and build the model.
#This model is tested on the testing set. 
#We want to have about 75% of the data in the training set and 25% of the data in the testing set. 
split <- sample(seq_len(nrow(dfColumns)), size = floor(0.75 * nrow(dfColumns)) )
trainData <- dfColumns[split, ]
testData <- dfColumns[-split,]


head(testData)

#Build the prediction model. 
#We will use the lm function for this
predictionModel <- lm(valorTotal ~ prod_vProd + prod_vUnCom + prod_qCom + total_icmsTot_vTotTrib, data = trainData)

#Summary of the dataset
#Determine which variables to include in the model.
#A linear regression can be represented by the equation: y_i = β_1 x_i1 + β_2 x_i2 + β_3 x_i3 + ⋯ + ε_i
#where y_i represents the outcome we’re prediction (valorTotal)
#x_i represent the various attributes (prod_vProd + prod_vUnCom + prod_qCom + total_icmsTot_vTotTrib)
#β represent their coefficients, and ε represents the constant term.
#The first column in the summary, namely Estimate gives us these values.
#The first value corresponds to ε, and the rest of the values correspond to the various β values.
#If the coefficient for a particular attribute is 0 or close to 0, that means it has very little to no effect on the prediction, and hence, can be removed.
#The standard error column gives an estimation of how much the coefficients may vary from the estimate values.
#The t value is calculated by dividing the estimate by the standard error column. 
#The last column gives a measure of how likely it is that the coefficient is 0 and is inversely proportional to the t value column. 
#Hence, an attribute with a high absolute value of t, or a very low absolute value of Pr(>|t|) is desirable.
summary(predictionModel)

#Apply the prediction model to the test data
prediction <- predict(predictionModel, newdata = testData )

#Look at the first few values of prediction, and compare it to the values of valorTotal in the test data set.
head(prediction)
head(testData$valorTotal)

#Calculate the value of R-squared for the prediction model on the test data 
SSE <- sum((testData$valorTotal - prediction)^2)
SST <- sum((testData$valorTotal - mean(testData$valorTotal)) ^ 2)

#R-squared value of 1 means that it is a perfect prediction model, and an R-squared value of 0 means that it is of no improvement over the baseline model 
#R-squared value is 0.81
1 - SSE / SST

















