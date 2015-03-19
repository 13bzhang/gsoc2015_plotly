# Tests for ggplotly

## Test 1
I made a ```ggplot2``` scatterplot using the ```Orange``` dataset and pushed it up to plot.ly. The .png file is in the repo. The plot.ly plot is here: https://plot.ly/~13bzhang/143/circumference-vs-age/

## Test 2
I manually constructed a list and converted it to a JSON file. I compared it with the JSON file from plot.ly [https://plot.ly/~13bzhang/143.json] and it is identical. But I was unable to plot to plot.ly with either my JSON file or the one I got from plot.ly. I will investigate what went wrong. 

## Test 3
I used ```testthat``` to test if salient features of my plot were correctly converted by the function ```gg2list```. The salient features were converted correctly. 
