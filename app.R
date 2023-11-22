
#    http://shiny.rstudio.com/
#

library(shiny)
penguins <- read.csv("penguins.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("Find the Right Penguin!"),
sidebarLayout(
  sidebarPanel(sliderInput("flipperInput", "Flipper Length", min = 0, max = 100,
                           value = c(25, 40), post = "mm"), 
               radioButtons("speciesInput", "Species",
                            choices = c("Adelie", "Gentoo", "Chinstrap"),
                            selected = "Adelie")),
  mainPanel("the results will go here")
  )
)
server <- function(input, output) {}


shinyApp(ui = ui, server = server)