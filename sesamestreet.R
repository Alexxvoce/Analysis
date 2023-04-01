#Script name
#Date
#Author
#Version
#Purpose
#Notes

#Preregistration
cat('Research Question:\n Does watching Sesame Street (come back) improve childrens cognitive development
    while accounting for mental age score and which Manchester borough they are from?')
cat('Hypotheses:\nH0: There will not be a significant improvement in cognitive development in children who watch Sesame Street
    more frequently as compared to those who do not, while accounting for mental age scores and borough\n
    H1: There will be a significant improvement in cognitive development in children who watch Sesame Street
    more frequently as compared to those who do not, while accounting for mental age score and borough.')
cat('Analysis Plan: Linear mixed model regression!\n
    Outcome variable (fixed) - Improvement of participants knowledge of numbers (numeric, as proportion of maximum possible score),\n
    Predictor variable (fixed) - Frequency of Sesame Street viewing per week (ordinal, rarely-more than 5 times per week)\n
    Controlled variable (fixed) - Baseline mental age score from Peabody (categorical(?),1 - 43)
    Random effect variable - The Mancunian Borough that the participant is from (Categorical, Site 1/2) ')
#come back
#Loading packages
install.packages('dplyr')
library(dplyr)
install.packages('skimr')
install.packages('pastecs')
install.packages('ggplot2')
library(ggplot2)
install.packages('lme4')
install.packages('performance')
install.packages('patchwork')
install.packages('car')

#Load and prep data
SesameStreet = read.csv('questionC_sesame.csv')
head(SesameStreet)

SesameStreet = SesameStreet %>%
  mutate(
    across(.cols = c('view_freq','site'),as.factor) %>% 
      glimpse()
  )

#Inspecting balance using xtabs and checking for NAs using Skim
xtabs(~ view_freq + site, SesameStreet)
skimr::skim(SesameStreet)
#No NAs 
#Data are slightly unbalanced, but LMMs tolerate unbalanced data

#calculate descriptive statistics
#grand mean and SD
pastecs::stat.desc(SesameStreet$numb_improv,basic = F)
#mean and SD peabody score 
pastecs::stat.desc(SesameStreet$peabody,basic = F)
#marginal means and SDs
#mean and sd improvement by viewing frequency 
(margMeanViewing= tapply(SesameStreet$numb_improv,SesameStreet$view_freq,mean))
(margSDViewing = tapply(SesameStreet$numb_improv,SesameStreet$view_freq,sd))
#mean and sd improvement by site
(margMeanSite= tapply(SesameStreet$numb_improv,SesameStreet$site,mean))
(margSDSite = tapply(SesameStreet$numb_improv,SesameStreet$site,sd))
#cell means as tibble
(Table1 = SesameStreet %>% 
  dplyr::group_by(view_freq,site) %>% 
  dplyr::summarise(mean = round(mean(numb_improv),2),
                   sd = round(stats::sd(numb_improv),2)))

#visualise!
#figure 1 will show improvement as a function of viewing frequency using a boxplot
(Figure1 = ggplot(SesameStreet,aes(view_freq,numb_improv, fill = view_freq)) + 
    geom_boxplot() + 
    facet_wrap(.~site) + ggtitle('Boxplot showing score improvement as a 
    function of viewing frequency') +
    xlab('Viewing Frequency') + ylab('Improvement'))
#figure 2 will show the relationship between peabody mental age score and improvement in number knowledge, coloured by viewing frequency and facetted by site
(Figure2 = ggplot(SesameStreet,aes(peabody,numb_improv,col = view_freq)) + 
    geom_smooth(method = lm,se = F) + 
    facet_wrap(.~site) + ggtitle('Line graph depicting the relationship between 
    peabody mental age score and improvement in number knowledge, coloured by 
    viewing frequency and facetted by site') + xlab('Peabody score of mental age') + 
    ylab('Improvement in number knowledge'))
#figure 3 will show improvement in number knowledge as a function of peabody score and coloured by viewing frequency, as well as facetted by site
(Figure3 = ggplot(SesameStreet,aes(peabody,numb_improv, fill = view_freq)) + 
    geom_bar(stat = 'identity', position = 'dodge') + 
    facet_wrap(.~site) + ggtitle('Bar chart showing improvement in number knowledge as a function of peabody scores
of sesame street, coloured by viewing frequency and facetted by site') +
    xlab('Peabody score') + ylab('Improvement'))
#figure 4 will show the improvement in number knowledge as a function of viewing frequency and coloured by mental age score on the peabody, as well as facetted by site
(Figure4 = ggplot(SesameStreet,aes(view_freq,numb_improv, fill = view_freq)) + 
    geom_bar(stat = 'identity', position = 'dodge') + 
    facet_wrap(.~site) + ggtitle('Bar chart showing improvement in 
number knowledge as a function of viewing frequency
of sesame street, coloured by viewing frequency and
facetted by site') +
    xlab('viewing frequency') + ylab('Improvement'))

#Now creating a full model, with random slope, but fixed intercept as categorical
Sesame_Full = lme4::lmer(numb_improv ~ view_freq + peabody + (1 | site),SesameStreet)

#creating a null model by removing the predictor variable of viewing frequency
Sesame_Null = lme4::lmer(numb_improv ~ peabody + (1 | site),SesameStreet)

#check assumptions - normality, linearity, no excessive multicollinearity
(assumptions_plot = performance::check_model(Sesame_Full))
#Looks okay, back it up by checking with more tests
#normality of residuals
shapiro.test(residuals(Sesame_Full))
#non-significant, so normality is good!
car::vif(Sesame_Full)
#no VIF results >5, so no excessive multicollinearity!


#Check output!
summary(Sesame_Full)
#Compare model fit to the null model
anova(Sesame_Full,Sesame_Null,test = 'Chisq')

#Full model has a lower AIC score, so it is a better fit, and significantly!
#extract coefficients
lme4::fixef(Sesame_Full)
lme4::ranef(Sesame_Full)
