#conditional probability
#P(A|B) = P(A and B)/P(B)

condition = c('flu','noflu')
vaccine = c(10,3000)
novaccine = c(1000,10000)
flutable = tibble(condition,vaccine,novaccine)
#condition flu with vaccine
AandB = 10
B = 3010
PAandB = 10/3010

NHNW = NHANES %>% 
  filter(Work == 'NotWorking')

diabactive = NHNW %>% 
  filter(Diabetes == 'Yes'&PhysActive == 'Yes')
diabinactive = NHNW %>% 
  filter(Diabetes == 'Yes'&PhysActive == 'No')
nodiabactive = NHNW %>% 
  filter(Diabetes == 'No'&PhysActive == 'Yes')
notnot = NHNW %>% 
  filter(Diabetes == 'No'&PhysActive == 'No')
#P(Diabetic and not active)
PDNA = dim(diabinactive)[1]/dim(NHNW)[1]
#P(Not active)
PNA = sum(NHNW$PhysActive == 'No',na.rm = T)/dim(NHNW)[1]
#P(dia|na)
PAB = PDNA/PNA
PAB

#check P adds up to 1
#P(not diabetic not active)
PNDNA = dim(notnot)[1]/dim(NHNW)[1]
P = PNDNA/PNA
P
PAB + P