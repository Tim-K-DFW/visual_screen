dd = data.frame(read_excel('data.xlsx', sheet = 'data for R'))

# the following can be made to be read from YAML file or automated
dd$`EV.revenue` = round(dd$`EV.revenue`, 2)
dd$`CFO.rev` = round(dd$`CFO.rev`, 4)
dd$`REVG.3` = round(dd$`REVG.3`, 4)
dd$`EV.CFO` = round(dd$`EV.CFO`, 2)

sectors = as.character(1:length(unique(dd$sector)))
names(sectors) = unique(dd$sector)

labs = data.frame(list(
    label = c('VALUATION: EV / LTM Revenue', 'VALUATION: EV / LTM CFO', 'QUALITY: LTM CFO margin', 'GROWTH: 3-year revenue growth (ann.)'),
    colmame = colnames(dd)[5:8],
    unit = c('x', 'x', '%', '%'))
)
lab_map = rownames(labs)
names(lab_map) = labs$label
