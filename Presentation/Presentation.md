Life Expectancy 
========================================================
author: Fenton Taylor
date: 01/01/2017
autosize: true

Introduction
========================================================
This app was developed as a final project for the Developing Data Products module of
the Data Science Specialization by Johns Hopkins University on
[Coursera.org](https://www.coursera.org).

The app was built using [Shiny](https://shiny.rstudio.com/) in [RStudio](https://www.rstudio.com/).

The interactive app takes user input and displays a plot and summary statistics for the selected input.

The Data
========================================================
The data the app uses comes from [worldbank.org](http://data.worldbank.org/indicator/SP.DYN.LE00.IN). The dataset
contains life expectancy estimates for 264 countries and geographic regions from 1960 
to 2014. Here is a small sample of the dataset:


```
    Country.Name Country.Code    X1960    X1961    X1962    X2012    X2013
1          Aruba          ABW 65.56937 65.98802 66.36554 75.20576 75.32866
28        Brazil          BRA 54.20546 54.71871 55.23566 73.83959 74.12244
34        Canada          CAN 71.13317 71.34610 71.36707 81.56244 81.76505
53       Germany          DEU 69.31295 69.50995 69.69251 80.89268 80.84390
56       Denmark          DNK 72.17659 72.43829 72.31976 80.05122 80.30000
70      Ethiopia          ETH 38.40571 39.06915 39.69866 62.79354 63.44220
73       Finland          FIN 68.81976 68.84415 68.57780 80.62683 80.97561
203 Saudi Arabia          SAU 45.66627 46.17439 46.69451 74.01602 74.17763
264     Zimbabwe          ZWE 51.54246 51.91495 52.27790 53.64307 55.63300
       X2014
1   75.45110
28  74.40188
34  81.95661
53  80.84390
56  80.54878
70  64.03502
73  81.12927
203 74.33722
264 57.49832
```


The App
========================================================
The Life Expectancy app allows the user to select 1 or 2 countries/regions to view and 
compare estimated life expectancy as it changes over time. The selected data is plotted using 
[ggplot2](http://ggplot2.org/). The user also has the option to toggle points of interest and world average life expectancy line on and off. Here is an example:
<a href="http://imgur.com/zoa8xkg"><img src="http://i.imgur.com/zoa8xkg.png" title="source: imgur.com" /></a>

Try It For Yourself!
========================================================
Interested in trying the app for yourself? Click the following link to run the app 
on the ShinyApps server.
###[Life Expectancy App](https://fentontaylor.shinyapps.io/finalproject/)

If you would like to view the source code for the app or this presentation, you can check out the following GitHub repos.
- [ui.R and server.R files for the shiny app](https://github.com/fentontaylor/DevelopingDataProducts/tree/gh-pages/FinalProject)
- [RPresentation document]()
