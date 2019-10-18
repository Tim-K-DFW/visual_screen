# ==========================================================
# prep data, all loaded to global scope

UPDATED = as.data.frame(read_excel('data.xlsx', sheet = 'data - live', range = 'e1', col_names = F, col_types = 'text', .name_repair = 'minimal'))[1,1]
DD = data.frame(read_excel('data.xlsx', sheet = 'data - live', range = 'a3:o2409'))

# the following cap be made to be read from YAML file or automated

DD$insider_ownerhip = round(DD$insider_ownerhip, 4)
DD$EV_over_Rev = round(DD$EV_over_Rev, 2)
DD$CFO_over_Rev = round(DD$CFO_over_Rev, 4)
DD$rev_growth_3yr = round(DD$rev_growth_3yr, 4)
DD$EV_over_CFO = round(DD$EV_over_CFO, 2)
DD$ROE_LTM = round(DD$ROE_LTM, 4)
DD$short_interest = round(DD$short_interest, 4)
DD$insider_ownerhip = round(DD$insider_ownerhip, 4)


SECTORS = as.character(1:length(unique(DD$sector)))
names(SECTORS) = unique(DD$sector)

LABS = data.frame(list(
    label = c('VALUATION: EV / LTM Revenue', 'VALUATION: EV / LTM CFO', 'QUALITY: LTM CFO margin', 
        'QUALITY: LTM Return on Avg Equity', 'GROWTH: 3-year Rev CAGR', 'TECH: Short interest, % of float', 'TECH: % Insider ownership', 'SIZE: Market cap, $mm'),
    colmame = colnames(DD)[4:11],
    unit = c('x', 'x', '%', '%', '%', '%', '%', 'x'))
)
LAB_MAP = rownames(LABS)
names(LAB_MAP) = LABS$label
