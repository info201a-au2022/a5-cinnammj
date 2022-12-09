# Define server
library("dplyr")
library("plotly")

#source files

# CSV files
co2data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/a5-cinnammj/main/owid-co2-data.csv", stringsAsFactors = FALSE) #%>% filter(iso_code == "USA")
RecentChina <- filter(co2data, year == max(year)) %>% filter(country == "China") %>% select(co2)
RecentUS <- filter(co2data, year == max(year)) %>% filter(country == "United States") %>% select(co2)
RecentIndia <- filter(co2data, year == max(year)) %>% filter(country == "India") %>% select(co2)
RecentWorld <- filter(co2data, year == max(year)) %>% filter(country == "World") %>% select(co2)
PercentUS <- (RecentUS$co2/RecentWorld$co2) * 100
PercentChina <- (RecentChina$co2/RecentWorld$co2) * 100
PercentIndia <- (RecentIndia$co2/RecentWorld$co2) * 100

# Server  
  
countryco2 <- co2data[, c(1, 2, 3, 4, 8)] 

server <- function(input, output, session) 
{
  
  overallco2 <- reactive({
    countryco2 %>% filter(iso_code %in% input$country, year %in% c(input$time[1]:input$time[2]))
  })
  
  output$co2emissions <- renderPlotly({ggplotly(ggplot(overallco2(), aes(x= year, y= co2, color = iso_code)) + 
                                                     geom_line() + ggtitle("CO2 emissions by year") + 
                                                  labs(y = "CO2 emissions measured in million tonnes"))                                                
  })
}
