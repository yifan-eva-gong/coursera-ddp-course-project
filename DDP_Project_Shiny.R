library(shiny)
ui <- shinyUI(fluidPage(
   # Application title
   titlePanel("Shiny app to build a histogram"),
   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         selectInput("var","Variable:",c("Petal Length" = "Petal.Length",
                                           "Petal Width" = "Petal.Width",
                                         "Sepal Length" = "Sepal.Length",
                                         "Sepal Width" = "Sepal.Width"
                                           )),
         selectInput("col","Color:",c("darkgray"="darkgray","red","blue","yellow"
         ))
      ),
       # Show a plot of the generated distribution
      mainPanel(
        p("This is an app for you to draw a histogram with desired number of bins."),
        p("Select the number of bins and variable you want from the side bar on the left."),
        p("To make it prettier you can also choose the color of the bin"),
         plotOutput("distPlot")
      )
   )
))

# Define server logic required to draw a histogram

data(iris)
server <- shinyServer(function(input, output) {
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
     chosen <- input$var
     if (chosen=="Petal.Length"){
       x  <- iris$Petal.Length
     } else if (chosen=="Petal.Width"){
       x  <- iris$Petal.Width
     }else if (chosen=="Sepal.Width"){
       x  <- iris$Sepal.Width
     }else{
       x  <- iris$Sepal.Length
       }
     color=input$col
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = color, border = 'white',
           main = paste("Histogram of",chosen),xlab =chosen)
   })
})

# Run the application
shinyApp(ui = ui, server = server)

