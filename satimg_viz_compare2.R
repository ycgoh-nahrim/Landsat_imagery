# LANDSAT DATA PROCESSING

# load packages
library(raster)

#set working directory
setwd('J:/Backup_main/2023/20220607_Bkt_Merah_drought/Analysis/Landsat')

#get all tif in working dir
filename_list <- list.files(path = getwd(), pattern='tif$', full.names=TRUE)

#read tif as rasterstack (for multiband)
##if use raster to read, will only read first band
all_raster_list <- lapply(filename_list, stack)


#call single raster element
all_raster_list[[1]]

#to run a function on an individual raster e.g., plot 
plot(all_raster_list[[1]])


# RASTER INFO

#view coordinate reference system
all_raster_list[[1]]@crs

#view raster extent
all_raster_list[[1]]@extent

#check image resolution
res(all_raster_list[[1]])


##########
# PLOT RASTER (tmap)
#can plot but not show composite multiband raster


##########
# PLOT RASTER (rasterVis)
#unsuccessful


##########
# PLOT RASTER (ggplot)
#unsuccessful


##########
# PLOT RASTER (base)
#try with single plot

plot(all_raster_list[[1]])


# convert rasterstack to rasterbrick (actually no need)
landsat <- brick(all_raster_list[[2]])

# check rasterbrick properties
class(landsat)

names(landsat)

# extract name (date) of raster
landsat_date <- strsplit(names(landsat[[1]]), split = "_")[[1]][2]
landsat_date <- strsplit(landsat_date, split = "\\.")[[1]][1]


# plot


#landsat_s = stretch(landsat)

# clear plots
plot.new()

graphics.off()


# save `png` as filename
# must be before parameter setting
png("EBM_Landsat_test6.png", 
    width = 5, height = 6, units = "in", res = 300)


# set plot parameters
par(xpd = NA, # switch off clipping, necessary to always see axis labels
    bg = "transparent", # switch off background to avoid obscuring adjacent plots
    oma = c(2, 2, 0, 0), # move plot to the right and up
    mgp = c(2, 1, 0) # move axis labels closer to axis
) 

#adjust plot margins
# mar: line, mai: inch
# bottom, left, top, right
par("mai")
par(mai = c(0, 0, 0.2, 0))

# outer margin
# oma: line, omi: inch
par("omi")
par(omi = c(0, 0, 0, 0))



#plotRGB(landsat, axes = TRUE, stretch = "lin", main = "Landsat True Color Composite")

plotRGB(landsat, r = 1, g = 2, b = 3, asp = 1,
        stretch = "lin", margins = T, #axes = TRUE,
        #bgalpha = 0.5,
        scale = 1,   #highest value 31900
        cex.main = 0.8, # main title font size
        main = landsat_date)


dev.off()


##########
# PLOT MULTIPLE RASTER

# produce maps from raster

maplist <- list()

i = 1

for (i in 1:length(all_raster_list)) {
  
  # get date of img
  landsat_date <- strsplit(names(all_raster_list[[i]]), split = "_")[[1]][2]
  landsat_date <- strsplit(landsat_date, split = "\\.")[[1]][1]
  
  #adjust plot margins, parameters
  par(bg = "transparent", mai = c(0, 0, 0.2, 0), omi = c(0, 0, 0, 0))
  
  # plot
  plotRGB(all_raster_list[[i]], r = 1, g = 2, b = 3,
          stretch = "lin", margins = T, asp = 1, #axes = TRUE,
          scale = 1,   #highest value
          cex.main = 0.8, # main title font size
          main = landsat_date)
  
  # record plot
  ind_map <- recordPlot()
  
  
  # add plot to list
  maplist[[i]] <- ind_map
  
  # clear plot
  dev.off()

  
}


##########
# SAVE EACH MAP TO FILE


j = 1

for (j in 1:length(all_raster_list)) {
  
  # get date of img
  landsat_date <- strsplit(names(all_raster_list[[j]]), split = "_")[[1]][2]
  landsat_date <- strsplit(landsat_date, split = "\\.")[[1]][1]
  
  # clear plots
  plot.new()
  graphics.off()
  
  
  # save `png` as filename
  png(paste0("EBM_Landsat_", landsat_date, ".png"), 
      width = 5, height = 6, units = "in", res = 300)
  
  #adjust plot margins, background
  par(bg = "transparent", mai = c(0, 0, 0.2, 0), omi = c(0, 0, 0, 0))
  
  # plot
  plotRGB(all_raster_list[[j]], r = 1, g = 2, b = 3,
          stretch = "lin", margins = T, asp = 1, #axes = TRUE,
          scale = 1,   #highest value
          cex.main = 0.8, # main title font size
          main = landsat_date)
  
  # clear plot
  dev.off()
  
  
}



##########
# FACET MAPPING

library(cowplot)

# arrange layout


#dev.off()

# clear plots
plot.new()

graphics.off()


# save `png` as filename
png("EBM_Landsat_compare9.png", 
    width = 10, height = 6, units = "in", res = 300)


#adjust plot margins, background color parameters
par(bg = "transparent", mai = c(0, 0, 0, 0), omi = c(0, 0, 0, 0))



# plot multiple plots using plot_grid
plot_grid(plotlist = maplist[1:8], #scale = 1,
          #label_size = 8,
          #align = "v",
          #axis = "l", greedy = T,
          ncol = 4, nrow = 2
)

dev.off()


## alternative way to save grid plots

plot_all <- plot_grid(plotlist = maplist[1:8], #scale = 1,
                      #label_size = 8,
                      #align = "v",
                      #axis = "l", greedy = T,
                      ncol = 4, nrow = 2
                      )

save_plot("EBM_Landsat_compare10.png", plot_all, 
          base_asp = 0.9, #base_height = 7, base_width = 10, 
          ncol = 4, nrow = 2)



