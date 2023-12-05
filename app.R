library(shiny)
library(dplyr)
library(shinythemes)
penguins <- read.csv("https://raw.githubusercontent.com/stat545ubc-2023/assignment-b3-jacquelineb174/main/penguins.csv", stringsAsFactors = FALSE)


ui <- fluidPage(
  #New feature #1 is adding a theme. Although it does not serve a functional roles, adding a theme is useful as it makes the site more visually appealing. 
  theme = shinytheme("superhero"),
  titlePanel("Find the Right Penguin!"), "Welcome! This app is designed to help you find the IDs of penguins from the palmerpenguins dataset that fit the qualities you are looking for.",
  br(), " Use the buttons  below to select the penguin's qualities you would like. ", br(), "The palmerpenguins github is", a("here", href = "https://github.com/allisonhorst/palmerpenguins"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("massInput", "Body Mass (g)", min = 2650, max = 6350,
                  value = c(3390, 5000), post = "g"), 
      radioButtons("speciesInput", "Species",
                   choices = c("Adelie", "Gentoo", "Chinstrap")),
      radioButtons("sexInput", "Sex",
                  choices = c("female", "male")),
      #New feature #2 is to add an image of the "palmer penguins". This is useful as it makes the app more sightly and also has labels that help distinguish between the three species of penguin.
      img(src = "penguins2.png", height = 220, width = 400), br(), 
      "Image created by", a("Allison Horst", href = "https://allisonhorst.github.io/palmerpenguins/articles/intro.html")
                ),
    #New feature #3 is to add a download button.This is useful as it allows the user to download the output table of the penguins that match their description. 
    mainPanel(downloadButton("PenguinMatch", "Download table here"), 
              tableOutput("penguinids"))
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
  output$penguinids <- renderTable({
    filtered()
  })
  output$PenguinMatch <- downloadHandler(
    filename = function() {
      paste(PenguinMatch, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)