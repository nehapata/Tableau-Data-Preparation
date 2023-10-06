
library(tidyverse)

library(janitor)

terror <- read.csv("globalterrorismdb_0718dist.tar.bz2")

colnames(terror)

head(terror)

summary(terror$iyear)
summary(terror$imonth)
str(terror$iyear)

global_terrorism <- terror %>%
  distinct() %>%
  select(eventid, iyear, imonth, iday, region_txt, country_txt, city, latitude,
         longitude, attacktype1_txt, targtype1_txt,  nkill) %>%
  filter(imonth != 0, iday != 0) %>%
  rename("region" = "region_txt", "country" = "country_txt", "attack_type" = "attacktype1_txt",
         "target" = "targtype1_txt",  "people_killed" = "nkill") %>%
  unite("date", c("imonth", "iday", "iyear"), sep = "/") %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y")) %>%
  arrange(date) %>%
  clean_names() %>%
  drop_na()

head(global_terrorism)


str(global_terrorism)

write.csv(global_terrorism, "C:\\Users\\nisha\\Desktop\\DA Projects\\Tableau Projects Data\\terrorism.csv", row.names = FALSE)