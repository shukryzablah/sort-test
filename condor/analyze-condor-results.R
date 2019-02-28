#!/usr/bin/env Rscript

library(dplyr) # dataframe manipulation
library(ggplot2) # plotting
library(readr) # work with csv files
library(purrr) # mapping functions

## read the file and fixes column names
runs <- read_csv("./results-all.out",
                 col_names = c("algorithm", "length", "range", "iteration", "runtime", "envsize"))

## fix types e.g. iteration isn't continous it should be discrete
runs <- runs %>% # %>% is a pipe
    mutate(length = as.factor(length), iteration = as.factor(iteration)) 

## function will take a given length
## and create a plot that visualizes the runtime vs the iteration number
generate_iteration_runtime_plot <- function(len) {
    filtered_runs <- runs %>% filter(length == len)
    plot <- ggplot(data = filtered_runs,
                   mapping = aes(x = iteration, y = runtime)) +
        geom_boxplot() +
        geom_jitter(alpha = 0.1, size = 0.1) +
        labs(title = paste0("Runtime vs Iteration Number for Length ", len," (all envsize)"))
    dir_name = "./plots/"
    file_name = paste0("iteration_runtime_length", len, ".png")
    ggsave(paste0(dir_name, file_name))
}

## walks all the lengths with the plot function above
lens <- unique(runs$length) 
lens %>%
    walk(generate_iteration_runtime_plot) 








