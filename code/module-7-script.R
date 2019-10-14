########################################################################################
# Summary: Module 7 - Working with factors and dates
# Date: October 2, 2019
########################################################################################

# Factors ----
# Load packages
library(tidyverse)

# Example tibble
d <- tibble(wkdays = c("MON", "TUES", "WED", "THURS", "FRI"),
            values = c(1, 3, 3.5, 4, 7))

d
#plot data, will be plotted in alphabetical order ... not very desirable for wkdays
ggplot(d, mapping=aes(x=wkdays, y=values))+ 
  geom_bar(stat = "identity")


#create a factor to change order info is presented in plot
d$wkdays <- factor(d$wkdays, levels = c("MON", "TUES", "WED", "THURS", "FRI", "SAT", "SUN") )
ggplot(d, mapping=aes(x=wkdays, y=values))+ 
  geom_bar(stat = "identity")

#change the way the levels are written out using fct_recode
d %>%
  mutate(wkdays_recode=fct_recode(wkdays, 
                                  "Monday" = "MON", "Tuesday" = "TUES")) -> d

d
ggplot(d, mapping=aes(x=wkdays_recode, y=values))+ 
  geom_bar(stat = "identity")

#change numeric vector to factor vector
factor(d$values)
#
# Dates and times ----
# Load packages
library(tidyverse)
library(lubridate)

# Example tibble
z <- tibble(date1 = c("12/01/2012", "12/02/2012", "12/03/2012"),
            date2 = c("2012/01/12", "2012/02/12", "2012/03/12"),
            date3 = c("01 Dec 2012", "02 Dec 2012", "03 Dec 2012"))


z

#parse first column in z
z$date1 <- mdy(z$date1)
z  

#third column
z$date3 <- dmy(z$date3)
z


#extract date elements
z %>%
  mutate(month = month(date3), year = year(date3), day= day(date3)) %>%
  unite("new_date", year, month, day, sep = "-", remove =F) %>%
  mutate(new_date_parsed = ymd(new_date)) %>%
# adding a day to monthly data
  mutate(day_fake = 1) %>%
  unite("new_date", year, month, day_fake, sep = "-", remove =F)
