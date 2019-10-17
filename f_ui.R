ui  =  fluidPage(
  tags$head(HTML("<title>Valuation map</title>")),  
  titlePanel(title = h2("Valuation map", align="left")),
  sidebarLayout(
        sidebarPanel(
            width = 3,

            checkboxInput("show_tickers", "Show tickers", value = FALSE),
            
            checkboxGroupInput("sectors", "Sectors", 
                choices = sectors, selected = sectors),
            actionLink('select_all_sectors', 'Select All'),

            selectInput("x_axis", "X axis", 
                choices = lab_map,
                selected = '3'
            ),
            uiOutput('range_x_axis'),
            checkboxInput("ex_outliers_x", "Remove 2sd outliers", value = TRUE),

            selectInput("y_axis", "Y axis",
                choices = lab_map,
                selected = '1'
            ),
            uiOutput('range_y_axis'),
            checkboxInput("ex_outliers_y", "Remove 2sd outliers", value = TRUE),

            numericInput("mc_floor", "min Market Cap, $bn", 
                value = 0.5),
            numericInput("mc_cap", "max Market Cap, $bn", 
                value = 1000)
        ),
        mainPanel(
            div(
                em('Source: FactSet; as of close 10/15/2019; includes 1991 ITOT constituents as of 10/10/2019, sector classificaions by iShares; excludes stocks with market cap under $100mm or revenue LTM or LTM-3 years under $5mm or those where data not available.')
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
