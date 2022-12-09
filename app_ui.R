# Define UI
library("shiny")
library("dplyr")
library("plotly")
library(shinythemes)
source("app_server.R")

introduction_page <- tabPanel(
  "Introduction",
  img(src = "https://atlas-scientific.com/files/CO2-blog-img-122221.jpg", height = 250, width = "100%"),
  h1(strong("CO2 Emissions")),
  h3("Overview"),
  p("CO2 emissions have been a huge factor in todays day and age, but who's making the most CO2 emissions? When looking at the data theres no surprise that China, The US, and India are all big factors in CO2 emissions. With that said, two questions I will answer is how much CO2 is each county putting out in 2022, and what percentage of the world CO2 is it in 2022. My graph will have every country that has released CO2, so a lot, and there CO2 trend over many many years."),
  h3("World"),
  p("The world as a whole have released this much CO2 in 2022"),
  p(RecentWorld, "CO2 in million tonnes"),
  h3("United States"),
  p("The United States has released this much CO2 in 2022"), 
  p(RecentUS, "CO2 in million tonnes"),
  p("With the percentage of its part in world CO2 emission being"), 
  p(PercentUS, "%"),
  h3("China"),
  p("China has released this much CO2 in 2022"),
  p(RecentChina, "CO2 in million tonnes"),
  p("With the percentage of its part in world CO2 emission being"), 
  p(PercentChina, "%"),
  h3("India"),
  p("India has released this much CO2 in 2022"), 
  p(RecentIndia, "CO2 in million tonnes"),
  p("With the percentage of its part in world CO2 emission being"),
  p(PercentIndia, "%"),

)

page2 <- tabPanel(
  "Carbone Dioxide Emissions", 
  h1(strong("CO2 Emissions by Country")),
  p("Select country(s) and timeframe to see the CO2 Emissions"),
  img(), 
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        inputId = "country", 
        label = "Select Country(s)", 
        choices = c("ZWE","ZAF","YEM","WSM","VNM","VIR","VEN","VCT","UZB","USA","URY","UKR","UGA","TZA","TWN","TUV","TUN","TTO","TON","TLS","TKM","THA","TCA","SYR","SXM","SWZ","SWE","SVK","SUR","SSD","SRB","SPM","SOM","SLV","SLE","SLB","SJM","SGP","EN","SAU","RWA","RUS","REU","QAT","PSE","PRY","PRT","PRK","PRI","POL","PNG","PER","PAN","PAK","NZL","NPL","NOR","NGA","NER","NCL","NAM","MYT","MYS","MUS","MTQ","MSR","MRT","MOZ","MNG","MNE","MMR","MLT","MLI","MEX","MDG","LVA","LUX","LTU","LSO","LCA","LBY","LBR","LAO","KOR","KNA","KIR","KHM","KGZ","KAZ","JOR","JEY","JAM","ITA","ISR","ISL","IRQ","IRL","IND","HUN","HTI","HRV","HND","HKG","GUF","GTM","GRD","GRC","GNQ","GNB","GMB","GLP","GIN","GHA","GGY","GBR","GAB","FRA","FLK","FJI","FIN","ETH","EST","ESP","ESH","EGY","DOM","DMA","DJI","DEU","CZE","CYP","CUB","CRI","CPV","COL","COG","COD","CIV","CHN","CHL","CAN","CAF","BWA","BRN","BRB","BRA","BOL","BMU","BLZ","BLR","BHS","BHR","BGR","BFA","BES","BEL","BDI","AUT","AUS","ATG","ASM","ARM","ARE","ANT","AND","ALB","ALA","AIA","AGO","AFG"), 
        selected = c("GBR", "CHN", "USA", "IND"),
        multiple = TRUE
      ),
      
      sliderInput("time", "Select timeframe", min = 1750, max = 2021, value = c(1750, 2021), sep = "")),
    
    mainPanel(plotlyOutput("co2emissions"), 
              p("This chart shows the CO2 Emissions of the selected countries from the earliest date recored(differs in each country) to the most recent date, being 2021. You can learn which countries have released the most CO2, along with the trend (increasing or decreasing) of CO2 emission in each country"))))

ui <- navbarPage("CO2 Emissions", theme = shinytheme("darkly"), introduction_page, page2)



