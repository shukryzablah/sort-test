#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(readr)

Runs_raw <- read_csv("results-all.out", col_names = FALSE)
names(Runs_raw) <- c("algorithm", "length", "range", "repetitions", "time_ns", "displacement")

Runs_processed <- Runs_raw %>%
    mutate(time_us = time_ns / 10e3)


toPlot <- Runs_processed %>% select(algorithm, displacement, length, time_us) %>%
    group_by(algorithm, displacement, length) %>%
    summarize(avg = mean(time_us))


lengths <- unique(toPlot$length)

for(i in lengths)
{
	temp <- toPlot %>% filter(length == i)
	plot <- ggplot(temp, aes(x = displacement, y = avg, color = algorithm, linetype = algorithm)) +
    geom_line(size = 0.5) +
    labs(x = "Displacement (bytes)",
         y = "Time Elapsed during Sort (n=us)",
         title = "Runtime Comparisons of Sorting Algorithms")

    iString <- toString(i)

    ggsave(paste("length_",iString,".png", sep = ""), plot)

}
