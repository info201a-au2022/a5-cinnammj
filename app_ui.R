# Define UI
library("shiny")
library("dplyr")
library("plotly")
library(shinythemes)



co2 <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-3-section-ah/main/data/hate_crime.csv") %>%
  rename(year = DATA_YEAR)


introduction_page <- tabPanel(
  "Introduction",
  img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJBiNfSUrPPb2EnwfP81aT6PibwLHYAaw9ag&usqp=CAU", height = 250, width = "100%"),
  h2("Introduction"),
  p("Our project focuses on analyzing trends in hate crimes. The questions we are aiming to address include: What are the causes and motivations behind hate crimes? How are hate crimes punishable across different states? How does the political party affiliation by state correspond with crime rates? The first dataset we will be using comes from the FBI's Uniform Crime Reporting (UCR) Program. This dataset includes various information about the hate crime, such as demographics of vistoms/perpetrators and potential causes behind that hate crime data. The second dataset we will analyze comes Harvard Dataverse. This dataset tells us the voting outcome for presidential candidates from years 1976-2020 and can potentially give insight on how political party affiliation may be linked with hate crimes. The third dataset is the US Population dataset from Kaggle. This dataset tells us the population in each state in the U.S. in 2020. Our final dataset is from ADL(Anti-Defamation League). This dataset tells us which states have laws protecting hate crimes, and if not all then which hate crimes it protects.")
)

# Sidebar
inputs <- sidebarPanel(
  
  selectInput(
    inputId = "yearvar",
    label = "Choose year",
    choices = c(2010,2011,2012,2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020)
  )
)

# Interactive Page1

interactive_page <- tabPanel(
  "Bar plot",
  sidebarLayout(inputs,
                mainPanel(plotlyOutput("motovation_plot"))),
  p(em("This bar plot showcases the proportion (%) of the causes and motivations behind hate crimes for a specified year (2000-2010). Across the decade, anti racial sentiments seem to be the main motivators behind hate crimes."))
)


# Interactive page 2 - Michael
Takeaways <- tabPanel(
  "Key Takeaways",
  h2("The Three Key Takeaways"),
  p("1.) we found out that the political party affiliation of each state did not necessarily correspond with lower hate crime rates. States that affiliate with the Democratic party had higher hate crime rates, with the District of Columbia, New Jersey, and Vermont being the biggest outliers. On the contrary, states that affiliate with the Republican party had lower hate crime rates in general."),
  
  p("2.) Most states have punishments for Hate crimes, excluding Arkansas, Indiana, South Carolina, and Wyoming. and although most states have laws protecting things such as race, religion, and ethnicity. Some states start to dwindle on Disability, Gender, Sexual Orientation, and most of all Gender Identity."), 
  
  p("3.) The top 3 Hate crimes (documented) that were committed were Anti-Black or African American, Anti-Gay (Male), and Anti-Jewish. Which means that Racism, Anti-Semitism, and Homophobia are still prevalent, however that doesn't mean only those things exist, overall hatred is too big of a problem in our country")
)


map_sidebar_content <- sidebarPanel(selectInput("mapvar", label = "Variable to Map", 
                                                choices = list("Race, Religion, and Ethnicity" = "Race.Religion.Ethnicity","Disability" = "Disability"
                                                               ,"Gender" = "Gender", "Sexual Orientation" = "Sexual.Orientation", "Gender Identity" = "Gender.Identity")))

map_main_content <- mainPanel(plotlyOutput("map"))

map_panel <- tabPanel("Map",titlePanel("Protection by Identifier"), sidebarLayout(map_sidebar_content, map_main_content),
                      p(em("This map shows what certain subgroups of people (ex. race, gender, disability) are protected by laws in each state, the laws protect these groups from hate crimes being committed agaisnt them and can also further the persons punishment if they commit a hate crime against these people in the states they are protected in.")))


# Interactive page 3 - political party (Jiyoon)
interactive_political_party <- tabPanel(
  "Political Party",
  titlePanel("Political Party"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "party",
                  label = "Political Party Identification",
                  choices = list("Republican" = "Republican", "Democrat" = "Democrat"),
                  selected = "Democrat",
                  multiple = FALSE
      )
    ),
    mainPanel(
      h3("Political Party Comparison"),
      p(plotlyOutput(outputId = "political_chart"),
      p("This plot shows the states of the U.S., identifies the political party affiliation of each state, and shows their hate crime rates in percentages (calculated in ratio: hate crime rates divided by total population of each state) in 2020.")
      )
    )
  )
)

# Report page - Jiyoon
report <- tabPanel(
  "Report",
  titlePanel("Report"),
  mainPanel(
  includeMarkdown("./docs/p01-proposal.md")
  )
)


ui <- navbarPage("Hate Crimes in the U.S.",
  theme = shinytheme("darkly"),
  introduction_page, # qiqi's intro page 
  interactive_page, #qiqi's interactive page
  map_panel, #michael's interactive page goes here
  interactive_political_party, #Jiyoon's interactive page
  Takeaways, #michael's takeaways
  report #report file by Jiyoon
)


