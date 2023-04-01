#dragons LMM

#load data
load('dragons.RData')
head(dragons)

#prep data
dragons$mountainRange = as.factor(dragons$mountainRange)
dragons$site = as.factor(dragons$site)
#check balance with xtabs 
xtabs(~ mountainRange + site, dragons)
#grand mean and SD
pastecs::stat.desc(dragons$testScore,basic = F)
#marginal means
#mean by mountain range
(margmnmount = tapply(dragons$testScore,dragons$mountainRange,mean))
(margsdmount = tapply(dragons$testScore,dragons$mountainRange,sd))
#mean by site
(margmnsite = tapply(dragons$testScore,dragons$site,mean))
(margsdsite = tapply(dragons$testScore,dragons$site,sd))
#cell means as tibble
cell_tibble = dragons %>% 
  dplyr::group_by(mountainRange,site) %>% 
  dplyr::summarise(mean = round(mean(testScore),2),
                   sd = round(stats::sd(testScore),2))
cell_tibble
#visualisations
(Figure1 = ggplot(dragons,aes(bodyLength,testScore,col = mountainRange)) +
    geom_smooth(method = lm, se = F)) +
  facet_wrap(.~site)
(Figure2 = ggplot(dragons,aes(mountainRange,testScore,fill = mountainRange)) +
    geom_boxplot()) + 
  facet_wrap(.~site)


#full lm random both
draglm = lme4::lmer(testScore ~ bodyLength + mountainRange + (1 | site) + (0 + bodyLength | site),dragons)

#null lm 
dragnull = lme4::lmer(testScore ~ mountainRange + (1 | site) + (0 + bodyLength | site),dragons)

#check assumptions
performance::check_model(draglm)
#looks good
#check more
shapiro.test(residuals(draglm))
#vif? leave for now

#check summary
summary(draglm)

#compare model fit
anova(draglm,dragnull,test = 'Chisq')

#get coefficients
lme4::fixef(draglm)

#writeup 
