#get started -----
#Will be using dyplyr

#First load data ----
library(tidyverse)

gapminder_data <- read_csv("data/gapminder_data.csv")

#An introduction to data analysis in R using dplyr ----
#  Get stats quickly using sumarize () ----

#To get the mean life expectancy: 
summarize(gapminder_data, avgerageLifeExp = mean(lifeExp))

#Can use the pipe operator  %>% to make it more legible: 
gapminder_data %>% summarize(averageLifeExp = mean(lifeExp))

# Can save data frame by assigning it into a varible. 

gapminder_data_summarized <- gapminder_data %>%
  summarize(averageLifeExp = mean(lifeExp))

#Narrow down rows with filter() ----
#usually low. Ther are many different years and countries 
#So it may not make sense to average over all of them 

help.search("arithmetic", package = "base")

gapminder_data %>% summarize (year_range = base::range(year))

#Found our most recent year is 2007 

# Now we can subset to the most recent year using filter():

gapminder_data %>%
  filter(year == 2007) %>%
  summarize(average = mean(lifeExp))

gapminder_data %>%
  filter(year == 1952) %>%
  summarize(aGDP = mean(gdpPercap))

# answer to quiz for finding average GDP per capita for the first year ----

gapminder_data %>%
  summarize (first_year = min(year))

#more robust way to find the average GDP per capita 
gapminder_data %>%
  filter (year == min(year)) %>%
  summarize(averageGDP = mean(gdpPercap))

#How do we calculate the average life expectancy for each year? 
#Instead of using many filter() statements, we can use group_by()

gapminder_data %>%
  group_by(year) %>%
  summarize(average = mean (lifeExp))

#group_by() expects one or more column names separated by commas.

gapminder_data %>%
  group_by (continent)%>%
  summarize(average= mean(lifeExp)) %>%
  filter(continent == "Africa")

#You can create more than one column with summarize: 
gapminder_data %>%
    group_by (continent) %>%
    summarize (average = mean(lifeExp),
                min = min(lifeExp))
#Make new variables with mutate() ----

#When we use summarize(), we reduced the number of rows in our data.
#But sometimes we want to create a new column and keep the same
# number of rows. We create these new columns with mutate ():

gapminder_data %>%
  mutate(gdp = pop *gdpPercap)

#We added a new column gdp to the data with the new name and 
# an equal sign similar to summarize

gapminder_data %>%
  group_by(country) %>%
  mutate (popAf = pop /1000000) %>%
  filter ( country == "Afghanistan", year == 1972)

#Note you can also use the scientific notation 1e6

#Allows us to choose a subset of columns. 
gapminder_data %>%
  select (pop, year)
#Can also do the inverse, where we keep all columns except
#for those we remove with a minus sign. 
gapminder_data %>%
  select (-continent)

#Another example/quiz for use of select
gapminder_data %>%
  select(year, starts_with("c"))

gapminder_data %>%
  select(ends_with("p"))

#Changing the shame of data using tidyr ----

#Create some "untidy" data with years and life expectancy: 

gapminder_data %>%
  select (country, continent, year, lifeExp) %>%
  pivot_wider(names_from = year, values_from =  lifeExp)

# Perpare the Americas 2007 gapminder dataset ----

gapminder_data_2007 <- read_csv("data/gapminder_data.csv") %>%
  filter(year == 2007 & continent == "Americas") %>%
  select(-year, -continent)

#clean up data ----

co2_emissions_dirty <- read_csv("data/co2-un-data.csv"), skip = 2,
      col_names = c("region", "country", "year", "series", "value",
                    "footnotes", "source")

# here is the correct code for the datadata 
co2_emissions_dirty <- read_csv("data/co2-un-data.csv", skip=2,
                                col_names=c("region", "country", "year", "series", 
                                            "value", "footnotes", "source"))

#Shorten series variables Emissions (...) and Emissions per capita (...) 

co2_emissions_dirty %>%
  mutate(series = recode(series, 
                         "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>%
  pivot_wider(names_from = series, 
              values_from = value) %>%
  #count(year) 
  
  filter( year ==2005, country == "United States") %>%
  select (-year)
