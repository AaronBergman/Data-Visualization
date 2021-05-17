
shinyUI(fluidPage(
    
    titlePanel("MEAT Consumption by Country Over Time"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("metric","Select which metric to analyize",type),
            selectInput("animal","Select the type(s) of meat/animal (use backspace to remove)",animal_list,multiple = T),
            selectInput("countries","Select which countries to view (use backspace to remove)",
                         levels(as.factor(meat$LOCATION)),multiple=T,
                         selected = c("World")),   
        sliderInput("timerange","Select which years to analyze. Data for future years are forecasts.",min=1991,
                    max=2028,value=c(1991,2028),sep="")),
        
        
        mainPanel(
         plotOutput("lineplot")
        #     #\input$click_point - records info about where a user has clicked this plot
        #     tableOutput("tableInfo")
        )
)
))
