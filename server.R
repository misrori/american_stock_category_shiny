library(shiny)
library(DT)
library(plotly)
library(data.table)
library(rio)
library(stringr)


function(input, output, session) {
  source('my_functions.R')
  comp_list <- data.table(import('comp_list.RData'))
  adat <- data.table(import('Stock_data.RData'))
  
  my_industries <- reactive({
    indristies <- c("",comp_list[comp_list$Sector==input$sector,]$industry)
    return(indristies)
  })
  
  
  output$industries <- renderUI({
    selectInput("industries_select", "Vállasz industries",selected = "", choices= my_industries() )
  })
  
  
  my_list <- reactive({
    lista <- comp_list[comp_list$Sector==input$sector & comp_list$industry==input$industries_select,]$Symbol
    print(my_list)
    return(lista)
  })
  
  
  my_data <- reactive({
    adatom_teljes <- adat[adat$ticker %in% my_list(),]
    print(head(adatom_teljes))
    adatom_teljes$Date <- as.Date(adatom_teljes$Date)
    return(adatom_teljes)
  })
  

  my_plot <- reactive({
    tozsde_plot(number_of_days = input$integer, my_adatom = my_data(), list_of_markets =my_list() )
  })
  
  output$summary_plot <- renderPlotly({
    my_plot()
  })
  
}
