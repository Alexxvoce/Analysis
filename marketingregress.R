
#create a model that predicts sales based on advertising budget on different platforms
data('marketing',package = 'datarium')
head(marketing)

#plot each predictor against outcome
library(ggplot2)
(p1 = ggplot(marketing,aes(youtube,sales)) + geom_point()
  + geom_smooth(method = lm))
(p2 = ggplot(marketing,aes(facebook,sales)) + geom_point() 
  + geom_smooth(method = lm))
(p3 = ggplot(marketing,aes(newspaper,sales)) + geom_point() 
  + geom_smooth(method = lm))
ggpubr::ggarrange(p1,p2,p3)
#youtube and facebook more strongly linear than newspaper

#create MLR
marketinglm = lm(sales ~ youtube + facebook, marketing)

#check assumptions
performance::check_model(marketinglm)
shapiro.test(marketinglm$residuals)
#homogeneity
plot(marketinglm,which = 3)
car::ncvTest(marketinglm)

library(corrplot)
newdat = marketing[,c('youtube','facebook')]
cormat = round(cor(newdat),2)
corrplot.mixed(cormat)
car::vif(marketinglm)

#check outputs
summary.lm(marketinglm)

effectsize::effectsize(marketinglm)
