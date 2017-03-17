
# Python script to aggregate census tract data to neighborhoods.



import arcpy


# Local variables:
Neighborhood_Clusters = "Neighborhood_Clusters"
Census_Tract = "Census_Tract"
CT_EA_Income = Census_Tract
CT_EA_Income_ = "G:\\DC Policy Center\\Educational Attainment\\Data\\Tab\\Tidy\\CT_EA_Income.xlsx\\CT_EA_Income$"
CT_EA_INC = "G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC"
CT_EA_INC_Points = "G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points"
NHB_EA_INC = "G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\NHB_EA_INC"


# Table join xlsx file to shapefile
arcpy.AddJoin_management(Census_Tract, "GEOID", CT_EA_Income_, "GEOID", "KEEP_ALL")

# Save table join to new shapefile 
arcpy.CopyFeatures_management(CT_EA_Income, CT_EA_INC, "", "0", "0", "0")

# Convert Census Tracts to points
arcpy.FeatureToPoint_management(CT_EA_INC, CT_EA_INC_Points, "CENTROID")

# Spatial Join to aggregate data to neighborhoods
arcpy.SpatialJoin_analysis(Neighborhood_Clusters, CT_EA_INC_Points, NHB_EA_INC, "JOIN_ONE_TO_ONE", "KEEP_ALL", "OBJECTID \"OBJECTID\" true true false 10 Long 0 10 ,First,#,Neighborhood_Clusters,OBJECTID,-1,-1;WEB_URL \"WEB_URL\" true true false 80 Text 0 0 ,First,#,Neighborhood_Clusters,WEB_URL,-1,-1;NAME \"NAME\" true true false 80 Text 0 0 ,First,#,Neighborhood_Clusters,NAME,-1,-1;NBH_NAMES \"NBH_NAMES\" true true false 97 Text 0 0 ,First,#,Neighborhood_Clusters,NBH_NAMES,-1,-1;SHAPE_Leng \"SHAPE_Leng\" true true false 24 Double 15 23 ,First,#,Neighborhood_Clusters,SHAPE_Leng,-1,-1;SHAPE_Area \"SHAPE_Area\" true true false 24 Double 15 23 ,First,#,Neighborhood_Clusters,SHAPE_Area,-1,-1;Census_Tract_GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_GEOID,-1,-1;Census_Tract_NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_NAMELSAD,-1,-1;Census_Tract_ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_ALAND,-1,-1;Census_Tract_AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_AWATER,-1,-1;Census_Tract_INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_INTPTLAT,-1,-1;Census_Tract_INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_INTPTLON,-1,-1;Census_Tract_N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_N_Cluster,-1,-1;Census_Tract_N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,Census_Tract_N_Name,-1,-1;GEOID \"GEOID\" true true false 255 Text 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__GEOID,-1,-1;Total_15 \"Total_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_15,-1,-1;P_Bach_15 \"P_Bach_15\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_15,-1,-1;Total_09 \"Total_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_09,-1,-1;P_Bach_09 \"P_Bach_09\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_09,-1,-1;D_Total \"D_Total\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Total,-1,-1;Bach_15 \"Bach_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_15,-1,-1;Bach_09 \"Bach_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_09,-1,-1;D_Bach \"D_Bach\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Bach,-1,-1;C_Bach \"C_Bach\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Bach,-1,-1;C_P_Bach \"C_P_Bach\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_P_Bach,-1,-1;Total_white_15 \"Total_white_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_white_15,-1,-1;P_Bach_white_15 \"P_Bach_white_15\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_white_15,-1,-1;Total_white_09 \"Total_white_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_white_09,-1,-1;P_Bach_white_09 \"P_Bach_white_09\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_white_09,-1,-1;D_Total_white \"D_Total_white\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Total_white,-1,-1;Bach_white_15 \"Bach_white_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_white_15,-1,-1;Bach_white_09 \"Bach_white_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_white_09,-1,-1;D_Bach_white \"D_Bach_white\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Bach_white,-1,-1;C_Bach_white \"C_Bach_white\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Bach_white,-1,-1;C_P_Bach_white \"C_P_Bach_white\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_P_Bach_white,-1,-1;Total_black_15 \"Total_black_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_black_15,-1,-1;P_Bach_black_15 \"P_Bach_black_15\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_black_15,-1,-1;Total_black_09 \"Total_black_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_black_09,-1,-1;P_Bach_black_09 \"P_Bach_black_09\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_black_09,-1,-1;D_Total_black \"D_Total_black\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Total_black,-1,-1;Bach_black_15 \"Bach_black_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_black_15,-1,-1;Bach_black_09 \"Bach_black_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_black_09,-1,-1;D_Bach_black \"D_Bach_black\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Bach_black,-1,-1;C_Bach_black \"C_Bach_black\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Bach_black,-1,-1;C_P_Bach_black \"C_P_Bach_black\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_P_Bach_black,-1,-1;Total_asian_15 \"Total_asian_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_asian_15,-1,-1;P_Bach_asian_15 \"P_Bach_asian_15\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_asian_15,-1,-1;Total_asian_09 \"Total_asian_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_asian_09,-1,-1;P_Bach_asian_09 \"P_Bach_asian_09\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_asian_09,-1,-1;D_Total_asian \"D_Total_asian\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Total_asian,-1,-1;Bach_asian_15 \"Bach_asian_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_asian_15,-1,-1;Bach_asian_09 \"Bach_asian_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_asian_09,-1,-1;D_Bach_asian \"D_Bach_asian\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Bach_asian,-1,-1;C_Bach_asian \"C_Bach_asian\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Bach_asian,-1,-1;C_P_Bach_asian \"C_P_Bach_asian\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_P_Bach_asian,-1,-1;Total_hisp_15 \"Total_hisp_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_hisp_15,-1,-1;P_Bach_hisp_15 \"P_Bach_hisp_15\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_hisp_15,-1,-1;Total_hisp_09 \"Total_hisp_09\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Total_hisp_09,-1,-1;P_Bach_hisp_09 \"P_Bach_hisp_09\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__P_Bach_hisp_09,-1,-1;D_Total_hisp \"D_Total_hisp\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Total_hisp,-1,-1;Bach_hisp_15 \"Bach_hisp_15\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_hisp_15,-1,-1;Bach_hisp_09 \"Bach_hisp_09\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__Bach_hisp_09,-1,-1;D_Bach_hisp \"D_Bach_hisp\" true true false 8 Double 0 0 ,Sum,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Bach_hisp,-1,-1;C_Bach_hisp \"C_Bach_hisp\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Bach_hisp,-1,-1;C_P_Bach_hisp \"C_P_Bach_hisp\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_P_Bach_hisp,-1,-1;MHI_ALL_15 \"MHI_ALL_15\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__MHI_ALL_15,-1,-1;MHI_ALL_09 \"MHI_ALL_09\" true true false 8 Double 0 0 ,Mean,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__MHI_ALL_09,-1,-1;D_Income \"D_Income\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__D_Income,-1,-1;C_Income \"C_Income\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,CT_EA_Income__C_Income,-1,-1;ORIG_FID \"ORIG_FID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Educational Attainment\\Data\\Spatial Data\\Education.gdb\\CT_EA_INC_Points,ORIG_FID,-1,-1", "INTERSECT", "", "")




