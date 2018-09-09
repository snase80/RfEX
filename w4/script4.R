library(tidyverse)


# ORIENTATION -------------------------------------------------------------
getwd()
list.files("w4/data")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
############ IMPORT #############
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# CSV ------------------------------------------------------------------
# csv = comma separated values
# a simple flatfile:
#       columns separated by comma ','
#       decimals separated by dot '.'
#       rows separated by newline '\n'
# fied description (colnames) non-mandatory
csv = read_csv("w4/data/london_2014-05.csv")
head(csv)

# A special sub-type is CSV saved from Slav version of Excel (yes, Excel hates you)
# looks like csv, but has different separators:
#       columns separated by semicolon ';'
#       decimals separated by comma ','
csv2 = read_csv("w4/data/london_2014-05.csv2")
head(csv2)


# XLS ---------------------------------------------------------------------
# Excel based binary files
# widely used everywhere
# tabular content
library(readxl)
xls = read_excel("w4/data/econmap.xlsx", sheet = 1)
head(xls)


# JSON ---------------------------------------------------------------------
library(jsonlite)
json = read_file("w4/data/fiscal2017.json")
json = fromJSON(json)


# ANY TABULAR FLATFILE ----------------------------------------------------
# any flatfile with rigid separators
del = read_delim("w4/data/london_2014-05.tsv", delim = "\t")


# RDATA / RDS -------------------------------------------------------------------
# saving R objects (whatever in your Environment)
# good for saving models and other special (non-tabular) data
load("w4/data/london.RData") # no assignment, dangerous!
rds = readRDS("w4/data/london.RDS")


# DATASETS ----------------------------------------------------------------
# london_2014-05       https://toolbox.google.com/datasetsearch/search?query=econometrics%20csv&docid=2U0qJW26x%2B%2BMJDVlAAAAAA%3D%3D
# econmap              https://toolbox.google.com/datasetsearch/search?query=econometrics%20xlsx&docid=LY85I4W1qT8Xe8L9AAAAAA%3D%3D
# fiscal2017           https://toolbox.google.com/datasetsearch/search?query=economics%20json&docid=QU9%2F0grLqAZqGRCGAAAAAA%3D%3D


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
############ EXPORT #############
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# CSV ---------------------------------------------------------------------
write_csv(csv, "w4/data/london_2014-05.csv")


# JSON --------------------------------------------------------------------
write_json(json, "w4/data/fiscal2017.json")


# RDATA / RDS -------------------------------------------------------------
save(rdata, file = "w4/data/london.RData")
saveRDS(rds, file = "w4/data/london.RDS")

# XLS
library(writexl)
write_xlsx(xls, "w4/data/econmap.xlsx")
