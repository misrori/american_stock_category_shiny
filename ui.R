library(shiny)
library(plotly)
library(DT)
library(data.table)


navbarPage(
           title="Tőzsde elemzés",

           tabPanel("Elemzés",
                    sidebarLayout(
                      sidebarPanel(
                        
                        selectInput("sector", label = "chosse a Sector", 
                                    choices = c("","Basic industries"="basic_industries", 
                                                "Capital Goods"= "capital_goods", "Consumer Durables"= "consumer_durables", 
                                                "Consumer Non-Durables" = "consumer_non-durables", 
                                                "Consumer Services"= "consumer_services","Energy" = "energy",
                                                "Finance" ="finance", "Healt Care"= "health_care", 
                                                "Miscellaneous"="miscellaneous","Public Utilities"= "public_utilities", 
                                                "Technology"="technology", "Transportation"="transportation"), 
                                    selected = "Technology"),
                        uiOutput("industries"),
                        sliderInput("integer", "Number of days before:", min=0, max=100, value=50)
                        
                      ),
                      mainPanel(
                        plotlyOutput('summary_plot')
                      )
                    )
                    
           ),

           tags$head(
             tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
           )# http://bootswatch.com/#Grafikon_tab
           
           
           
           )#nav
