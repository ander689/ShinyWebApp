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
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    if(input$p=='Agriculture'){    
      i<-2     }
    if(input$p=='Examination'){
      i<-3     }
    if(input$p=='Education'){
      i<-4     }
    if(input$p=='Catholic'){
      i<-5     }
    if(input$p=='Infant Mortality'){
      i<-6     }
    x <- swiss[,i]
    df<-data.frame(swiss$Fertility,x)
    ggplot(data=df,aes(x,swiss.Fertility))+
      geom_smooth(aes(),method=input$q,level=input$slider)+
      geom_point()+
      xlab(input$p)+
      ylim(c(25,range(swiss$Fertility)[2]))+
      xlim(range(x))+
      ylab("Fertility")
  })
  dataInput<-reactive({
    if(input$q=="Basic Linear Model"){
      fit<-lm(swiss.Fertility~y,df)
    }
    if(input$q=="Loess"){
      fit<-loess(swiss.Fertility~y,df)
    }
  })
  output$model<-renderText({
    paste("You have selected a ", input$q, "model, comparing Fertility vs. ", input$p)
  })
  output$variableExpl<-renderText({
    paste("This data comes from the 'Swiss Fertility and Socioeconomic Indicators (1888) Data' from R's datasets package. This dataset offers a standardized fertility measure and socio-economic indicators for each of the 47 French-speaking provinces of Switzerland during the year 1888. The socio-economic indicators include:")
  })
})