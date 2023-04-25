library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(readr)
library(dplyr)
library(ggthemes)
library(bslib)
library(plotly)

# Define UI for application that draws a histogram

ui <- dashboardPage(skin = "yellow",
      dashboardHeader(
        title = ("dados da Dogecoin")
      ),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Gráfico em data", tabName = "tab1", icon = icon("calendar")),
          menuItem("Tabela de dados", tabName = "tab2", icon = icon("th"))
        )
      ),
      dashboardBody(
        tabItems(
          tabItem("tab1",
                  h1("20/04/2023 - 25/04/2023"),
              box(plotlyOutput("dogeGGplot"), width = 10)),
          tabItem("tab2",
                  dataTableOutput("tableDoge")
                  )
        )
      ),
    )
 

# Define server logic required to draw a histogram
server <- function(input, output) {
  dataDogecoin <- read.csv("dogecoinData.csv")
  
  
  dogeGGplot = ggplot(dataDogecoin, aes(Data, Último, group = 1)) +
    geom_point(size = 4)+
    geom_line(colour = "blue", linewidth = 1.4)
 
  
  output$dogeGGplot <- renderPlotly(dogeGGplot)
  output$tableDoge <- renderDataTable(dataDogecoin)
 
  
}

# Run the application
shinyApp(ui, server)