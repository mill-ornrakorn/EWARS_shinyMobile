# contact: sewemaquins@gmail.com
# print("GetDataFromGoogledrive_func....")
#profvis({
  #Sys.sleep(1)

library(curl)
# https://drive.google.com/file/d/1KuBU_pGwnWW2VxuVD445gQMZZ-wS2a0g/view?usp=sharing

# # rain data ที่จากกรมอุตุ
# id <- "1KuBU_pGwnWW2VxuVD445gQMZZ-wS2a0g"
# sURL <- sprintf("https://docs.google.com/uc?id=%s&export=download", id)
# con <- curl::curl(sURL)


# EWARS Demo data
# https://docs.google.com/spreadsheets/d/e/2PACX-1vQOl9HH22Gq1IKmA0Tgj40uZ4V3sVmkyI7FCSmnBF_-cbQqbVZWE31bBYIyxVjGwA/pubhtml

# id <- "2PACX-1vQOl9HH22Gq1IKmA0Tgj40uZ4V3sVmkyI7FCSmnBF_-cbQqbVZWE31bBYIyxVjGwA"
# sURL <- sprintf("https://docs.google.com/spreadsheets/d/e/%s/pub?output=csv", id)
# con <- curl::curl(sURL)
# mydata <- read.csv(con)

# print(mydata)

# print("Success __ GetDataFromGoogledrive_func....")
