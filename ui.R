shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Fuel Consumtpion Prediction"),
    sidebarPanel(
      numericInput('cyl', 'Number of Cylinders (4,6 or 8)', 4, min = 4, max = 8, step = 2),
      numericInput('hp', 'Gross horsepower (hp)', 100, min = 52, max = 335, step = 1),
      numericInput('wt', 'Weight (lb/1000)', 2, min = 1.5, max = 5.4, step = .1),
      numericInput('am', 'Gear Type Transmission (0 = automatic, 1 = manual)', 0, min = 0, max = 1, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction")
    )
  )
)

