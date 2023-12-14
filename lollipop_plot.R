## Run once
install.packages("readxl", dependencies =  T)
install.packages("tidyverse", dependencies =  T)

## INSTRUCTIONS:
# Ensure that the Rmd file and Excel file are in the same folder
# Provide "lolliplot_data.xlsx" file. The input file contains two sheets: 'features' for defining the features (promoter, exons, domains etc) and 'vaf' for drawing lollipops.
# 'features': defines features in ascending order.
# 'vaf': position on where to pin lollipops (all in amino acid, or the same unit as the 'features'). Height represents 'y' value or the %
# 
# Please ensure that only one 'colour' corrosponding to each 'type'. Ideally I would define ths in a separate sheet but it increase complexity.
# 
# 
# featureRectHeight: height of the rectangles drawn for features, in the same unit as % mutation.
# Please note that colours in both sheets are valid in-built R colours and they are case-sensitive. See page 3 of https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf

## --- START ----
library(readxl)
library(tidyverse)
data_file <- "lolliplot_data.xlsx"
features <- as.data.frame(read_xlsx(data_file, sheet = "features"))
featureRectHeight <- 10 # height of the feature
vaf_data <- as.data.frame(read_xlsx(data_file, sheet = "vaf"))



yMax <- signif(max(vaf_data$height), 1) + 10
xMax <- max(features$end) 


## start of the plot. Units are inches
pdf(file = "my_fantastic_lolliplot.pdf", height = 6, width = 10,
    useDingbats = F) # useDingbat = F is important. You may have difficulties while importing in Illustrator otherwise. 

plot(x = NULL,
     bty = "l", axes = F,
     xlab = "",
     xlim = c(min(features$start, features$end), xMax),
     ylim = c(-1*featureRectHeight, yMax),
     ylab = "% mutation")
axis(2, at = seq(0,yMax, 10) , labels =seq(0,yMax, 10))
axis(1, at = seq(0,xMax, 100), labels = seq(0,xMax, 100) )


## DRAW Feature rectangles
rect(features[, "start"], 0, features[, "end"], -featureRectHeight,
     col = features[, "colour"])
for(i in 1:nrow(features)){
  text(mean(c(features[i, "start"],features[i, "end"])), 
       -0.5 * featureRectHeight,
       labels = features[i, "feature"])
  
}


## draw each of the variants
mut_types <- unique(vaf_data$type)
my_type = "missense"
for(my_type in mut_types){
  temp <- vaf_data %>% dplyr::filter(type == my_type) %>% arrange(height)
  points(x = temp$position, y = temp$height,  pch = 19, col = temp$colour)
  arrows(temp$position, 0, 
         temp$position, temp$height,
         angle = 0,
         col = temp$colour)
  text(temp$position,  temp$height +1,
       labels  = temp$label,
       cex = 0.7,srt = 45,
       pos = 4,
       adj = 0,
       col = temp$colour)
  
}
dev.off()








