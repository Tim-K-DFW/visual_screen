server  =  function(input, output, session){
  output$plot2 = renderPlot({
    dd2 = apply_filters(dd, input)
    
    pl = ggplot(dd2, aes_string(
      x = glue('`{labs[input$x_axis,]$colmame}`'),
      y = glue('`{labs[input$y_axis,]$colmame}`')
    )) +
      geom_point(aes(size = market_cap, color = sector), alpha = 0.7) +
      scale_size(range = c(2, 20)) +
      guides(color = guide_legend(override.aes = list(size = 8)), size = FALSE) +
      geom_vline(xintercept = 0, linetype = 'dashed', color = 'black') +
      geom_hline(yintercept = 0, linetype = 'dashed', color = 'black') +
      theme(
        legend.position = 'bottom',
        legend.title = element_blank(),
        legend.text = element_text(size = 14),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16)
      )
    if (input$show_tickers)
      pl = pl + geom_text(aes(label = ticker), size = 3.5)
    
    if (labs[input$x_axis, 3] == '%')
      pl = pl + scale_x_continuous(name = labs[input$x_axis, 1], breaks = scales::pretty_breaks(n = 10), labels = percent)
    else
      pl = pl + scale_x_continuous(name = labs[input$x_axis, 1], breaks = scales::pretty_breaks(n = 10))
    
    if (labs[input$y_axis, 3] == '%')
      pl = pl + scale_y_continuous(name = labs[input$y_axis, 1], breaks = scales::pretty_breaks(n = 10), labels = percent)
    else
      pl = pl + scale_y_continuous(name = labs[input$y_axis, 1], breaks = scales::pretty_breaks(n = 10))
    
    pl
  },
  height = 800, width = 1200
  )
  
  output$range_x_axis = renderUI({
    dd2 = apply_filters_for_sliders(dd, input)
    boundary = range(dd2[[labs[input$x_axis, 2]]])
    slider_dynamic('x', boundary, input, labs)
  })
  
  output$range_y_axis = renderUI({
    dd2 = apply_filters_for_sliders(dd, input)
    boundary = range(dd2[[labs[input$y_axis, 2]]])
    slider_dynamic('y', boundary, input, labs)
  })
  
  # for select/unselect all sectors, source: https://stackoverflow.com/questions/28829682/r-shiny-checkboxgroupinput-select-all-checkboxes-by-click
  observe({
    if(input$select_all_sectors == 0) return (NULL) 
    else if (input$select_all_sectors%%2 == 0)
    {
      updateCheckboxGroupInput(session,"sectors",label = "Sectors",choices=sectors)
    }
    else
    {
      # updateCheckboxGroupInput(session,"campaigns","Choose campaign(s):",choices=campaigns_list,selected=campaigns_list)
      updateCheckboxGroupInput(session,"sectors",label = "Sectors",choices=sectors, selected = sectors)
    }
    # browser()
  })
  
  # source: https://gitlab.com/snippets/16220  thanks man
  output$hover_info = renderUI({
    hover = input$plot_hover
    point = nearPoints(dd, hover, threshold = 5, maxpoints = 1, addDist = TRUE)
    if (nrow(point) == 0) return(NULL)
    left_pct = (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct = (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    left_px = hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px = hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    style = paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                   "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    wellPanel(
      style = style,
      p(HTML(glue("<b> Ticker: </b>{point$ticker}<br/>
                       <b> Mkt cap: </b>{format(round(point$market_cap, 1), nsmall = 1, big.mark = ',')}<br/>
                       <b> CFO/Rev: </b>{round(point$`CFO.rev` * 100, 2)}%<br/>
                       <b> EV/Rev: </b>{round(point$`EV.revenue`, 1)}x<br/>
                       <b> ROE LTM: </b>{round(point$`ROE.LTM` * 100, 2)}%<br/>
                       <b> EV/LTM CFO: </b>{round(point$`EV.CFO`, 1)}x<br/>")))
    )
  })
}