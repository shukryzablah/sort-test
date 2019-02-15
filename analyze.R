#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(readr)

Runs_raw <- read_csv("test.csv", col_names = FALSE)
names(Runs_raw) <- c("algorithm", "length", "range", "repetitions", "time_ns")

Runs_processed <- Runs_raw %>%
    mutate(time_us = time_ns / 10e3)

toPlot <- Runs_processed %>%
    group_by(algorithm, length, range, repetitions) %>%
    summarize(avg = mean(time_us))

plot1 <- ggplot(toPlot, aes(x = length, y = avg, color = algorithm, linetype = algorithm)) +
    geom_line(size = 1.5) +
    labs(x = "Number of Elements in Array",
         y = "Time Elapsed during Sort (n=us)",
         title = "Runtime Comparisons of Sorting Algorithms")

ggsave("sample.png", plot1)
