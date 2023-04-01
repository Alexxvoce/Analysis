#linear regressions
plot(NWdataframe$BMI, NWdataframe$Pulse, col = "RED")
xrnge = range(NWdataframe$Pulse,na.rm=T)

x = xrnge[1]:xrnge[2]
yp = b1*x + b0
plot(NWdataframe$Pulse,NWdataframe$BMI, col = "RED",ylab = "not working pulse",xlab = "not working BMI")
lines(x,yp,col = "BLUE",lwd = 3)

##loglinear
pulse.reg <- lm(Pulse ~ BMI, data = nhanes.sub) # fit linear model
summary(pulse.reg)                              # Get a summary of the model to inspect coefficients
b0 = pulse.reg$coefficients[1]                  # extract the intercept (Estimate for the (Intercept))
b1 = pulse.reg$coefficients[2]                  # extract the slope (Estimate for BMI)

#generating predictions
xrange = range(nhanes.sub$BMI,na.rm=T)  # storing minimum and maximum values for regression, i.e., the max and min BMI values
x.pred = xrange[1]:xrange[2]            # range of independent variable (BMI) values for regression (equally spaced from min(nhanes.sub$BMI) to max(nhanes.sub$BMI) in increments of 1)
y.pred = x.pred*b1 + b0 # Use the linear equation with valuesof x to find the predicted y-values

#predicting with predict()
predVal = predict(pulse.reg, interval = "confidence")

#plotting with abline
par(mar=c(5, 5, 3, 1), cex.lab = 2, cex.axis = 1.5, cex.main = 2, font.main = 1, bg='white') # tune plot parameters
plot(nhanes.sub$BMI,nhanes.sub$Pulse,xlab='BMI',ylab='pulse') # scatterplot
abline(pulse.reg, lwd = 2, col = "red") 