# Import arcpy module
import arcpy


# Local variables:
DC_Bars_and_Clubs = "Alcohol"
Output_direction_raster = ""
Universities_and_Colleges = "Unis"
Output_direction_raster__2_ = ""
DC_Parks = "Parks"
Output_direction_raster__3_ = ""
Natl_parks = "Natl_parks"
Output_direction_raster__4_ = ""
Distance_to_Nationals_Parks = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\Dist_NatP"
Reclassed_Distances_to_National_parks = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_NP"
Distance_for_Bars_and_Clubs = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\Dist_Alco"
Reclassed_Distance_to_Bars_and_Clubs = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Alco"
Distance_to_Universities_and_Colleges = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\Dist_Uni"
Reclassed_Distance_to_Universities_and_Colleges = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Uni"
Distance_to_Parks = "C:\\Users\\smithr\\Documents\\ArcGIS\\Default.gdb\\Dist_Park"
Reclassed_Distance_to_Parks = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Park"
Risk_Terrain_Model = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\RTM_Day"
RTM_to_Polygon = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\RTM_DAY"
DC_Boundary = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\BG_Incidents"
RTM_for_Carto = "G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\RTM_Day_Clipped"

# Set Geoprocessing environments
arcpy.env.snapRaster = "BARE_EARTH_2014"
arcpy.env.extent = "389400 124200 408600 147612"
arcpy.env.cellSize = "20"
arcpy.env.mask = "BARE_EARTH_2014"

# Process: Euclidean Distance
arcpy.gp.EucDistance_sa(DC_Bars_and_Clubs, Distance_for_Bars_and_Clubs, "", "20", Output_direction_raster)
arcpy.gp.EucDistance_sa(Universities_and_Colleges, Distance_to_Universities_and_Colleges, "", "20", Output_direction_raster__2_)
arcpy.gp.EucDistance_sa(DC_Parks, Distance_to_Parks, "", "20", Output_direction_raster__3_)
arcpy.gp.EucDistance_sa(Natl_parks, Distance_to_Nationals_Parks, "", "20", Output_direction_raster__4_)

# Process: Reclassify
arcpy.gp.Reclassify_sa(Distance_to_Nationals_Parks, "Value", "0 100 10;100 200 9;200 300 8;300 400 7;400 500 6;500 600 5;600 700 4;700 800 3;800 900 2;900 3012.30810546875 1", Reclassed_Distances_to_National_parks, "DATA")
arcpy.gp.Reclassify_sa(Distance_for_Bars_and_Clubs, "Value", "0 100 10;100 200 9;200 300 8;300 400 7;400 500 6;500 600 5;600 700 4;700 800 3;800 900 2;900 4638.62060546875 1", Reclassed_Distance_to_Bars_and_Clubs, "DATA")
arcpy.gp.Reclassify_sa(Distance_to_Universities_and_Colleges, "Value", "0 100 10;100 200 9;200 300 8;300 400 7;400 500 6;500 600 5;600 700 4;700 800 3;800 900 2;900 9051.7626953125 1", Reclassed_Distance_to_Universities_and_Colleges, "DATA")
arcpy.gp.Reclassify_sa(Distance_to_Parks, "Value", "0 100 10;100 200 9;200 300 8;300 400 7;400 500 6;500 600 5;600 700 4;700 800 3;800 900 2;900 4305.90283203125 1", Reclassed_Distance_to_Parks, "DATA")

# Process: Weighted Overlay
arcpy.gp.WeightedOverlay_sa("('G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_NP' 34 'Value' (1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9; 10 10;NODATA NODATA); 'G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Alco' 0 'Value' (1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9; 10 10;NODATA NODATA); 'G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Uni' 33 'Value' (1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9; 10 10;NODATA NODATA); 'G:\\DC Policy Center\\Crime Incidents\\Data\\Spatial\\RTM.gdb\\ReC_Park' 33 'Value' (1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9; 10 10;NODATA NODATA));1 10 1", Risk_Terrain_Model)

# Process: Raster to Polygon
arcpy.RasterToPolygon_conversion(Risk_Terrain_Model, RTM_to_Polygon, "SIMPLIFY", "VALUE")

# Process: Clip
arcpy.Clip_analysis(RTM_to_Polygon, DC_Boundary, RTM_for_Carto, "")

