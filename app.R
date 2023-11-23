
library(shiny)
library(dplyr)
penguins <- read.csv("https://raw.githubusercontent.com/stat545ubc-2023/assignment-b3-jacquelineb174/main/penguins.csv", stringsAsFactors = FALSE)


ui <- fluidPage(
  titlePanel("Find the Right Penguin!"), "Welcome! This app is designed to help you find the IDs of penguins from the palmerpenguins dataset that fit the qualities you are looking for.",
  br(), "The palmerpenguins github is here", a("https://github.com/allisonhorst/palmerpenguins"),
#Feature #1 is adding a layout. This is useful because I can separate the side bar to contain the variables to be adjusted by the user and have a separate table populate in the main panel beside. 
sidebarLayout(
  sidebarPanel(
#Feature #2 is adding interactive selection buttons and sliders. This is useful so that the user can enter a few qualities they are looking for to get a list of penguins that fit their criteria. 
    sliderInput("massInput", "Body Mass (g)", min = 2650, max = 6350,
                 value = c(3390, 5000), post = "mm"), 
    radioButtons("speciesInput", "Species",
                 choices = c("Adelie", "Gentoo", "Chinstrap"),
                 selected = "Adelie"),
    selectInput("sexInput", "Sex",
                 choices = c("female", "male"))
               ),
  mainPanel(tableOutput("penguinids"))
             )
         )

server <- function(input, output) { 
  filtered <- reactive({
    penguins %>%
      filter(body_mass_g >= input$massInput[1],
             body_mass_g <= input$massInput[2],
             species == input$speciesInput,
             sex == input$sexInput)
  })
#Feature #3 is an output table. This is useful as it provides the user with a list of penguins that fit the criteria that have searched for.   
  output$penguinids <- renderTable({
    filtered()
  })
}

shinyApp(ui = ui, server = server)