# Set libPaths.
.libPaths("/Users/tylermuffly/.exploratory/R/4.0")

# Load required packages.
library(tis)
library(arsenal)
library(tableone)
library(janitor)
library(lubridate)
library(hms)
library(tidyr)
library(stringr)
library(readr)
library(forcats)
library(RcppRoll)
library(dplyr)
library(tibble)
library(bit64)
library(exploratory)
library(dplyr)

# Steps to produce disposition
`disposition` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/disposition.xlsx", sheet = "Sheet1", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  dplyr::mutate(disposition_description = `Treated and released, or examined and released without treatment 1`) %>%
  dplyr::rename(disposition_code = `Treated and released, or examined and released without treatment 1`) %>%
  dplyr::mutate_at(vars(everything()), funs(factor)) %>%
  dplyr::mutate(disposition_code = word(disposition_code, -1, sep = "\\s+")) %>%
  dplyr::mutate(disposition_description = recode(disposition_description, "Treated and transferred to another hospital 2" = "Treated and transferred to another hospital", "Treated and admitted for hospitalization (within same facility) 4" = "Treated and admitted for hospitalization (within same facility)", "Held for observation (includes admitted for observation) 5" = "Held for observation (includes admitted for observation)", "Left without being seen/Left against medical advice 6" = "Left without being seen/Left against medical advice", "Fatality, including DOA, died in the ED 8" = "Fatality, including DOA, died in the ED"))

# Steps to produce locale_of_accident
`locale_of_accident` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/locale of accident.xlsx", sheet = "Sheet1", na = c('','NA'), skip=0, col_names=FALSE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  dplyr::rename(Codes_Locale_Description = ...1, Locale_Description = ...2) %>%
  dplyr::mutate_at(vars(everything()), funs(factor))

# Steps to produce NEISSDiagnosisCodes
`NEISSDiagnosisCodes` <- exploratory::select_columns(exploratory::clean_data_frame(exploratory::read_delim_file("/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISSDiagnosisCodes.csv" , ",", quote = "\"", skip = 0 , col_names = FALSE , na = c('','NA') , locale=readr::locale(encoding = "UTF-8", decimal_mark = ".", tz = "America/Denver", grouping_mark = "," ), trim_ws = TRUE , progress = FALSE)),"X1","X2") %>%
  readr::type_convert() %>%
  dplyr::rename(Diagnosis = X1, Diagnosis_Code = X2) %>%
  dplyr::mutate(Diagnosis = str_remove_all(Diagnosis, "[^a-zA-Z]+")) %>%
  dplyr::mutate(Diagnosis = recode(Diagnosis, "DermatitisConjunctivitis" = "Dermatitis", "ElectricShock" = "Electric Shock", "ForeignBody" = "Foreign Body", "IngestedForeignObject" = "Ingested Foreign Object", "InternalOrganInjury" = "Internal Organ Injury", "NerveDamage" = "Nerve Damage", "StrainorSprain" = "Strain or Sprain", "SubmersionincludingDrowning" = "Submersion including Drowning", "OtherNotStated" = "Other")) %>%
  dplyr::mutate_at(vars(everything()), funs(factor))

# Steps to produce products_NEISS
`products_NEISS` <- exploratory::read_delim_file("/Users/tylermuffly/Dropbox (Personal)/products_NEISS.csv" , ",", quote = "\"", skip = 0 , col_names = TRUE , na = c('','NA') , locale=readr::locale(encoding = "UTF-8", decimal_mark = ".", tz = "America/Denver", grouping_mark = "," ), trim_ws = TRUE , progress = FALSE) %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  dplyr::select(-X1) %>%
  dplyr::mutate(code = factor(code)) %>%
  dplyr::rename(products_description = title, products_code = code)

# Steps to produce Body_Part
`Body_Part` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/My Mac (MacBook Pro)/Downloads/All sports injuries to pubic area/NEISS_FMT.XLSX", sheet = "NEISS_FMT", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  filter(`Format name` == "BDYPT") %>%
  select(-`Format name`, -`Ending value for format`) %>%
  mutate(`Format value label` = str_extract_all(`Format value label`, "[a-zA-Z]+")) %>%
  mutate(`Format value label` = list_to_text(`Format value label`), `Format value label` = str_to_title(`Format value label`)) %>%
  rename(BodyPartCode = `Starting value for format`, BodyPart_Text = `Format value label`) %>%
  mutate_at(vars(everything()), funs(factor))

