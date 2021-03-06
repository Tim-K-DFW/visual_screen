apply_filters_for_sliders = function(input) {
    # only removes outliers, but does not apply boundaries defined by sliders
    res = DD[complete.cases(DD),]

    temp_x = res[[LABS[input$x_axis, 2]]]
    res$zs_x = (temp_x - mean(temp_x)) / sd(temp_x)
    temp_y = res[[LABS[input$y_axis, 2]]]
    res$zs_y = (temp_y - mean(temp_y)) / sd(temp_y)

    if(input$ex_outliers_x)
        res = subset(res, abs(zs_x) < 2)
    if(input$ex_outliers_y)
        res = subset(res, abs(zs_y) < 2)

    res = subset(res, market_cap >= input$mc_floor * 1000 & market_cap <= input$mc_cap * 1000)
    res = subset(res, sector %in% names(SECTORS)[which(SECTORS %in% input$sectors)])

    res
}

apply_filters = function(input) {
    # removes outliers AND applies boundaries defined by sliders

    # will remove NA, e.g. when ROE and other "rare" metrics selected
    res = DD[complete.cases(DD),]

    temp_x = res[[LABS[input$x_axis, 2]]]
    res$zs_x = (temp_x - mean(temp_x)) / sd(temp_x)
    temp_y = res[[LABS[input$y_axis, 2]]]
    res$zs_y = (temp_y - mean(temp_y)) / sd(temp_y)

    if(input$ex_outliers_x)
        res = subset(res, abs(zs_x) < 2)
    if(input$ex_outliers_y)
        res = subset(res, abs(zs_y) < 2)

    res = subset(res, market_cap >= input$mc_floor * 1000 & market_cap <= input$mc_cap * 1000)
    res = subset(res, sector %in% names(SECTORS)[which(SECTORS %in% input$sectors)])

    # filter by range of x axis
    tt = res[[LABS[input$x_axis, 2]]]
    if (is.null(input$range_x_selected))
        temp_range = range(DD[[LABS[input$x_axis, 2]]])
    else
        if (LABS[input$x_axis, 3] == '%')
            temp_range = input$range_x_selected / 100
        else    
            temp_range = input$range_x_selected
    res = res[tt >= temp_range[1] & tt <= temp_range[2], ]

    # filter by range of y axis
    tt = res[[LABS[input$y_axis, 2]]]
    if (is.null(input$range_y_selected))
        temp_range = range(DD[[LABS[input$y_axis, 2]]])
    else
        if (LABS[input$y_axis, 3] == '%')
            temp_range = input$range_y_selected / 100
        else    
            temp_range = input$range_y_selected
    res = res[tt >= temp_range[1] & tt <= temp_range[2], ]

    res
}

slider_dynamic = function(axis, boundary, input) {
    # creates slider object for either axis with units and range depending on data
    # selected for that axis
    # step sizes set arbitrarily but can change as needed... or paratemrize them
    axis_ref = glue('{axis}_axis')
    if (LABS[input[[axis_ref]], 3] == '%')
        sliderInput(glue('range_{axis}_selected'), label = NULL,
            min = floor(floor(boundary[1] * 100)/10) * 10, max = ceiling(ceiling(boundary[2] * 100)/10) * 10, value = boundary * 100, round = TRUE, post = '%', step = 5)
    else
        sliderInput(glue('range_{axis}_selected'), label = NULL,
            min = floor(boundary[1]), max = ceiling(boundary[2]), value = boundary, round = TRUE, post = 'x', step = 1)
}
