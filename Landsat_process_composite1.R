# LANDSAT DATA PROCESSING

# load packages
library(raster)

#set working directory
setwd('J:/Backup_main/2023/20220607_Bkt_Merah_drought/Analysis/Landsat')

#set path to Landsat tif
path_tif <- 'C:/Users/ycgoh/Documents/GIS DataBase/LC08_L2SP_128056_20220406_20220412_02_T1/'

B2 = raster(paste0(path_tif, "LC08_L2SP_128056_20220406_20220412_02_T1_SR_B2.TIF"))
B3 = raster(paste0(path_tif, "LC08_L2SP_128056_20220406_20220412_02_T1_SR_B3.TIF"))
B4 = raster(paste0(path_tif, "LC08_L2SP_128056_20220406_20220412_02_T1_SR_B4.TIF"))

# composite RGB
rgb_map = stack(B4, B3, B2)

# plot
#plotRGB(rgb_map, scale = 65535)
plotRGB(rgb_map, axes = TRUE, stretch = "lin", main = "Landsat True Color Composite")


##########
# IMAGE INFORMATION

# coordinate reference system (CRS)
crs(B2)

# Number of cells, rows, columns
ncell(B2)

# Dimensions  nrow, ncol, nbands
dim(B2)

# spatial resolution
res(B2)

# Number of bands
nlayers(B2)

# Do the bands have the same extent, number of rows and columns, projection, resolution, and origin
compareRaster(B2, B3)


##########
# VISUALIZE SINGLE BAND IMAGE

plot(B2, main = "Blue", col = gray(0:100 / 100))

plot(stretch(B2, minq = 0.1, maxq = 0.9), main = "Blue", col = gray(0:100 / 100))

plot(stretch(B3, minq = 0.1, maxq = 0.9), main = "Green", col = gray(0:100 / 100))

plot(stretch(B4, minq = 0.1, maxq = 0.9), main = "Red", col = gray(0:100 / 100))


##########
# CROP TO EXTENT

# find raster extent
extent(rgb_map)

# set boundary
boundary = raster(ymx = 562000, xmn = 680500, ymn = 549500, xmx = 690500)

#boundary = projectExtent(boundary, rgb_map@crs)


# crop raster
map_crop = crop(rgb_map, boundary)


# plot
#plotRGB(map_crop)
plotRGB(map_crop, axes = TRUE, stretch = "lin", main = "Landsat True Color Composite")


# save raster as tif
writeRaster(map_crop, filename="EBM_20220406.tif", overwrite=TRUE)
