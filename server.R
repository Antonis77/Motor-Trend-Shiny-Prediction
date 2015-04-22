library(shiny)
library(caret)


#--------------------------------------------------------------------------------------------------
#From mtcars data set create a new dataframe consisting only of four variables:
# 1) Fuel Consumption (mpg) 2) Number of Cylinders (cyl) 3) Horsepower (hp) 4) Gear Type (am)
dataset<-data.frame(mpg=mtcars$mpg,cyl=mtcars$cyl,hp=mtcars$hp,wt=mtcars$wt,am=mtcars$am)
dataset$cyl<-factor(dataset$cyl);dataset$am<-factor(dataset$am);

#--------------------------------------------------------------------------------------------------
#Split dataframe into one for automatic and one for manual gear
auto<-dataset[dataset$am==0,];manual<-dataset[dataset$am==1,]

#--------------------------------------------------------------------------------------------------
#Create linear models for automatic and manual gear to predict Fuel Consumption 
#based on the other 3 variables
autoFit<-lm(auto$mpg ~ cyl+hp+wt,data=auto)
manualFit<-lm(manual$mpg ~ cyl+hp+wt,data=manual)

#--------------------------------------------------------------------------------------------------
#Numeric Calculation of Fuel Consumption using predict function from caret package
consumption<-function (cyl,hp,wt) {
  newdata<<-data.frame(cyl=as.factor(cyl),hp=hp,wt=wt)
  x<<-c(round(predict(autoFit,newdata),1),round(predict(manualFit,newdata),1))
  data.frame(Auto_Gear=round(predict(autoFit,newdata),1),Manual_Gear=round(predict(manualFit,newdata),1))
}
#--------------------------------------------------------------------------------------------------
#Calculations plotted in barplot
consumptionPlot<-function (cyl,hp,wt) {
  newdata<<-data.frame(cyl=as.factor(cyl),hp=hp,wt=wt)
  x<<-c(round(predict(autoFit,newdata),1),round(predict(manualFit,newdata),1))
  barplot(x, xlab='Gear Type',ylab="Miles per Gallon", ylim=c(0,35),col='lightblue',main='Barplot',
          names.arg=c("Auto","Manual"),space=0.5)
}

#--------------------------------------------------------------------------------------------------
#Create outputs
shinyServer(
  function(input, output) {
    #output$inputValue <- renderPrint({c(input$cyl,input$hp,input$wt)})
    output$consumption <- renderPrint({consumption(input$cyl,input$hp,input$wt)})
    output$FuelConsumption <- renderPlot({consumptionPlot(input$cyl,input$hp,input$wt)})
}
)