# Steps to produce NEISS_2019_1
`NEISS_2019_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2019.XLSX", sheet = "NEISS_2019", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2018_1
`NEISS_2018_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2018.XLSX", sheet = "NEISS_2018", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2017_1
`NEISS_2017_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2017.XLSX", sheet = "NEISS_2017", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2016_1
`NEISS_2016_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2016.XLSX", sheet = "NEISS_2016", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2015_1
`NEISS_2015_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2015.XLSX", sheet = "NEISS_2015", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2014_1
`NEISS_2014_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2014.XLSX", sheet = "NEISS_2014", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2013_1
`NEISS_2013_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2013.XLSX", sheet = "NEISS_2013", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2012_1
`NEISS_2012_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2012.XLSX", sheet = "NEISS_2012", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce NEISS_2011_1
`NEISS_2011_1` <- exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2011.XLSX", sheet = "NEISS_2011", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()

# Steps to produce branching_point_1
`branching_point_1` <- 
  # United States Consumer Product Safety Commission. National Electronic Injury Surveillance System. http://www.cpsc.gov/en/Research–Statistics/NEISS‐Injury‐Data/. Accessed August 16, 2020. The National Electronic Injury Surveillance System (NEISS) was accessed from the Consumer Product Safety Commission's Web site and used for the collection of data. This resource has proven invaluable in myriad prior analyses evaluating nationwide trends occurring in emergency medicine.4-7 Briefly, this database collects data from 100 participating hospital EDs, which is used to derive a stratified probability sample of visits to the approximately 5,000 EDs nationwide that have at least six beds and are open 24 hours a day, 7 days a week.8-10 From these figures, the NEISS creates annual estimates of each type of injury.9 This resource allows one to search for injuries organized by several general diagnoses, specific consumer products, and patient demographics. Additionally, a one‐ to two‐phrase narrative that describes other aspects of the patient visit is included for many cases.
  exploratory::read_excel_file( "/Users/tylermuffly/Dropbox (Personal)/Trauma/NEISS_2010.XLSX", sheet = "NEISS_2010", na = c('','NA'), skip=0, col_names=TRUE, trim_ws=TRUE, tzone='America/Denver') %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  bind_rows(NEISS_2011_1, NEISS_2012_1, NEISS_2013_1, NEISS_2014_1, NEISS_2015_1, NEISS_2016_1, NEISS_2017_1, NEISS_2018_1, NEISS_2019_1, id_column_name = "ID", current_df_name = "NEISS_2010_1", force_data_type = TRUE) %>%
  select(-CPSC_Case_Number, -Sex, -`Hispanic Origin`, -Body_Part, -Other_Diagnosis, -Fire_Involvement) %>%
  mutate(Race = recode(Race, `2` = "Black", `0` = "NA", `1` = "White", `4` = "Asian", `3` = "Other")) %>%
  mutate(Race = na_if(Race, "NA")) %>%
  mutate_at(vars(Age, Race, Other_Race, Diagnosis, Body_Part_2, Diagnosis_2, Other_Diagnosis_2, Disposition, Location, `Alcohol involved`, `Drug involved`, Product_1, Product_2, Product_3, Stratum), funs(factor)) %>%
  left_join(Body_Part, by = c("Body_Part_2" = "BodyPartCode")) %>%
  select(-Body_Part_2) %>%
  left_join(products_NEISS, by = c("Product_1" = "products_code")) %>%
  left_join(products_NEISS, by = c("Product_2" = "products_code")) %>%
  left_join(products_NEISS, by = c("Product_3" = "products_code")) %>%
  select(-Product_1, -Product_2, -Product_3) %>%
  mutate(Age = parse_number(Age)) %>%
  filter(Age >= 16) %>%
  filter(Age < 100) %>%
  mutate(ID = word(ID, 2, sep = "\\s*\\_\\s*")) %>%
  mutate(ID = factor(ID)) %>%
  select(-Other_Race) %>%
  left_join(NEISSDiagnosisCodes, by = c("Diagnosis" = "Diagnosis_Code")) %>%
  left_join(NEISSDiagnosisCodes, by = c("Diagnosis_2" = "Diagnosis_Code")) %>%
  rename(Diagnosis1 = Diagnosis.y, Diagnosis2 = Diagnosis.y.y) %>%
  mutate(`Alcohol involved` = impute_na(`Alcohol involved`, type = "value", val = "0"), `Drug involved` = impute_na(`Drug involved`, type = "value", val = "0")) %>%
  left_join(locale_of_accident, by = c("Location" = "Codes_Locale_Description")) %>%
  select(-Location) %>%
  left_join(disposition, by = c("Disposition" = "disposition_code")) %>%
  mutate(Locale_Description = na_if(Locale_Description, "Not recorded")) %>%
  mutate(Treatment_Date_month = month(Treatment_Date, label = TRUE, abbr = FALSE), Treatment_Date_wday = wday(Treatment_Date, label = TRUE, abbr = FALSE)) %>%
  filter((is.na(Narrative) | Narrative != "47 YOF INJURED LIP WITH BB GUN LAST NIGHT. DX-SUPERIOR ORAL LABIAORAL FOREIGN BODY")) %>%
  mutate(Treatment_Date_month = recode(Treatment_Date_month, "March" = "Spring", "April" = "Spring", "May" = "Spring", "June" = "Summer", "July" = "Summer", "August" = "Summer", "September" = "Fall", "October" = "Fall", "November" = "Fall", "December" = "Winter", "January" = "Winter", "February" = "Winter")) %>%
  mutate(products_description.x = str_remove(products_description.x, regex(", not specified$", ignore_case = TRUE)), products_description.x = str_remove(products_description.x, regex(", not elsewhere classified", ignore_case = TRUE))) %>%
  mutate(products_description.x = str_remove(products_description.x, regex(", other or not specificed$", ignore_case = TRUE))) %>%
  mutate(products_description.x = str_to_title(products_description.x)) %>%
  select(-Diagnosis.x, -Diagnosis_2, -Other_Diagnosis_2, -Disposition, -Stratum, -PSU, -Weight)

