# Process Landsat (multiband satellite imagery) data

For Landsat data download, check this video by Klas Karlsson <a href="https://youtu.be/M0bMUqpXkbU">QGIS User 0039 - Landsat 9</a>.

<h4>Landsat_process_composite1.R</h4>
This code imports multiband imagery in tif format and composite them into single tif. It also crops the imagery to a fixed area. Exports into single tif.
<br><br>
https://github.com/ycgoh-nahrim/Landsat_imagery/blob/main/EBM_20220406.tif
<br>
<h4>satimg_viz_compare2.R</h4>
This code imports all tif files in a folder, plot each according to date. All plots combined to show a faceted map for comparison.
<br><br>
<img src="https://github.com/ycgoh-nahrim/Landsat_imagery/blob/main/EBM_Landsat_compare10.png" alt="Landsat image comparison">
