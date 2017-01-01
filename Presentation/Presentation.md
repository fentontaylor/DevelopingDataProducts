Life Expectancy App
========================================================
author: Fenton Taylor
date: January 1, 2017
autosize: true
font-family: 'Helvetica'

Introduction
========================================================
<small>This app was developed as a final project for the Developing Data Products module of
the Data Science Specialization by Johns Hopkins University on
[Coursera.org](https://www.coursera.org).

The app was built using [Shiny](https://shiny.rstudio.com/) in [RStudio](https://www.rstudio.com/).

The interactive app takes does the following:  
1. Takes user selection for 1 or 2 countries/regions and other options.  
2. Uses [ggplot2](http://ggplot2.org/) to plot change in life expectancy for the selected country.  
3. Displays tables of minimum, maximum, first, last, average, and overall changes in life expectancy.</small>

The Data
========================================================
The data the app uses comes from [worldbank.org](http://data.worldbank.org/indicator/SP.DYN.LE00.IN). The dataset
contains life expectancy estimates for 264 countries and geographic regions from 1960 
to 2014. Here is a small sample of the dataset:


```
   Country.Name    X1960    X1985    X2014
1         Aruba 65.56937 73.09798 75.45110
28       Brazil 54.20546 63.56256 74.40188
34       Canada 71.13317 76.30341 81.95661
56      Denmark 72.17659 74.42756 80.54878
```


Sample App Usage
========================================================
<small>Here the user has selected Ukraine and Turkey as the countries to compare, and has checked the boxes to display min/max points and the world average line. </small>
<img src="http://i.imgur.com/zoa8xkg.png" style="width:640px;height:471px;">

Try It For Yourself!
========================================================
Interested in trying the app for yourself? Click the following link to run the app 
on the ShinyApps server.  
<br>
<br>
<h3><a href="https://fentontaylor.shinyapps.io/finalproject">Life Expectancy App</a></h3>  
<br>
<br>
If you would like to view the source code for the app or this presentation, you can check out the following GitHub repos.  
* [ui.R and server.R files for the shiny app](https://github.com/fentontaylor/DevelopingDataProducts/tree/gh-pages/FinalProject)  
* [RPresentation document](https://github.com/fentontaylor/DevelopingDataProducts/tree/gh-pages/Presentation)
