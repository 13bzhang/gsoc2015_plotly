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
py <- plotly("13bzhang", "x7x4awct1x")

# Test 1: Make a plot
p <- ggplot(Orange, aes(age, circumference)) + 
  geom_point()
ggsave(filename = "zhang_baobao_myplot.png", width = 6, height=4)
py <- plotly()
py$ggplotly()

# Test 2: Construct the JSON file manually

# construct the data portion
data <- data.frame(matrix(NA, 1, 8))
names(data) <- c("x", "y", "mode", "marker", "xaxis", 
                 "yaxis", "showlegend", "type")
data$x <- list(Orange$age)
data$y <- list(Orange$circumference)
data$mode <- "markers"
data$marker <- data.frame(stringsAsFactors = FALSE,
  color = as.character("rgb(0,0,0)"), 
  size = 10L, 
  symbol = as.character("circle"), 
  opacity = 1L, 
  sizeref = 1L, 
  sizemode = as.character("area")
)
data$xaxis = "x1" 
data$yaxis = "y1"
data$showlegend = FALSE
data$type = as.character("scatter")

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

# testing my manually constructed list with the real JSON list
myjson <- list(data=data, layout=layout) # my 
w <- fromJSON("https://plot.ly/~13bzhang/143.json") # real
all.equal(myjson, w) # my list is identical to list from plot.ly
# send it up to plot.ly: but there are some problems
py <- plotly("13bzhang", "x7x4awct1x")
py$plotly(toJSON(w)) # error message: "Expecting (x, y) pairs"
py$plotly(toJSON(myjson)) # error message: ""Expecting (x, y) pairs"

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