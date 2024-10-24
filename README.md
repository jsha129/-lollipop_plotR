# lollipop_plotR
An easy way to represent mutations in a gene body using lollipop plots.

Example: 


![Alt](https://github.com/jsha129/lollipop_plotR/blob/main/my_fantastic_lolliplot.png)

Sites of mutations in a gene body are commonly represented as lollipop plots, which are essentially line plots with dots. The x-axis is often the gene structure including promoter(s), exons and introns whereas the height is usually the frequency of mutation in a cohort. This R script aims to aid scientists in automating graph generation which can be then modified in software such Adobe Illustrator for publication. An Excel file is provided to retrieve gene features (sheet: 'features') and information on each mutation (sheet: 'vaf').

Note: colours are pre-defined R colours. See: https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf
# How to use this?
1. Prepare 'feature' and 'vaf' sheets in the lolliplot_data.xlsx. Follow the template.
2. Install R and necessary packages (listed in the lollipop_plot.R). **You will only need to do this once.**
3. Run the R script. If all goes well, the script will export 'my_fantastic_lolliplot.pdf'

Good luck!

