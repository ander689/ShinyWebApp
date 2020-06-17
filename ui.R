#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    titlePanel("Plotting Swiss Fertility Data With Various Models:"),   
    theme = shinytheme("slate"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("p", "Select a Variable:",                    
                         list("Agriculture"='Agriculture', "Examination"='Examination', "Education"='Education', "Catholic"='Catholic', "Infant Mortality"='Infant Mortality')),  
            radioButtons("q","Select a Model Method:",
                         list("Basic Linear Model"="lm","Loess"="loess")),
            sliderInput("slider","Adjust the confidence bounds!",
                        min=0,
                        max=1,
                        value=0.95)
        ),
        mainPanel(
            h4(textOutput("model")),
            plotOutput("distPlot"), 
            textOutput("variableExpl"),
            tags$div("\n",
                     tags$ul(
                         tags$li(strong("Agriculture"), "Percent of males involved in agriculture as occupation"),
                         tags$li(strong("Examination"), "Percent of draftees receiving highest mark on army examination"),
                         tags$li(strong("Education"), "Percent of education beyond primary school for draftees."),
                         tags$li(strong("Catholic"), "Percent of ‘catholic’ respondants (as opposed to ‘protestant’)."),
                         tags$li(strong("Infant Mortality"), "Live births who live less than 1 year.")
                     )         
            )
        ) 
    )
    )
)
