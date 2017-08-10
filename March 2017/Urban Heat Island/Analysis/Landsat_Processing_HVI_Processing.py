# Import arcpy module
import arcpy

# Local variables:
Band_10 = "LC08_L1TP_015033_20150817_20170226_01_T1_B10.TIF"
Band_11 = "LC08_L1TP_015033_20150817_20170226_01_T1_B11.TIF"
B10_Rad = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B10_Rad.tif"
B10_Temp = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B10_Temp.tif"
B11_Rad = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B11_Rad.tif"
B11_Temp = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B11_Temp.tif"
Final_Temperature = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_08_17_2015"
final_temp_clip = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\DC_Temp_08_17_15"
Census_Tract = "Census_Tract"
Temp_Vector = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_Points"
Neighborhood_Clusters = "Neighborhood_Clusters"
Temp_Vector_clip = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_Point_Extract"
Tract_Temp_Avg = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\CT_Temp_AVG"


# Band 10 to Radiance
arcpy.gp.RasterCalculator_sa("0.0003342 * " B10 " + 0.1", B10_Rad)
# Band 11 to Radiance
arcpy.gp.RasterCalculator_sa("0.0003342 * " B11 " + 0.1", B11_Rad)

# Band 10 Radiance to Temperature
arcpy.gp.RasterCalculator_sa("1321.08 / ln(774.89 / " B10_Rad " + 1) - 272.15", B10_Temp)
# Band 11 Radiance to Temperature
arcpy.gp.RasterCalculator_sa("1201.14 / ln(480.89 / " B11_Rad " + 1) - 272.15", B11_Temp)

# Clip Raster to DC Borders
arcpy.Clip_management(Temp_08_17_2015, "315900.112287067 4295387.04892389 334646.204049099 4318452.90089353", final_temp_clip, Census_Tract, "", "NONE", "NO_MAINTAIN_EXTENT")

# Convert Raster to Point Data
arcpy.RasterToPoint_conversion(final_temp_clip, Temp_Vector, "Value")

# Clip point data to exclude water features
arcpy.Clip_analysis(Temp_Vector, Neighborhood_Clusters, Temp_Vector_clip, "")

# Aggregate and Average temperatures by Census Tract
arcpy.SpatialJoin_analysis(Census_Tract, Temp_Vector_clip, Tract_Temp_Avg, "JOIN_ONE_TO_ONE", "KEEP_ALL", "GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,Census_Tract,GEOID,-1,-1;NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,Census_Tract,NAMELSAD,-1,-1;ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,Census_Tract,ALAND,-1,-1;AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,Census_Tract,AWATER,-1,-1;INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,Census_Tract,INTPTLAT,-1,-1;INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,Census_Tract,INTPTLON,-1,-1;N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Cluster,-1,-1;N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Name,-1,-1;Temp \"Temprature\" true true false 50 Double 0 0 ,Mean,#", "INTERSECT", "", "")