# Recalulate Percent Changes and Total differences between 2009 
# and 2015 at the Neighborhood cluster resolution


# Process: Calculate Field
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_15", "[Bach_15] / [Total_15] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_09", "[Bach_09] /  [Total_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Total", "[Total_15] - [Total_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Bach", "[Bach_15] - [Bach_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_Bach", "( [Bach_15] - [Bach_09]) / [Bach_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_P_Bach", "( [P_Bach_15] - [P_Bach_09]) / [P_Bach_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_white_15", "[Bach_white_15] / [Total_white_15] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_white_09", "[Bach_white_09] / [Total_white_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Total_white", "[Total_white_15] - [Total_white_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Bach_white", "[Bach_white_15] - [Bach_white_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_Bach_white", "( [Bach_white_15] - [Bach_white_09]) / [Bach_white_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_P_Bach_white", "( [P_Bach_white_15] - [P_Bach_white_09]) / [P_Bach_white_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_black_15", "[Bach_black_15] / [Total_black_15] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_black_09", "[Bach_black_09] / [Total_black_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Total_black", "[Total_black_15] - [Total_black_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Bach_black", "[Bach_black_15] - [Bach_black_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_Bach_black", "( [Bach_black_15] - [Bach_black_09]) / [Bach_black_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_P_Bach_black", "( [P_Bach_black_15] - [P_Bach_black_09]) / [P_Bach_black_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_asian_15", "[Bach_asian_15] / [Total_asian_15] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_asian_09", "[Bach_asian_09] / [Total_asian_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Total_asian", "[Total_asian_15] - [Total_asian_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Bach_asian", "[Bach_asian_15] - [Bach_asian_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_Bach_asian", "( [Bach_asian_15] - [Bach_asian_09]) / [Bach_asian_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_P_Bach_asian", "( [P_Bach_asian_15] - [P_Bach_asian_09]) / [P_Bach_asian_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_hisp_15", "[Bach_hisp_15] / [Total_hisp_15] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "P_Bach_hisp_09", "[Bach_hisp_09] / [Total_hisp_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Total_hisp", "[Total_hisp_15] - [Total_hisp_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "D_Bach_hisp", "[Bach_hisp_15] - [Bach_hisp_09]", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_Bach_hisp", "( [Bach_hisp_15] - [Bach_hisp_09]) / [Bach_hisp_09] * 100", "VB", "")

# Process: Calculate Field 
arcpy.CalculateField_management(NHB_EA_INC, "C_P_Bach_hisp", "( [P_Bach_hisp_15] - [P_Bach_hisp_09]) / [P_Bach_hisp_09] * 100", "VB", "")



