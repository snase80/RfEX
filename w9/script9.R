library(tidyverse)

econ = readxl::read_xlsx("w4/data/econmap.xlsx", 1)

# HISTOGRAM ---------------------------------------------------------------
econ %>%
    filter(name == "Azerbaijan") %>% 
    pull(population) %>% 
    hist()

econ %>%
    filter(name == "Azerbaijan") %>% 
    pull(gdp_cap) %>% 
    hist(population = 25)

# BOXPLOT -----------------------------------------------------------------
econ %>%
    filter(name == "Azerbaijan") %>% 
    pull(population) %>% 
    boxplot()

# a little fun with vectorisation
# prepare the plotting function
pop_box = function(x) {
    boxplot(x$population)
    title(unique(x$name))
}

# number of plots and organisation
length(unique(econ$name))
par(mfrow = c(4,3))

# vectorise
econ %>% 
    select(name, population) %>% 
    split(.$name) %>% 
    walk(.,pop_box)

par(mfrow = c(1,1))

# SCATTER PLOT ------------------------------------------------------------
econ %>% 
    filter(name == "Bangladesh") %>% 
    {plot(x = .$year, y = .$gdp_05)}

econ %>% 
    filter(name == "Bangladesh") %>% 
    {plot(x = .$year, y = .$gdp_05, type = "l")}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### GGPLOT2 ###########
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(ggplot2)

econ %>% 
    ggplot(aes(x = year, y = population, color = name)) +
    geom_line() +
    geom_point(size = 1)

# BAD
econ %>% 
    filter(name == "Afghanistan", year < 2018) %>% 
    
    ggplot(aes(year, population)) + 
    geom_line() +
    geom_line(aes(y = gdp_05))

# UGLY
econ %>% 
    filter(name == "Afghanistan", year < 2018) %>% 
    select(name, year, population, gdp_05) %>% 
    gather("metric", "value", population:gdp_05) %>% 
    
    ggplot(aes(year, value, color = metric)) + 
    geom_line()

econ %>% 
    filter(name == "Afghanistan", year < 2018) %>% 
    
    ggplot(aes(year, gdp_05)) + 
    geom_line()

# GOOD
econ %>% 
    filter(name == "Afghanistan", year < 2018) %>% 
    select(name, year, population, gdp_05) %>% 
    gather("metric", "value", population:gdp_05) %>% 
    group_by(metric) %>% 
    mutate(value = value/mean(value)) %>% 
    
    ggplot(aes(year, value, color = metric)) + 
    geom_line()


