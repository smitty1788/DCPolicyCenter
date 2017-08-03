# Analysis of Building CO2 Emissions in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith


# Import arcpy module
import arcpy

# Local variables:
Building_Footprints = "~\Carbon Emmisions\Data\Spatial\Building_Footprints\Building_Footprints.shp"
Common_Ownership_Lots = "~\Carbon Emmisions\Data\Spatial\Common_Ownership_Lots\Common_Ownership_Lots.shp"
emissions_point_data = "~\Carbon Emmisions\Data\Spatial\Carbon.gdb\emissions"
common_plot = "~\Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot"
building_co2 = "~\Carbon Emmisions\Data\Spatial\Carbon.gdb\building_co2"
CO2_Emit_Buildings_shp = "~\Carbon Emmisions\Data\Spatial\Web\Buildings\CO2_Emit_Buildings.shp"

# Spatial Join Building points to common plots
arcpy.SpatialJoin_analysis(Common_Ownership_Lots, emissions_point_data, common_plot, 
"JOIN_ONE_TO_ONE", "KEEP_ALL", "OBJECTID \"OBJECTID\" true true false 10 Long 0 10 ,First,#,
Common_Ownership_Lots,OBJECTID,-1,-1;PROPERTYNAME \"PROPERTYNAME\" true true false 8000 Text 0 0 ,First,#,emissions,PROPERTYNAME,
-1,-1;OWNEROFRECORD \"OWNEROFRECORD\" true true false 8000 Text 0 0 ,First,#,emissions,OWNEROFRECORD,-1,
-1;YEARBUILT \"YEARBUILT\" true true false 8000 Text 0 0 ,First,#,emissions,YEARBUILT,-1,-1;ENERGYSTARSCORE \"ENERGYSTARSCORE\" true true false 8000 Text 0 0 ,First,#,emissions,ENERGYSTARSCORE,-1,
-1;Metrictons \"Metrictons\" true true false 8 Double 0 0 ,Sum,#,emissions,Metrictons,-1,
-1;KGsqft \"KGsqft\" true true false 8 Double 0 0 ,Sum,#,emissions,KGsqft,-1,-1", "INTERSECT", "", "")

# Spatial Join common plots to building footprints
arcpy.SpatialJoin_analysis(Building_Footprints, common_plot, building_co2, 
"JOIN_ONE_TO_ONE", "KEEP_ALL", "OBJECTID \"OBJECTID\" true true false 10 Long 0 10 ,First
,#,Building_Footprints,OBJECTID,-1,-1;PROPERTYNAME \"PROPERTYNAME\" true true false 8000 Text 0 0 ,First,#,
~\Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,PROPERTYNAME,-1,-1;OWNEROFRECORD \"OWNEROFRECORD\" true true false 8000 Text 0 0 ,
First,#,~Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,OWNEROFRECORD,-1,-1;YEARBUILT \"YEARBUILT\" true true false 8000 Text 0 0 ,
First,#,~Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,YEARBUILT,-1,-1;ENERGYSTARSCORE \"ENERGYSTARSCORE\" true true false 8000 Text 0 0 ,First,#,
~\Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,ENERGYSTARSCORE,-1,-1;Metrictons \"Metrictons\" true true false 8 Double 0 0 ,First,#,
~\Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,Metrictons,-1,-1;KGsqft \"KGsqft\" true true false 8 Double 0 0 ,First,#,
~\Carbon Emmisions\Data\Spatial\Carbon.gdb\common_plot,KGsqft,-1,-1", "INTERSECT", "", "")

# Filter only buildings with emissions data
arcpy.SelectLayerByAttribute_management(building_co2, "NEW_SELECTION", "Metrictons IS NOT NULL")

# Export shapefile for webmap
arcpy.CopyFeatures_management(building_co2, CO2_Emit_Buildings_shp, "", "0", "0", "0")