#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
names <- c("mpg", "cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb")
namesFact <- c("cyl","vs","am","gear","carb")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("mtcars browsing"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectInput("Xaxis", "X axis", names),
        selectInput("Yaxis", "Y axis", names), 
        selectInput("colour", "Data point Colour", namesFact)
          ),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Plot", br(),
                      plotOutput("mtPlot")
                                    ),
                      tabPanel("Abbrevations", br(),
                                tableOutput("fullNames")
                      ),
                      tabPanel("About data", br(),
                               textOutput("About")
                      ),
                      tabPanel("Brief manual", br(),
                               textOutput("Manual")
                      )
          )
           
            
        )
    )
))