# Steps to produce pregnant
`pregnant` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("pregnan", ignore_case=TRUE)))

# Steps to produce rectum
`rectum` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("rectum", ignore_case=TRUE)))

# Steps to produce bladder
`bladder` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("bladder", ignore_case=TRUE)))

# Steps to produce clitoris
`clitoris` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("clitor", ignore_case=TRUE)))

# Steps to produce vagina
`vagina` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("vagina", ignore_case=TRUE)))

# Steps to produce uterus
`uterus` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("uterus", ignore_case=TRUE)))

# Steps to produce perineum
`perineum` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("perineum", ignore_case=TRUE)))

# Steps to produce ovary
`ovary` <- `branching_point_1` %>%
  filter(str_detect(Narrative, regex("ovar", ignore_case=TRUE)))

# Steps to produce the output
`branching_point_1` %>%
  
  # We were able to search for injuries with the anatomic designations including “bladder,” “clitoris,” “labia,” “ovary,” "perineum,"  "rectum," "uterus," and “vagina. ” We excluded pregnant women with injuries in this analysis.
  filter(str_detect(Narrative, regex("labia", ignore_case=TRUE))) %>%
  bind_rows(ovary, perineum, uterus, vagina, clitoris, bladder, rectum, pregnant, id_column_name = "ID", current_df_name = "everyone_labia", force_data_type = TRUE) %>%
  
  # Remove pregnant women
  filter((is.na(ID.new) | ID.new != "pregnant")) %>%
  distinct(Narrative, .keep_all = TRUE) %>%
  rename(`Anatomy injured` = ID.new) %>%
  mutate(`Anatomy injured` = recode(`Anatomy injured`, "everyone_labia" = "labia")) %>%
  mutate_at(vars(ID, Race, `Alcohol involved`, `Drug involved`, BodyPart_Text, products_description.x, products_description.y, products_description, Diagnosis1, Diagnosis2, Locale_Description, disposition_description), funs(factor)) %>%
  rename(Year_of_injury = ID, products_description1 = products_description.x, products_description2 = products_description.y, products_description3 = products_description) %>%
  mutate(products_description1 = recode(products_description1, "nonelectric razors or shavers" = "razors or shavers", "razors or shavers, not specified" = "razors or shavers", "electric razors or shavers" = "razors or shavers")) %>%
  filter(Diagnosis1 == "Foreign Body") %>%
  mutate(Age = as.integer(Age)) %>%
  filter(`Anatomy injured` %in% c("vagina", "rectum", "bladder")) %>%
  mutate(Treatment_Date_wday = fct_relevel(Treatment_Date_wday, "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")) %>%
  select(-BodyPart_Text, -Diagnosis2) %>%
  mutate(Holiday = tis::isHoliday(Treatment_Date, goodFriday = FALSE, board = TRUE), Holiday = factor(Holiday)) %>%
  mutate_at(vars(`Anatomy injured`, Treatment_Date_month), funs(factor)) %>%
  filter((is.na(`Anatomy injured`) | `Anatomy injured` != "bladder"))