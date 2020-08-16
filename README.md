# foreign_body
To estimate nationwide incidence of emergency department (ED) visits for pelvic foreign body occurring in the bladder, vagina and rectum, and analyze demographic and anatomic‐specific trends.


## Materials and Methods
There is an R package to access data from the National Electronic Injury Surveillance System (NEISS) (http://www.cpsc.gov/en/Research–Statistics/NEISS‐Injury‐Data/).  The National Electronic Injury Surveillance System (NEISS) was accessed from the Consumer Product Safety Commission's Web site and used for the collection of data. This resource has proven invaluable in myriad prior analyses evaluating nationwide trends occurring in emergency medicine.4-7 Briefly, this database collects data from 100 participating hospital EDs, which is used to derive a stratified probability sample of visits to the approximately 5,000 EDs nationwide that have at least six beds and are open 24 hours a day, 7 days a week.8-10 From these figures, the NEISS creates annual estimates of each type of injury.9 This resource allows one to search for injuries organized by several general diagnoses, specific consumer products, and patient demographics. Additionally, a one‐ to two‐phrase narrative that describes other aspects of the patient visit is included for many cases.

We searched this database for retained foreign body and evaluated results specifically relating to the female pelvis. We were able to search for injuries with the anatomic designations including “bladder,” “vagina,” and “rectum,”. ” We excluded pregnant patients in this analysis. This database provided annual sample sizes as well as derived national estimates for retained foreign objects throughout the body. The annual sample size of injuries organized by anatomic site was divided by the annual sample size of retained foreign body for all sites, and this proportion was multiplied by the nationwide estimate to come up with specific values for injury incidence organized by anatomic site. For example, the NEISS reported ?? retained foreign body‐related ED visits (regardless of anatomic location) in 2012—and provided a derived estimate of 15,058 nationwide ED visits from this number. Because 29 of these 470 visits (6.2%) were related to injuries of the face, we multiplied 15,058 by 6.2% to come up with a figure of 929 battery‐instigated facial injuries for 2012. In addition to annual estimates, we also analyzed data by patient demographics (including age and gender), injury diagnosis, and patient disposition. We examined data from the most recent available 10‐year block (2003–2012). Data collection was completed in December 2013.

Statistical Analysis
Mann‐Whitney U‐tests and Fischer's exact test were used for comparison of continuous and categorical data, respectively. The threshold for statistical significance was set at P < 0.05, and R 4.0.1 (r-project.org) was used for statistical analysis.




This package only goes up to 2017 for data.  
```r
# install.packages("devtools")
devtools::install_github("hadley/neiss", force = TRUE)
library(neiss)
library(tidyverse)

injuries1 <- 
  injuries %>%
  filter(sex == "Female") %>%
  filter(age >=16) 
View(injuries)

products
write.csv(products, "~/Dropbox/products_NEISS.csv")
write.csv(injuries1, "~/Dropbox/injuries_NEISS.csv")
```

