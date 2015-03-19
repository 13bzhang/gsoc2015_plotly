# GOOGLE SUMMER OF CODE TEST
# Baobao Zhang
# baobao.zhang@yale.edu

# packages
library(plotly)
library(ggplot2)
library(rjson)
library(testthat)

# directory
#setwd("~/Dropbox/summer_of_code/plotly")

# credentials
py <- plotly("XXX", "XXX")

# Test 1: Make a plot
p <- ggplot(Orange, aes(age, circumference)) + 
  geom_point()
ggsave(filename = "zhang_baobao_myplot.png", width = 6, height=4)
py <- plotly()
py$ggplotly()

# Test 2: Construct the JSON file manually

# construct the data portion
data <- list(
  x = as.numeric(Orange$age),
  y = as.numeric(Orange$circumference),
  mode = "markers",
  marker = list(
    color = as.character("rgb(0,0,0)"), 
    size = 10L, 
    symbol = as.character("circle"), 
    opacity = 1L, 
    sizeref = 1L, 
    sizemode = as.character("area")),
  xaxis = "x1",
  yaxis = "y1",
  showlegend = FALSE,
  type = as.character("scatter")
)

# construct the layout portion
layout <- list(
  titlefont = list(family = ""), 
  showlegend = FALSE, 
  xaxis = list(
  title = "age", 
  type = "linear", 
  showgrid = TRUE, 
  zeroline = FALSE, 
  showline = FALSE, 
  ticks = "outside", 
  showticklabels = TRUE, 
  tickcolor = "rgb(127,127,127)", 
  gridcolor = "rgb(255,255,255)"
  ), 
  yaxis = list(
    title = "circumference", 
    type = "linear", 
    showgrid = TRUE, 
    zeroline = FALSE, 
    showline = FALSE, 
    ticks = "outside", 
    showticklabels = TRUE, 
    tickcolor = "rgb(127,127,127)", 
    gridcolor = "rgb(255,255,255)"
  ), 
  legend = list(
    x = 1.05, 
    y = 0.5, 
  font = list(
    family = ""
  ), 
  bgcolor = "rgb(255,255,255)", 
  bordercolor = "transparent", 
  xanchor = "center", 
  yanchor = "top"
  ), 
  margin = list("r" = 10), 
  paper_bgcolor = "rgb(255,255,255)", 
  plot_bgcolor = "rgb(229,229,229)"
)

# send it up to plot.ly 
myjson.plot.ly <-
  py$plotly(data, 
            kwargs=list(layout=layout))
myjson.plot.ly$url

# Test 3: testthat
L <- gg2list(p) 
test_that("check the features of my plot", {
  expect_equal(length(L), 2) # length of the list
  expect_identical(L[[1]]$x, Orange$age) # x variable
  expect_identical(L[[1]]$y, Orange$circumference) # y variable
  expect_identical(L[[1]]$type, "scatter") # graph type
  expect_identical(L[[2]]$layout$xaxis$title, "age") # x-axis title
  expect_identical(L[[2]]$layout$yaxis$title, "circumference") # y-axis title
})