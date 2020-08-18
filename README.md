# foreign_body
## What got where?:  A Population-Based Analysis of Pelvic Foreign Bodies in Women
To estimate nationwide incidence of emergency department (ED) visits for pelvic foreign body occurring in the bladder, vagina and rectum, and analyze demographic and anatomic‐specific trends.

# Video explaining the data
* https://youtu.be/C8xHu2xgC9o
* I think that I could do the materials and methods plus results if you guys do the intro and discussion.  To discuss.  


NEISS:
* https://www.cpsc.gov/Research--Statistics/NEISS-Injury-Data
* https://www.cpsc.gov/cgibin/NEISSQuery/WebEstimates.html
* https://www.cpsc.gov/cgibin/NEISSQuery/home.aspx
* https://lenagroeger.s3.amazonaws.com/talks/orlando/exercises/ExcelMath/math.html
* https://www.dropbox.com/s/nfo87g26mz93d0r/svider_article.pdf?dl=0

## Materials and Methods
There is an R package to access data from the National Electronic Injury Surveillance System (NEISS) (http://www.cpsc.gov/en/Research–Statistics/NEISS‐Injury‐Data/).  The National Electronic Injury Surveillance System (NEISS) was accessed from the Consumer Product Safety Commission's Web site and used for the collection of data. This resource has proven invaluable in myriad prior analyses evaluating nationwide trends occurring in emergency medicine.4-7 Briefly, this database collects data from 100 participating hospital EDs, which is used to derive a stratified probability sample of visits to the approximately 5,000 EDs nationwide that have at least six beds and are open 24 hours a day, 7 days a week.8-10 From these figures, the NEISS creates annual estimates of each type of injury.9 This resource allows one to search for injuries organized by several general diagnoses, specific consumer products, and patient demographics. Additionally, a one‐ to two‐phrase narrative that describes other aspects of the patient visit is included for many cases.

```r
NEISS Query Results

National Estimate of Injuries Treated in Emergency Departments
Treatment Dates: 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019

National Estimate
66,485,379
Suggested Citation: Consumer Product Safety Commission. National Electronic Injury Surveillance System 2000-2019 on NEISS Online Database, released April, 2020. Generated at https://www.cpsc.gov/cgibin/NEISSQuery/home.aspx. on: August 16, 2020 at 0:00:46

User Selected On: Most Recent 10 Years (2010 - 2019); Gender: Female (2);
```

We searched this database for retained foreign body and evaluated results specifically relating to the female pelvis. We were able to search for injuries with the anatomic designations including “bladder,” “vagina,” and “rectum,”. ” We excluded pregnant patients in this analysis. This database provided annual sample sizes as well as derived national estimates for retained foreign objects throughout the body. The annual sample size of injuries organized by anatomic site was divided by the annual sample size of retained foreign body for all sites, and this proportion was multiplied by the nationwide estimate to come up with specific values for injury incidence organized by anatomic site. For example, the NEISS reported 1,244 cases of women with retained foreign body‐related ED visits (regardless of anatomic location) in 2019—and provided a derived estimate of 54,086 nationwide ED visits from this number. Because 64 of these 1,244 visits (5.1%) were related to injuries of the female pelvis, we multiplied 54,086 by 5.1% to come up with a figure of 2,758 foreign body female pelvis injuries for 2019. In addition to annual estimates, we also analyzed data by patient demographics (including age and gender), injury diagnosis, and patient disposition. We examined data from the most recent available 10‐year block (2010–2020). Data collection was completed in August 2020.

Statistical Analysis
Mann‐Whitney U‐tests and Fischer's exact test were used for comparison of continuous and categorical data, respectively. The threshold for statistical significance was set at P < 0.05, and R 4.0.1 (r-project.org) was used for statistical analysis.

Results of the NEISS Query for 16 years old, females with foreign body diagnosis (NEISS diagnosis number 56):
```r
Home Research & Statistics National Electronic Injury Surveillance System (NEISS) NEISS Estimates Query Builder
NEISS Query Results

National Estimate of Injuries Treated in Emergency Departments
Treatment Dates: 01/01/2019 - 12/31/2019

National Estimate
54,086
Suggested Citation: Consumer Product Safety Commission. National Electronic Injury Surveillance System 2000-2019 on NEISS Online Database, released April, 2020. Generated at https://www.cpsc.gov/cgibin/NEISSQuery/home.aspx. on: August 16, 2020 at 22:08:07
 
Prior to 2019, each NEISS record allowed a maximum of one diagnosis and body part. In 2019 the NEISS began collecting up to two diagnoses and body parts per record. As a result, a NEISS record may be counted multiple times in producing national injury estimates and calculating variability of those estimates. A single record may be counted in up to two different diagnosis/body part combinations.

User Selected On: Date Range from 01/01/2019 to 12/31/2019; Ages in Years: 16 years, 17 years, 18 years, 19 years, 20 years, 21 years, 22 years, 23 years, 24 years, 25 years, 26 years, 27 years, 28 years, 29 years, 30 years, 31 years, 32 years, 33 years, 34 years, 35 years, 36 years, 37 years, 38 years, 39 years, 40 years, 41 years, 42 years, 43 years, 44 years, 45 years, 46 years, 47 years, 48 years, 49 years, 50 years, 51 years, 52 years, 53 years, 54 years, 55 years, 56 years, 57 years, 58 years, 59 years, 60 years, 61 years, 62 years, 63 years, 64 years, 65 years, 66 years, 67 years, 68 years, 69 years, 70 years, 71 years, 72 years, 73 years, 74 years, 75 years, 76 years, 77 years, 78 years, 79 years, 80 years, 81 years, 82 years, 83 years, 84 years, 85 years and older; Gender: Female (2); Diagnosis Selection: Foreign Body (56);
```




This R package called `NEISS` only goes up to 2017 for data so I did not use it.  Cool idea though.  
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

## Results
Over the 10‐year period from 2010 to 2020, there were an estimated 540,860 ED visits for retained foreign body, and 27,580 (2,758 * 10) (5.1%) ED visits were related to female pelvic injuries as estimated using our sample size of 436 patients. Of the 436 visits for foreign body in the female pelvis that were analyzed, 570 (92.8%) visits involved patients who were discharged after ED treatment or examination. Twenty‐nine (4.7%) patients were admitted to the hospital; 1.0% were transferred to another facility; 1.0% left the ED against medical advice; and 0.4% were held for observation. Overall (Fig. 1) incidence of injury and anatomic site‐specific (Fig. 2) incidence of injury fluctuated during the time period studied. Upon analysis of injuries by anatomic site, a plurality of visits (34.2%) was due to injuries to the nose. The face (excluding nose) and ears were the next most common sites of injury (Fig. 3). Patients with nose‐related injuries were younger (median: 3 years of age; interquartile range: 3–4 years) than individuals presenting for injuries in other anatomic sites (P < 0.0001) (Fig. 3). The vast majority of primary diagnoses in the nose and ear were “foreign bodies” (97.1% and 93.0%, respectively)— significantly higher proportions than the incidence of foreign bodies in the other anatomic sites assessed in our analysis (P values both <0.0005) (Fig. 3). Diagnoses differed by anatomic site; for example, two‐thirds of mouth injuries were related to burns, whereas the most common injuries in the face (excluding the nose) and head were lacerations (Fig. 3). Among patients sustaining head lacerations, assault (patients either directly struck by battery or had battery thrown at them) and having a battery fall on their head were the most frequent mechanisms of injury (48.5% and 22.9%, respectively). Among facial lacerations, assault and being struck by falling batteries were also the most common mechanisms of injury (21.2% and 19.2%, respectively).


Other ideas:

Sports injuries to the pubic region:

NEISS_55917.zip
```r
NEISS Query Results

National Estimate of Injuries Treated in Emergency Departments
Treatment Dates: 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019

National Estimate
73,978
Suggested Citation: Consumer Product Safety Commission. National Electronic Injury Surveillance System 2000-2019 on NEISS Online Database, released April, 2020. Generated at https://www.cpsc.gov/cgibin/NEISSQuery/home.aspx. on: August 18, 2020 at 14:48:49
 
Prior to 2019, each NEISS record allowed a maximum of one diagnosis, one body part, and two product codes. In 2019 the NEISS began collecting up to two diagnoses and body parts, and three product codes per record. As a result, a NEISS record may be counted multiple times in producing national injury estimates and calculating variability of those estimates. A single record may be counted in up to three product groups, product sub-groups, or individual product codes. Likewise, an individual NEISS record may be counted in up to two different diagnosis/body part combinations.

User Selected On: Most Recent 10 Years (2010 - 2019); Product Selection: SPORTS AND RECREATION EQUIPMENT: AMUSEMENT ATTRACTIONS (INCL. RIDES), ARCHERY, ATV'S, MOPEDS, MINIBIKES, ETC., BARBECUE GRILLS, STOVES, EQUIPMENT, BASEBALL/SOFTBALL, BASKETBALL, BEACH, PICNIC, CAMPING EQUIPMENT, BICYCLES & ACCESSORIES, BILLIARDS OR POOL, BOWLING, BOXING, CURLING (ACTIVITY, ETC.), DARTS, EXERCISE & EQUIPMENT, FENCING, FISHING, FOOTBALL, GOLF, HOCKEY, ALL KINDS, HORSEBACK RIDING ACTIVITY, EQUIP, HORSESHOES, ICE OR SNOW BOATING, LACROSSE, RUGBY, MISC. BALL GAMES, MARTIAL ARTS, MISCELLANEOUS SPORTS, MOUNTAIN CLIMBING, NONPOWDER GUNS, BBS & PELLETS, PLAYGROUND EQUIPMENT, RACQUET SPORTS, SHUFFLEBOARD, SKATEBOARDS, SKATING, ALL KINDS, SNOWMOBILES, SNOWSKIING, SOCCER, SWIMMING ACTIVITY, POOLS, EQUIPMENT, TOBOGGANS, SLEDS, SNOW DISCS, ETC., TRACK & FIELD ACTIVITIES, EQUIPMENT, TRAMPOLINES, UNICYCLES, VOLLEYBALL, WAGONS, OTHER RIDEON TOYS, WATER SKIING, TUBING, SURFING; Gender: Female (2); Body Part Selection: Pubic Region (38);
```


