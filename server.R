#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    modelFormula <- reactive({
        predGroup <- input$predGroup
        if (is.null(predGroup)) {
            "mpg ~ am"
        } else {
            paste("mpg ~ am + ", paste(predGroup,collapse = "+"))
        }
    
    })
    
    adjModel <- reactive({
        lm(as.formula(modelFormula()), data = mtcars)
    })
    
    output$plot1 <- renderPlot({
        
        par(mfrow = c(2,2))
        plot(adjModel())
        
    })
    
    output$model <- renderText({
        paste0("<b>",modelFormula(),"</b>")
    })
    
    output$meanAuto <- renderText({
        paste0("Mean of mpg for automatic transmission:<b>",summary(adjModel())$coef[1,1],"</b>")
    })

    output$meanManual <- renderText({
        paste0("Mean of mpg for manual transmission:<b>",summary(adjModel())$coef[2,1] + summary(adjModel())$coef[1,1],"</b>")
    })
    
        
    output$rsquared <- renderText({
        paste0("<b>",round(100*summary(adjModel())$r.squared,2),"%</b>")
    })
    
    
    output$predGroup <- renderTable({
        summary(adjModel())$coef
        
    }, rownames = TRUE) 
   
})

