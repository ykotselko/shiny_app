#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
    titlePanel("Multivariative models"),
    fluidRow(
        column(12,
               wellPanel(
                    helpText("In this project we will play with mtcars dataset (1974 Motor Tred US magazine). 
                             Our goal is to build linear models that show the relationship between transmission (manual and automatic) and MPG (miles / US gallon).
                             By defaul our model looks like lm(mpg ~ am, data = mtcars). As we can see, the default model (mpg ~ am) has only 35.98% of variance explained. Not so much.
                             By selecting additional variables our model will be recomputed and we will be able to alanlyze this model using mean, variance explained (R-squared) and number of plots including Normal Q-Q plot.
                             Let's try to find the best fitting model!"),
                    helpText("Please note: this project was developed just to demonstrate Shiny interactive capabilities. Of course there are number of techniques allowing us to find best fitting model automatically.")
               )
        )
    ),
    fluidRow(
        column(4,
               wellPanel(
                   checkboxGroupInput("predGroup", 
                                      h3("Additional variables"), 
                                      choices = list("Number of cylinders" = "cyl", 
                                                     "Displacement (cu.in.)" = "disp", 
                                                     "Gross horsepower" = "hp",
                                                     "Rear axle ratio" = "drat",
                                                     "Weight (1000 lbs)" = "wt",
                                                     "1/4 mile time" = "qsec",
                                                     "V/S" = "vs",
                                                     "Number of forward gears" = "gear",
                                                     "Number of carburetors" = "carb" ),
                                      selected = 1)
               )
        ),
        column(8,
               h3("Model:"),
               htmlOutput("model"),
               hr(),
               h4("Model summary"),
               tableOutput("predGroup"),
               hr(),
               h4("Mean:"),
               htmlOutput("meanAuto"),
               htmlOutput("meanManual"),
               h4("Variance Explained (by R squared):"),
               htmlOutput("rsquared"),
               hr(),
               h4("Model plot"),
               plotOutput("plot1")
        )
        
        
    )    
    
))
