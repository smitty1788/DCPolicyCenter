
#Hotspot Analysis of Parking Violations in DC in 2016

# Import arcpy module
import arcpy


# Local variables:
PV_2016_csv = "G:\\DC Policy Center\\Parking Violations\\Data\\Tab\\PV_2016.csv"
PV_2016_Layer = "PV_2016_Layer"
Parking_2016 = "G:\\DC Policy Center\\Parking Violations\\Data\\Spatial Data\\ParkingViolations.gdb\\Parking_2016"
DC_Boundary = "Block_Group"
Optimal_Hot_Spot = "G:\\DC Policy Center\\Parking Violations\\Data\\Spatial Data\\ParkingViolations.gdb\\Optimal_Hot_Spot"
Desnity_Surface = "G:\\DC Policy Center\\Parking Violations\\Data\\Spatial Data\\ParkingViolations.gdb\\Desnity_Surface"

# Process: Make XY Event Layer, display csv in ArcMap
arcpy.MakeXYEventLayer_management(PV_2016_csv, "x", "y", PV_2016_Layer, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Convert event layer to shapefile
arcpy.FeatureToPoint_management(PV_2016_Layer, Parking_2016, "CENTROID")

# Process: Optimized Hot Spot Analysis
arcpy.OptimizedHotSpotAnalysis_stats(Parking_2016, Optimal_Hot_Spot, "OBJECTID_1", "COUNT_INCIDENTS_WITHIN_FISHNET_POLYGONS", DC_Boundary, "", Desnity_Surface)

