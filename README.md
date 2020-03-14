*Live on [val-map.frclabs.com](http://val-map.frclabs.com)*
# Poor man's Tableau for stocks

#### Business case

Well-made plots allow us to see and comprehend much larger amounts of information than plain tables, and often reveal patterns that are otherwise hard to detect. For example, a 2000-row table with sector, growth and valuation (EV/Revenue) for every stock would be difficult to reason about. But once we plot that same data, it becomes apparent that, for example, REITs are massively more expensive than any other sector in terms of revenue multiples and have some of the weakest correlation between growth and valuation.

The app is updated weekly on Fridays after market close. After 12/31/2019 updates will stop, but the app will remain active, if only for demonstration purposes.


#### Key features

- effective and clean exploratory visualization of 4-dimensional feature space for nearly 2000 observations: two continuous measurements on two axes, market cap (continuous) using size, sector (categorical) using color
- user can choose from 8 metrics and assign them to the axes in any combination
- user can limit displayed subset by sector and market cap range
- user can zoom in/out on any interval of either axis in any combination
- covers all constituents of S&P 1500 except Financials and very small and/or unstable stocks, up to 1980 stocks depending on which metrics are chosen.


#### Design and code highlights

- largest non-trivial part was making sliders (their range, step size and units) respond to changes in all other controls, as every choice by user can alter ranges and units of the axes
- another interesting piece was designing a good representation for metrics (dimensions), such that new ones can be easily appended to a table and picked up by the app automatically, without changes to the core code. 
