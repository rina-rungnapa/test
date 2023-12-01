## absolutePanel
# https://shiny.posit.co/r/reference/shiny/0.11/absolutepanel

library(shiny)
library(shinyjs)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  tags$h1("Using absolutePanel in R Shiny"),
  fluidRow(
    column(12,
      column(3,
             textInput(inputId = "text",
                       label = "Your Name",
                       value = "",
                       width = "100%",
                       placeholder = "Write your name here")
             )
    ),
    column(1,
           div(style = "padding-left: 15px;",
               actionButton("submit", "Enter")
           )
    )
  ),
  absolutePanel(
    id = "warning_panel",
    top = 300,
    right = 500,
    draggable = TRUE,
    fixed = TRUE,
    style = "padding: 5px; border-radius: 5px; display: none;",
    h5(
      tags$span(
        icon("exclamation-triangle",
             class = "warning-icon",
             style = "font-size: 150px; color: #EDB510; vertical-align: middle;"),
        style = "margin-right: 5px;"
      ),
      "No Violence Please",
      style = "font-size: 75px; font-weight: bold; margin-bottom: 0; vertical-align: middle;"
    )
  ))


server <- function(input, output) {

  observeEvent(input$submit, {
    text_input <- input$text
    bad_words <- c("kill", "murder")

    contains_bad_word <- any(grepl(paste(bad_words, collapse = "|"), tolower(text_input)))

    if (contains_bad_word) {
      shinyjs::show("warning_panel")
    } else {
      shinyjs::hide("warning_panel")
    }
  })
}


shinyApp(ui, server)