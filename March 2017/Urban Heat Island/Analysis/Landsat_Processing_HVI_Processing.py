

# Import arcpy module
import arcpy


# Local variables:
Census_Tract = "Census_Tract"
Health_ = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Tab\\Tidy\\DC_Health.xlsx\\Health$"
Combined_ = "G:\\DC Policy Center\\2015 Demographic Model\\2015 Demographic Model.xlsx\\Combined$"
DC_CT_Demo = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\DC_CT_Demo"
B11 = "LC08_L1TP_015033_20150817_20170226_01_T1_B11.TIF"
B10 = "LC08_L1TP_015033_20150817_20170226_01_T1_B10.TIF"
B10_Rad = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B10_Rad.tif"
B10_Temp = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B10_Temp.tif"
B11_Rad = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B11_Rad.tif"
B11_Temp = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\B11_Temp.tif"
Temp_08_17_2015 = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_08_17_2015"
DC_Temp_08_17_15 = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\DC_Temp_08_17_15"
Temp_Points = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_Points"
Neighborhood_Clusters = "Neighborhood_Clusters"
Temp_Point_Extract = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\Temp_Point_Extract"
CT_Temp_AVG = "G:\\DC Policy Center\\Urban Heat Island\\Data\\Spatial Data\\Heat_Island.gdb\\CT_Temp_AVG"




# Process: Raster Calculator
arcpy.gp.RasterCalculator_sa("0.0003342 * "B10" + 0.1", B10_Rad)

# Process: Raster Calculator
arcpy.gp.RasterCalculator_sa("0.0003342 * "B11" + 0.1", B11_Rad)


# Process: Raster Calculator
arcpy.gp.RasterCalculator_sa("1321.08 / ln(774.89 / "B10_Rad" + 1) - 272.15", B10_Temp)

# Process: Raster Calculator
arcpy.gp.RasterCalculator_sa("1321.08 / ln(774.89 / "B11_Rad" + 1) - 272.15", B11_Temp)

# Process: Cell Statistics
arcpy.gp.CellStatistics_sa("b11_temp;b10_temp", Temp_08_17_2015, "MEAN", "DATA")

# Process: Clip
arcpy.Clip_management(Temp_08_17_2015, "315900.112287067 4295387.04892389 334646.204049099 4318452.90089353", DC_Temp_08_17_15, Census_Tract, "", "NONE", "NO_MAINTAIN_EXTENT")

# Process: Raster to Point
arcpy.RasterToPoint_conversion(DC_Temp_08_17_15, Temp_Points, "Value")

# Process: Clip (2)
arcpy.Clip_analysis(Temp_Points, Neighborhood_Clusters, Temp_Point_Extract, "")

# Process: Spatial Join
arcpy.SpatialJoin_analysis(Census_Tract, Temp_Point_Extract, CT_Temp_AVG, "JOIN_ONE_TO_ONE", "KEEP_ALL", "GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,Census_Tract,GEOID,-1,-1;NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,Census_Tract,NAMELSAD,-1,-1;ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,Census_Tract,ALAND,-1,-1;AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,Census_Tract,AWATER,-1,-1;INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,Census_Tract,INTPTLAT,-1,-1;INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,Census_Tract,INTPTLON,-1,-1;N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Cluster,-1,-1;N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Name,-1,-1;Temp \"Temprature\" true true false 50 Double 0 0 ,Mean,#", "INTERSECT", "", "")

# Process: Add Join
arcpy.AddJoin_management(CT_Temp_AVG, "GEOID", Health_, "GEOID", "KEEP_ALL")

# Process: Add Join (2)
arcpy.AddJoin_management(CT_Temp_AVG__3_, "GEOID", Combined_, "GEOID", "KEEP_ALL")

# Process: Copy Features
arcpy.CopyFeatures_management(CT_Temp_AVG__4_, DC_CT_Demo, "", "0", "0", "0")



