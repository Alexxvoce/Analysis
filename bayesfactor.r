#bayes factor analyis

#set up data frame 
df = data.frame(prior = NA, likelihood = NA, mlikelihood = NA, posterior = NA)
#add in figures we know for prior
df$prior = 1/1000000

tests = 3
postest = 3
sensitivity = 0.99
specificity = 0.99
#use dbinom to set up a distribution
df$likelihood = dbinom(tests,postest,0.99)
#marginal likelihood equation
df$mlikelihood = dbinom(x = postest,size = tests, prob = sensitivity) * df$prior +
  dbinom(x = postest,size = tests, prob = 1 - specificity)*(1-df$prior)
df$posterior = (df$likelihood * df$prior)/df$mlikelihood

#this one seems to work better? 
#prior = people with rona
prior = 1/200000

sensitivity = 0.97
specificity = 0.98

likelihood = sensitivity
mlike = (sensitivity * prior) + ((1 - specificity) * (1-prior))
posterior = (likelihood * prior)/mlike
posterior
cat('\nthe probability that an individual with a positive test result has coronavirus is',posterior)

  