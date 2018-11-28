# Dear students,
# Good luck with your test. Don't forget to save frequently.
# You can push as many versions as you like.
# Only the last version, or the version with commit message
#  containing "final submission" will be graded.
# 
# Task 0:
# Please write your name bellow.

# Task 1:
# 1.) Read the csv files from data folder (load any appropriate library).
#     If unable to load the data, use the following command: load("data/loaded.RData")
# 2.) Check and change the column format where appropriate.
library(tidyverse)
prod = read_csv("data/products.csv")
sales = read_csv2("data/sales.csv")

sales$id %>% class()
sales$id %<>% as.character()

# Task 2:
# 1.) In products file, you have columns:
#           - size (how many in liters are in the package),
#           - package (how many bottles are in the package).
#     Add a new column, called "unit_size", describing the size of the bottle in liters 
# 2.) In sales file, aggregate on "id" level (save as different variable, e.g. aggregated):
#           - total sales
#           - average sales
#           - median sales
prod = prod %>% mutate(unit_size = size/package)
agg =
    sales %>% 
    group_by(id) %>% 
    summarise(total = sum(sales),
           avg = mean(sales),
           med = median(sum(sales)))

# Task 3
# 1.) Join both (products and aggregated) datasets into one (e.g. joined).
# 2.) Gather the joined dataset, putting all sales statistics into one column.
joined = left_join(prod, agg, by = "id")
gather(joined, "fact", "value", total:med) %>% View()

# Task 4
# 1.) From the original sales dataset (non-aggregated), summarise the sales as
#     mean for each product and period. (e.g. weekly)
# 2.) Define a function, that takes productid as input and produces a
#     R-squared metric of a simple linear model, that regresses
#     sales (y) on period (x) using weekly dataset
# 3.) Vectorise the function across the weekly dataset.
sales %>% 
    group_by(id, period) %>% 
    summarise(mean = mean(sales)) %>% 
    ungroup()

regres = function(ID) {
    cache = sales %>% filter(id == ID)
    
    lm(sales~period,cache) %>% 
        summary() %>% 
        {.$r.squared}
}

map_dbl(unique(sales$id), regres)

# Task 5
# Prepare a script to write out a csv file containing weekly sales for each store.
# (vectorise a write_csv function over the stores)

sales %>% 
    split(.$store) %>% 
    map(.x =., ~write_csv(.x, paste0("data/sales_store",.x$store[1],".csv")))


#################################################################################################
# That is all for today. After you are finished, please save this file, stash, commit and push. #
#################################################################################################
