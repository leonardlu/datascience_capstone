library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Text Predictor"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    textInput("entry", "Please Input Text Here:", "Predict the next")
  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    #verbatimTextOutput("summary"),
    #tableOutput("view")
    textOutput("top1"),
    textOutput("top2"),
    textOutput("top3"),
    textOutput("top4"),
    textOutput("top5")
    #textOutput("sent")
  )
))