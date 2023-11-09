

library(shiny)
library(plotly)
library(shinydashboardPlus)
library(shinydashboard)
library(shinyjs)
library(tmap)
library(xts)
library(dygraphs)
library(shinymanager)
library(shinyMobile)
library(curl)
library(shinyWidgets)

source("objects in UI.R")
source("GetDataFromGoogledrive_func.R")

shinyUI(
  
  secure_app(f7Page(ui_yes, 
                    tags$style(type="text/css",
                               ".shiny-output-error { visibility: hidden; }",
                               ".shiny-output-error:before { visibility: hidden; }"
                    ),
                    allowPWA = TRUE,
                    title = "EWARS Dashboard on mobile",
                    options = list(dark = FALSE, filled = FALSE, preloader = TRUE)
                    ),
             theme = shinythemes::shinytheme("paper")
             # tags_top = tags$div(
             #   tags$img(
             #     src = "/icons/favicon.png", width = 90, alt="Logo not found", style = "margin-top: 2rem", deleteFile=FALSE
             #   ))
             )
  
  #titlePanel(tags$h4("EWARS-Dashboard")),
  #uiOutput('log_list') 
  

      )




