#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


# Define server logic required to draw a plot
shinyServer(function(input, output) {


  df <- reactive({ 
      dfx <- eval(parse(text=paste("mtcars$",input$Xaxis, sep = "")))
      dfy <- eval(parse(text=paste("mtcars$",input$Yaxis, sep = "")))
      dfc <- eval(parse(text=paste("mtcars$",input$colour, sep = "")))
            df <- as.data.frame(cbind(dfx, dfy))
            df <- as.data.frame(cbind(df, dfc))
      })
  
    output$mtPlot <- renderPlot({ 
    dfb <- df()
   ggplot(dfb, aes(dfx, dfy))+
   geom_point(aes(colour = factor(dfc)))+
   geom_smooth(aes(x=dfx, y = dfy))+
   labs(x = input$Xaxis, y = input$Yaxis, colour = input$colour)
    })

    fullNames <- c("mpg",	"Miles/(US) gallon",
                   "cyl",	"Number of cylinders",
                   "disp",	"Displacement (cu.in.)",
                   "hp",	"Gross horsepower",
                   "drat",	"Rear axle ratio",
                   "wt",	"Weight (1000 lbs)",
                   "qsec",	"1/4 mile time",
                   "vs",	"Engine (0 = V-shaped, 1 = straight)",
                   "am",	"Transmission (0 = automatic, 1 = manual)",
                   "gear",	"Number of forward gears",
                   "carb",	"Number of carburetors")
    fullNames <- matrix(fullNames, 11,2, byrow = TRUE)
    fullNames <- as.data.frame(fullNames)
    names(fullNames) <- c("Abbrevation", "Full name")
    output$fullNames <- renderTable(fullNames)
    
    output$About <- renderText("Motor Trend Car Road Tests
The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973--74 models).

Keywords
datasets
Usage
mtcars
Note
Henderson and Velleman (1981) comment in a footnote to Table 1: 'Hocking [original transcriber]'s noncrucial coding of the Mazda's rotary engine as a straight six-cylinder engine and the Porsche's flat engine as a V engine, as well as the inclusion of the diesel Mercedes 240D, have been retained to enable direct comparisons to be made with previous analyses.'")
   
     output$Manual <- renderText("Here we have Shiny app which helps to explore mtcars data set. You can choose which data to plot on X and Y axis and select factor for colouring data. Linear regresion line also will be calculated so you can imediatly spot correlations. Have Fun!")
    
    })


