library(readxl)
library(ggplot2)
library(glue)
library(shiny)
library(scales)

options(stringsAsFactors = F)

# global variables
source('global.R')

# global functions
source('helpers.R')

# ==========================================================
# Shiny app proper

source('f_ui.R')
source('f_server.R')

shinyApp(ui = ui, server = server)

# ==========================================
# for debgging/development

# source('app.R'); shinyApp(ui, server)
