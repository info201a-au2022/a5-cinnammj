# Define server
library("dplyr")
library("plotly")

#source files
source("./source/charts/political_party_chart.R")

# CSV files
hate_crimes <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-3-section-ah/main/data/hate_crime.csv") %>%
  rename(year = DATA_YEAR)
state_codes <- read.csv('https://raw.githubusercontent.com/info201a-au2022/project-group-3-section-ah/main/data/state_codes.csv', stringsAsFactors = FALSE)
df1 <- read.csv('https://raw.githubusercontent.com/info201a-au2022/project-group-3-section-ah/main/data/Hate_crime_laws_by_state.csv', stringsAsFactors = FALSE)

#Michael's Function for Map
build_map <- function(data, map.var) {
  
  l <- list(color = toRGB("white"), width = 2)
  
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  var.equation <- paste0('~', map.var)
  
  p <- plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = data[,map.var], text = ~state, locations = ~code,
      color = data[,map.var], colors = 'Purples'
    ) %>%
    colorbar(title = "Color Title") %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  return(p)
}


# Server  
server <- function(input, output) {
  
  # Qiqi's plot
  output$motovation_plot <- renderPlotly({
    
    plot_data <- hate_crimes %>% 
      filter(year == input$yearvar) %>%
      group_by(BIAS_DESC) %>%
      summarise(num_biases = n()) %>%
      mutate(biases_array = strsplit(BIAS_DESC, ";")) %>%
      unnest(biases_array) %>%
      group_by(biases_array)%>%
      summarise(new_num_biases = n()) %>%
      mutate(proportion = (new_num_biases/sum(new_num_biases))*100) %>%
      mutate(year = input$yearvar)
    
    plot <- plot_ly(data = plot_data, x = ~biases_array, y = ~proportion, type = 'bar') %>%
      layout(xaxis = list(autotypenumbers = 'strict', title = 'Types of biases'),
             yaxis = list(title = 'Proportion'),
             plot_bgcolor='#e5ecf6',
             xaxis = list(
               zerolinecolor = '#ffff',
               zerolinewidth = 2,
               gridcolor = 'ffff'),
             yaxis = list(
               zerolinecolor = '#ffff',
               zerolinewidth = 2,
               gridcolor = 'ffff'))
    
  })
  
  
  # Jiyoon's plot
  output$political_chart <- renderPlotly({
    
    plot_ly(party_crimerates, x = ~state, y = ~crime_ratio) %>%
      filter(party == input$party) %>%
      group_by(party) %>%
      add_markers()
    
  })
  
  # Michael's plot
  output$map <- renderPlotly({ 
    
    return(build_map(df1, input$mapvar))
  }) 
  
}

