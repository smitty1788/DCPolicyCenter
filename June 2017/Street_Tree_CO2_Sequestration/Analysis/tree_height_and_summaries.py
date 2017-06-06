# Analysis of Carbon Sequestration from Street Trees in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith


# Import arcpy module
import arcpy


# Local variables:
UFA_Street_Trees = "UFA_Street_Trees"
FIRST_RETURN_2004_tif = "FIRST_RETURN_2004.tif"
BARE_EARTH_2004_TIF = "BARE_EARTH_2004.TIF"
Heights = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Spatial\\Carbon_Sequest.gdb\\Heights"
Aggregate_20 = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Spatial\\Carbon_Sequest.gdb\\Aggregate_20"
tree_heights_20 = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Spatial\\Carbon_Sequest.gdb\\Tree_heights20"
c02_sequest_csv = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Tab\\Tidy\\c02_sequest.csv"
c02_sequest_Layer = "c02_sequest_Layer"
DC_Street_Tree = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Spatial\\Carbon_Sequest.gdb\\DC_Street_Tree"
Neighborhood_Aggregate = "Neighborhood_Aggregate"
co2_nhood_summary_csv = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Tab\\Tidy\\co2_nhood_summary.csv"
N_Hood_Tree_Aggregate = "G:\\DC Policy Center\\Carbon_Sequestration\\Data\\Spatial\\Carbon_Sequest.gdb\\N_Hood_Tree_Aggregate"

# Calculate heights base on difference between 1st return and bare earth LiDAR Data
arcpy.gp.RasterCalculator_sa("\"%FIRST_RETURN_2004.tif%\" - \"%BARE_EARTH_2004.TIF%\"", Heights)

# Resample to 20m spatial resolution
arcpy.gp.Aggregate_sa(Heights, Aggregate_20, "20", "MAXIMUM", "EXPAND", "DATA")

# Extract height to Tree shapefile from height raster
arcpy.gp.ExtractValuesToPoints_sa(UFA_Street_Trees, Aggregate_20, Tree_heights20, "NONE", "VALUE_ONLY")

# Process: Select Layer By Attribute
arcpy.SelectLayerByAttribute_management(tree_heights_20, "NEW_SELECTION", "RASTERVALU <= 2")
arcpy.CalculateField_management(tree_heights_20_, "RASTERVALU", "2", "VB", "")

# For low value height, convert to 2m
arcpy.SelectLayerByAttribute_management(tree_heights_20, "NEW_SELECTION", "RASTERVALU <= 0")
arcpy.CalculateField_management(tree_heights_20, "RASTERVALU", "2", "VB", "")

# For high value height, convert to 35m
arcpy.SelectLayerByAttribute_management(tree_heights_20, "NEW_SELECTION", "RASTERVALU >= 35")
arcpy.CalculateField_management(tree_heights_20, "RASTERVALU", "35", "VB", "")





# -----------------------------------------------------------------------------------------------------------------------------
# Neighborhood summaries and shapefile creation

# Create Shapefile for DC Street Trees
arcpy.MakeXYEventLayer_management(c02_sequest_csv, "long", "lat", c02_sequest_Layer, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")
arcpy.CopyFeatures_management(c02_sequest_Layer, DC_Street_Tree, "", "0", "0", "0")

# For common names "null", change to Other/Unknown
arcpy.SelectLayerByAttribute_management(DC_Street_Tree, "NEW_SELECTION", "CMMN_NM IS NULL")
arcpy.CalculateField_management(DC_Street_Tree, "CMMN_NM", "\"Other/Unknown\"", "VB", "")

# Join CO2 sequestartion table to Neighborhood Shapefile
arcpy.AddJoin_management(Neighborhood_Aggregate, "NAME", co2_nhood_summary_csv, "NAME", "KEEP_ALL")
arcpy.CopyFeatures_management(Neighborhood_Aggregate, N_Hood_Tree_Aggregate, "", "0", "0", "0")

# Add fields for Per capita/household statistics
arcpy.AddField_management(N_Hood_Tree_Aggregate, "kwh_capita", "DOUBLE", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")
arcpy.AddField_management(N_Hood_Tree_Aggregate, "kwh_household", "DOUBLE", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")
arcpy.AddField_management(N_Hood_Tree_Aggregate, "co2_capita", "DOUBLE", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")
arcpy.AddField_management(N_Hood_Tree_Aggregate, "co2_household", "DOUBLE", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")

# Calculate Per capita/household statistics
arcpy.CalculateField_management(N_Hood_Tree_Aggregate, "kwh_capita", "[co2_nhood_summary_csv_kwh_savings] / [Neighborhood_Aggregate_PopulationCount]", "VB", "")
arcpy.CalculateField_management(N_Hood_Tree_Aggregate, "kwh_household", "[co2_nhood_summary_csv_kwh_savings] / [Neighborhood_Aggregate_Total_Households]", "VB", "")
arcpy.CalculateField_management(N_Hood_Tree_Aggregate, "co2_capita", "[co2_nhood_summary_csv_co2_sequestered] / [Neighborhood_Aggregate_PopulationCount]", "VB", "")
arcpy.CalculateField_management(N_Hood_Tree_Aggregate, "co2_household", "[co2_nhood_summary_csv_co2_sequestered] / [Neighborhood_Aggregate_Total_Households]", "VB", "")


