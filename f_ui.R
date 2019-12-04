ui  =  fluidPage(
  tags$head(includeHTML(('google.html'))),
  tags$head(HTML("<title>Valuation map</title>")),  
  titlePanel(title = h2('"Valuation map"', align="left")),
  sidebarLayout(
        sidebarPanel(
            width = 2,

            checkboxInput("show_tickers", "Show tickers", value = FALSE),
            
            checkboxGroupInput("sectors", "Sectors", 
                choices = SECTORS, selected = SECTORS),
            actionLink('select_all_sectors', 'Select All'),

            selectInput("x_axis", "X axis", 
                choices = LAB_MAP,
                selected = '5'
            ),
            uiOutput('range_x_axis'),
            checkboxInput("ex_outliers_x", "Remove 2sd outliers", value = TRUE),

            selectInput("y_axis", "Y axis",
                choices = LAB_MAP,
                selected = '1'
            ),
            uiOutput('range_y_axis'),
            checkboxInput("ex_outliers_y", "Remove 2sd outliers", value = TRUE),

            numericInput("mc_floor", "min Market Cap, $bn", 
                value = 0.5),
            numericInput("mc_cap", "max Market Cap, $bn", 
                value = 1500)
        ),
        mainPanel(
            div(
                em(textOutput('caption'))
            ),            
            div(
                style = "position:relative",
                plotOutput(
                    "plot2", 
                    hover = hoverOpts("plot_hover", delay = 100, delayType = "debounce")
                ),
                uiOutput("hover_info")
            )
        )
    )
)
