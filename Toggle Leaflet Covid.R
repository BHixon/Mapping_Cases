
#https://rstudio-pubs-static.s3.amazonaws.com/508643_d6cb2a0b10484f40b1bcba052dda28e1.html

library("leaflet")
library("geojson")
library("geojsonio")
library("tigris")
library("tidyverse")
library("haven")
library("dplyr")
library("sp")
library("leaflet.extras")

#imported dataset from SAS that has the rates of all variables at the base, 1000, and 10000 levels
#
rate_calc_0407 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/rate_calc_0407.sas7bdat", 
                           NULL)
long_lat_0407 <- read_sas("M:/2018_Ritzwoller_PROSPR_EX/Study Projects/20200319_Ritzwoller_COVID19/Datasets/long_lat_full_0407.sas7bdat", 
                          NULL)

#subsetting data
any_ili_0407 <- subset(long_lat_0407, any_ili_flg >= 1)

any_cov_0407 <- subset(long_lat_0407, any_covid_flg >= 1)

any_ilicov_0407 <- subset(long_lat_0407, ili_or_covid_flg >= 1)

cov_dx_0407 <- subset(long_lat_0407, covid >= 1)

cov_pot_0407 <- subset(long_lat_0407, covid_potential >= 1)


#ANY_ILI_FLG:   Member has any diagnosis of an Influenza-Like-Illness or symptom as defined by the CDC, VSD.  Also includes "shortness of breath" and "acute respiratory distress".

#ANY_COVID_FLG:  Any diagnosis related to COVID.  May include exposure, under investigation, rule out, or confirmed diagnoses

#ANY_ILI_OR_COVID_FLG:   pretty much what is says - max of the other two flags

#COVID:  "Confirmed Diagnosis" of COVID19

#COVID_POTENTIAL:  Potential Covid - included Person under Investigation, Suspicion of Covid, Exposure.   

# cache zip boundaries that are download via tigris package
options(tigris_use_cache = TRUE)

# get zip boundaries that start with 80
char_zips <- zctas(cb = TRUE, starts_with = "80")

# all colnames to lowercase 
colnames(rate_calc_0407) <- tolower(colnames(rate_calc_0407))

# join zip boundaries and rate data 
char_zips <- geo_join(char_zips, 
                      rate_calc_0407, 
                      by_sp = "GEOID10", 
                      by_df = "zip",
                      how = "left")

# create color palette 
pal1 <- colorNumeric(
  palette = "Greens",
  domain = char_zips@data$ili_rate_10000)

# create labels for zipcodes
labels1 <- 
  paste0(
    "Zip Code: ",
    char_zips@data$GEOID10, "<br/>",
    "ILI Rate: ",
    char_zips@data$ili_rate_10000) %>%
  lapply(htmltools::HTML)

# create color palette 
pal2 <- colorNumeric(
  palette = "Reds",
  domain = char_zips@data$covid_10000)

# create labels for zipcodes
labels2 <- 
  paste0(
    "Zip Code: ",
    char_zips@data$GEOID10, "<br/>",
    "COVID Rate: ",
    char_zips@data$covid_10000) %>%
  lapply(htmltools::HTML)


#############################################################################
map<-leaflet(char_zips) %>%
  # add base map
  addProviderTiles("CartoDB") %>% 
  
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = ~pal1(ili_rate_10000),
              group="ILI Rates",
              highlightOptions = highlightOptions(color = "blue", weight = 2,
              bringToFront = TRUE),label = labels1) %>%
  
  addLegend(pal = pal1, 
            values = ~ili_rate_10000, 
            opacity = 0.7, 
            group="ILI Rates",
            title = htmltools::HTML("Confirmed Influenza-like Illness <br>
                                    diagnoses from 3/16-4/07/2020 <br>
                                    in the Denver Metro Area <br>
                                    counties per 10000 people"),
            position = "bottomleft")%>%
  
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
            opacity = 1.0, fillOpacity = 0.5,
            fillColor = ~pal2(covid_10000),
            group="COVID Rates",popup=~low_cnt_flg,
            highlightOptions = highlightOptions(color = "green", weight = 2,
            bringToFront = TRUE),label = labels2)%>%
  
  addLegend(pal = pal2, 
            values = ~covid_10000, 
            opacity = 0.7, 
            group="COVID Rates",
            title = htmltools::HTML("Confirmed Covid Diagnoses <br>
                                    from 3/16-4/07/2020 in the <br>
                                    Denver Metro Area counties <br>
                                    per 10000 people"),
            position = "bottomleft")%>%
 
  addCircles(data =cov_dx_0407, weight = 1,color = "black",
             group="COVID Points") %>%
  
  addLegend("bottomright", colors= "black",
            labels="COVID Dx",
            group="COVID Points",
            title = htmltools::HTML("Confirmed COVID Diagnosis <br>
                                    Last known Address <br>
                                    INTERNAL USE ONLY"))%>%
              
  addHeatmap(data =cov_dx_0407,group="Heat", 
             lng=~long, lat=~lat, max=.6, blur = 60) %>%

  # Layers control
  addLayersControl(
    overlayGroups = c("ILI Rates", "COVID Rates", "COVID Points", "Heat"),
    options = layersControlOptions(collapsed = FALSE))%>% 
  
  hideGroup("COVID Rates") %>%
  hideGroup("COVID Points") %>%
  hideGroup("Heat")

map %>% clearGroup("zones") %>% removeControl("zonesLegend")
map
