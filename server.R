library(shiny)
library(caret)

dataset<-data.frame(mpg=mtcars$mpg,cyl=mtcars$cyl,hp=mtcars$hp,wt=mtcars$wt,am=mtcars$am)
dataset$cyl<-factor(dataset$cyl);dataset$am<-factor(dataset$am);
modelFit<-lm(dataset$mpg ~ .,data=dataset)

milesPerGallon<-function (cyl,hp,wt,am) {
  newdata<-data.frame(cyl=as.factor(cyl),hp=hp,wt=wt,am=as.factor(am))
  round(predict(modelFit,newdata),1)}

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({c(input$cyl,input$hp,input$wt,input$am)})
    output$prediction <- renderPrint({milesPerGallon(input$cyl,input$hp,input$wt,input$am)})
  }
)