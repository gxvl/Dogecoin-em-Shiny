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
                  h1("02/04/2023 - 25/04/2023"),
              box(plotlyOutput("dogeGGplot"), width = 15, height = 1)),
          tabItem("tab2",
                  dataTableOutput("tableDoge"),
                  fluidRow(
                    infoBox("Alta",0.104060, icon = icon("plus"), color = "yellow"),
                    infoBoxOutput("altaId"),
                    infoBox("Baixa", 0.076252, icon = icon("minus"), color = "yellow"),
                    infoBoxOutput("MínimaId"),
                    infoBox("Diferença", 0.027809, icon = icon("tag"), color = "yellow"),
                    infoBoxOutput("DiferencaId"),
                    infoBox("Média", 0.085577	, icon = icon("tasks"), color = "yellow"),
                    infoBoxOutput("MediaId"),
                    infoBox("Var%", -5.141086	, icon = icon("asterisk"), color = "yellow"),
                    infoBoxOutput("Var%Id"),
                    
                  )
                  )
        ),
        
        )
      )
    


# Define server logic required to draw a histogram
server <- function(input, output) {
  dataDogecoin <- read.csv("dogecoinBigData.csv")
  
  
  dogeGGplot = ggplot(dataDogecoin, aes(Data, Último, group = 1)) +
    geom_point(size = 4)+
    geom_line(colour = "blue", linewidth = 1.4)
 
  ################################################################
  output$dogeGGplot <- renderPlotly(dogeGGplot)
  output$tableDoge <- renderDataTable(dataDogecoin)
  output$ibox <- renderInfoBox({
    infoBox(
      "Alta",
      icon = icon("plus")
    )
  })
  output$vbox <- renderValueBox({
    valueBox(
      "0.104060",
    )
  })

}

# Run the application
shinyApp(ui, server)