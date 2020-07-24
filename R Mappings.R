library(haven)
library(ggplot2)
library(devtools)
#Uncomment and run the package installation, if you don't have it
#install_github("arilamstein/choroplethrZip@v1.3.0")
library(choroplethrZip)

library(choroplethr)

library(mapproj)
library(ggplot2)
library(ggmap)
register_google("AIzaSyBbntU95lnSq9Q749iEKnpVauaB_28gUaE")
data(df_pop_zip)
data(df_zip_demographics)

zipcode_2005 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode_freqs.sas7bdat", 
                          NULL)
co_zips<-zipcode_freqs
names(co_zips)[names(co_zips) == "ZIP_CD"] <- "region"
names(co_zips)[names(co_zips) == "septcount"] <- "value"
co_zips

View(zipcode_freqs)

data(zip.map)

library(dplyr)
co_zips <- co_zips %>%  
  mutate(region = as.character(region))

ec_states = c("colorado")

zip_choropleth(co_zips, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies - 2005",
               legend     = "Frequency") + coord_map()

zipcode_2019 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode_2019.sas7bdat", 
                         NULL)

zip_choropleth(zipcode_2019, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies - 2020",
               legend     = "Frequency") + coord_map()


zipcode2019_18_49 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode2019_18_49.sas7bdat", 
                         NULL)
zip_choropleth(zipcode2019_18_49, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies - 2020 Ages 18-49",
               legend     = "Frequency") + coord_map()

zipcode2019_50_89 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode2019_50_89.sas7bdat", 
                              NULL)
zip_choropleth(zipcode2019_50_89, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies - 2020 Ages 50-89",
               legend     = "Frequency") + coord_map()

ec_county = c("8031", "8013", "8005", "8001", "8059","8014", "8035")

zip_choropleth(co_zips, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies - 2005",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode_2019, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies - 2020",
               legend     = "Frequency")# + geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode2019_18_49, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies - 2020 Ages 18-49",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode2019_50_89, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies - 2020 Ages 50-89",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
                #+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

#####################################################################################
ec_states = c("colorado")

zipcode_2020 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode2020_120.sas7bdat", 
                         NULL)

zip_choropleth(zipcode_2020, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies Ages 0 to 120 - 2020",
               legend     = "Frequency") + coord_map()


zipcode2020_sub18 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode2020_sub18.sas7bdat", 
                         NULL)
zip_choropleth(zipcode2020_sub18, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies Ages 18 and below - 2020",
               legend     = "Frequency") + coord_map()

zipcode2020_18up <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zipcode2020_18up.sas7bdat", 
                              NULL)
zip_choropleth(zipcode2020_18up, 
               state_zoom = ec_states, 
               title      = "Zip code frequencies Ages 19 and up - 2020",
               legend     = "Frequency") + coord_map()

ec_county = c("8031", "8013", "8005", "8001", "8059","8014", "8035")

zip_choropleth(zipcode_2020, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies Ages 0 to 120 - 2020",
               legend     = "Frequency")# + geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode2020_sub18, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies Ages 18 and below - 2020",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode2020_18up, 
               county_zoom = ec_county, 
               title      = "Zip code frequencies Ages 19 and up - 2020",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")













library(choroplethr)
library(choroplethrZip)
library(R6)
library(RgoogleMaps)
library(ggmap)

############################################################################################
ec_states = c("colorado")

zipcode_ili <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/any_ili_flg.sas7bdat", 
                         NULL)

zip_choropleth(zipcode_ili, 
               state_zoom = ec_states, 
               title      = "Zip code rates*10000 - Any ILI flag",
               legend     = "Frequency", reference_map=TRUE) + coord_map()



zipcode_cov <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/any_covid_flg.sas7bdat", 
                              NULL)
zip_choropleth(zipcode_cov, 
               state_zoom = ec_states, 
               title      = "Zip code rates*10000 - Any COVID flag",
               legend     = "Frequency") + coord_map()

zipcode_ilicov <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/ili_or_covid_flg.sas7bdat", 
                             NULL)
zip_choropleth(zipcode_ilicov, 
               state_zoom = ec_states, 
               title      = "Zip code rates*10000 - ILI or COVID flags",
               legend     = "Frequency",
               reference_map=TRUE) + coord_map()

ec_county = c("8031", "8013", "8005", "8001", "8059","8014", "8035")

zip_choropleth(zipcode_ili, 
               county_zoom = ec_county, 
               title      = "Zip code rates*10000 - Any ILI flag",
               legend     = "Frequency") # + geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode_cov, 
               county_zoom = ec_county, 
               title      = "Zip code rates*10000 - Any COVID flag",
               legend     = "Frequency") #+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")
#+ geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")

zip_choropleth(zipcode_ilicov, 
               county_zoom = ec_county, 
               title      = "Zip code rates*10000 - ILI or COVID flags",
               legend     = "Frequency") + geom_point(aes(x=-105.2705, y=40.0150), size=3, color="black")
#+ geom_point(aes(x=-104.9903, y=39.7392), size=3, color="black")


library(rgdal)
library(maptools)
install.packages("gpclib", type="source")
gpclibPermit()
library(rgeos)
library(tigris)
zipcode_ili_t <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/any_ili_flg_tract.sas7bdat", 
                        NULL)

tract_choropleth(zipcode_ili_t, ec_states, title = "test", legend = "num",
                 num_colors = 7, tract_zoom = NULL, county_zoom = NULL,
                 reference_map = FALSE)



getRversion()
library(devtools)

#######################################################################################
# First attempt at dot map

library(rworldmap)

longlat_dots <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/zip_files/zipcode2020_18up.sas7bdat", 
                             NULL)

newmap <- get_map(resolution = "low")
 plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)



library(ggmap)



Sys.which("gcc.exe")


Sys.which("ls.exe")


Rcpp::evalCpp("2+2")
























