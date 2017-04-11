

# Import arcpy module
import arcpy


# Local variables:
Census_Tract = "Census_Tract"
bike_csv = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\bike.csv"
bike = "bike"
bike__2_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\bike"
step1 = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1"
step1 = step1

car_csv = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\car.csv"
car = "car"
car__2_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car"
step2 = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2"
step2__3_ = step2
step2__2_ = step2__3_
pedestrian_csv = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\pedestrian.csv"
pedestrian = "pedestrian"
pedestrian__2_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian"
CT_VZ_Count = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\CT_VZ_Count"
transport_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\transport.xlsx\\transport$"
CT_VZ_Count__7_ = CT_VZ_Count__6_
Combined_ = "G:\\DC Policy Center\\2015 Demographic Model\\2015 Demographic Model.xlsx\\Combined$"
CT_Demographics = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\CT_Demographics"
speed_ticket_csv = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\speed_ticket.csv"
speed_ticket_Layer = "speed_ticket_Layer"
speed_tickets = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\Scratch.gdb\\speed_tickets"
speed_tickets__2_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\speed_tickets"
CT_Demo_Roads = "CT_Demo_Roads"
outline = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\Scratch.gdb\\outline"
speed_tick_density = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\speed_tick_density"
Speed_Tickets_shp = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\Web\\Speed_Tickets\\Speed_Tickets.shp"
speed_request_csv = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Tab\\Tidy\\speed_request.csv"
speed_request_Layer = "speed_request_Layer"
speed_requests = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\Scratch.gdb\\speed_requests"
speed_requests__2_ = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\speed_requests"
Speed_Requests_shp = "G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\Web\\Speed_Requests\\Speed_Requests.shp"

# Process: Make XY Event Layer (3)
arcpy.MakeXYEventLayer_management(bike_csv, "<U+FEFF>X", "y", bike, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Copy Features
arcpy.CopyFeatures_management(bike, bike__2_, "", "0", "0", "0")

# Process: Spatial Join
arcpy.SpatialJoin_analysis(Census_Tract, bike__2_, step1, "JOIN_ONE_TO_ONE", "KEEP_ALL", "GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,Census_Tract,GEOID,-1,-1;NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,Census_Tract,NAMELSAD,-1,-1;ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,Census_Tract,ALAND,-1,-1;AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,Census_Tract,AWATER,-1,-1;INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,Census_Tract,INTPTLAT,-1,-1;INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,Census_Tract,INTPTLON,-1,-1;N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Cluster,-1,-1;N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,Census_Tract,N_Name,-1,-1", "INTERSECT", "", "")

# Process: Add Field
arcpy.AddField_management(step1, "Total", "FLOAT", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")

# Process: Add Field (2)
arcpy.AddField_management(step1__2_, "Bike", "FLOAT", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")

# Process: Add Field (3)
arcpy.AddField_management(step1__3_, "Car", "LONG", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")

# Process: Add Field (4)
arcpy.AddField_management(step1__4_, "pedestrian", "LONG", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")

# Process: Calculate Field
arcpy.CalculateField_management(step1__5_, "Bike", "[Join_Count]", "VB", "")

# Process: Delete Field
arcpy.DeleteField_management(step1__7_, "Join_Count;TARGET_FID")

# Process: Make XY Event Layer (2)
arcpy.MakeXYEventLayer_management(car_csv, "<U+FEFF>X", "y", car, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Copy Features (2)
arcpy.CopyFeatures_management(car, car__2_, "", "0", "0", "0")

# Process: Spatial Join (2)
arcpy.SpatialJoin_analysis(step1__6_, car__2_, step2, "JOIN_ONE_TO_ONE", "KEEP_ALL", "GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,GEOID,-1,-1;NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,NAMELSAD,-1,-1;ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,ALAND,-1,-1;AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,AWATER,-1,-1;INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,INTPTLAT,-1,-1;INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,INTPTLON,-1,-1;N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,N_Cluster,-1,-1;N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,N_Name,-1,-1;Total \"Total\" true true false 0 Float 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,Total,-1,-1;Bike \"Bike\" true true false 0 Float 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,Bike,-1,-1;Car \"Car\" true true false 0 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,Car,-1,-1;pedestrian \"pedestrian\" true true false 0 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step1,pedestrian,-1,-1;F_U_FEFF_X \"F_U_FEFF_X\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,<U+FEFF>X,-1,-1;Y \"Y\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,Y,-1,-1;OBJECTID \"OBJECTID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,OBJECTID,-1,-1;GLOBALID \"GLOBALID\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,GLOBALID,-1,-1;REQUESTID \"REQUESTID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,REQUESTID,-1,-1;REQUESTTYPE \"REQUESTTYPE\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,REQUESTTYPE,-1,-1;REQUESTDATE \"REQUESTDATE\" true true false 8 Date 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,REQUESTDATE,-1,-1;STATUS \"STATUS\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,STATUS,-1,-1;STREETSEGID \"STREETSEGID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,STREETSEGID,-1,-1;COMMENTS \"COMMENTS\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,COMMENTS,-1,-1;USERTYPE \"USERTYPE\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\car,USERTYPE,-1,-1", "INTERSECT", "", "")

# Process: Calculate Field (2)
arcpy.CalculateField_management(step2, "Car", "[Join_Count]", "VB", "")

# Process: Delete Field (2)
arcpy.DeleteField_management(step2__3_, "Join_Count;TARGET_FID;F_U_FEFF_X;Y;GLOBALID;REQUESTID;REQUESTTYPE;REQUESTDATE;STATUS;STREETSEGID;COMMENTS;USERTYPE")

# Process: Make XY Event Layer
arcpy.MakeXYEventLayer_management(pedestrian_csv, "<U+FEFF>X", "y", pedestrian, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Copy Features (3)
arcpy.CopyFeatures_management(pedestrian, pedestrian__2_, "", "0", "0", "0")

# Process: Spatial Join (3)
arcpy.SpatialJoin_analysis(step2__2_, pedestrian__2_, CT_VZ_Count, "JOIN_ONE_TO_ONE", "KEEP_ALL", "GEOID \"GEOID\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,GEOID,-1,-1;NAMELSAD \"NAMELSAD\" true true false 20 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,NAMELSAD,-1,-1;ALAND \"ALAND\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,ALAND,-1,-1;AWATER \"AWATER\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,AWATER,-1,-1;INTPTLAT \"INTPTLAT\" true true false 11 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,INTPTLAT,-1,-1;INTPTLON \"INTPTLON\" true true false 12 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,INTPTLON,-1,-1;N_Cluster \"N_Cluster\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,N_Cluster,-1,-1;N_Name \"N_Name\" true true false 50 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,N_Name,-1,-1;Total \"Total\" true true false 0 Float 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,Total,-1,-1;Bike \"Bike\" true true false 0 Float 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,Bike,-1,-1;Car \"Car\" true true false 0 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,Car,-1,-1;pedestrian \"pedestrian\" true true false 0 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,pedestrian,-1,-1;OBJECTID \"OBJECTID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\step2,OBJECTID,-1,-1;F_U_FEFF_X \"F_U_FEFF_X\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,<U+FEFF>X,-1,-1;Y \"Y\" true true false 8 Double 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,Y,-1,-1;OBJECTID_1 \"OBJECTID_1\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,OBJECTID,-1,-1;GLOBALID \"GLOBALID\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,GLOBALID,-1,-1;REQUESTID \"REQUESTID\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,REQUESTID,-1,-1;REQUESTTYPE \"REQUESTTYPE\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,REQUESTTYPE,-1,-1;REQUESTDATE \"REQUESTDATE\" true true false 8 Date 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,REQUESTDATE,-1,-1;STATUS \"STATUS\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,STATUS,-1,-1;STREETSEGID \"STREETSEGID\" true true false 4 Long 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,STREETSEGID,-1,-1;COMMENTS \"COMMENTS\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,COMMENTS,-1,-1;USERTYPE \"USERTYPE\" true true false 8000 Text 0 0 ,First,#,G:\\DC Policy Center\\Vision Zero Requests\\Data\\Spatial\\VZero.gdb\\pedestrian,USERTYPE,-1,-1", "INTERSECT", "", "")

# Process: Calculate Field (3)
arcpy.CalculateField_management(CT_VZ_Count, "pedestrian", "[Join_Count]", "VB", "")

# Process: Calculate Field (4)
arcpy.CalculateField_management(CT_VZ_Count__3_, "Total", "[Bike] + [Car] + [pedestrian]", "VB", "")

# Process: Delete Field (3)
arcpy.DeleteField_management(CT_VZ_Count__4_, "Join_Count;TARGET_FID;F_U_FEFF_X;Y;OBJECTID_1;GLOBALID;REQUESTID;REQUESTTYPE;REQUESTDATE;STATUS;STREETSEGID;COMMENTS;USERTYPE")

# Process: Add Join
arcpy.AddJoin_management(CT_VZ_Count__5_, "GEOID", transport_, "GEOID", "KEEP_ALL")

# Process: Add Join (2)
arcpy.AddJoin_management(CT_VZ_Count__6_, "CT_VZ_Count.GEOID", Combined_, "GEOID", "KEEP_ALL")

# Process: Copy Features (4)
arcpy.CopyFeatures_management(CT_VZ_Count__7_, CT_Demographics, "", "0", "0", "0")

# Process: Make XY Event Layer (4)
arcpy.MakeXYEventLayer_management(speed_ticket_csv, "<U+FEFF>X", "y", speed_ticket_Layer, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Copy Features (5)
arcpy.CopyFeatures_management(speed_ticket_Layer, speed_tickets, "", "0", "0", "0")

# Process: Project
arcpy.Project_management(speed_tickets, speed_tickets__2_, "PROJCS['NAD_1983_2011_StatePlane_Maryland_FIPS_1900',GEOGCS['GCS_NAD_1983_2011',DATUM['D_NAD_1983_2011',SPHEROID['GRS_1980',6378137.0,298.257222101]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Lambert_Conformal_Conic'],PARAMETER['False_Easting',400000.0],PARAMETER['False_Northing',0.0],PARAMETER['Central_Meridian',-77.0],PARAMETER['Standard_Parallel_1',38.3],PARAMETER['Standard_Parallel_2',39.45],PARAMETER['Latitude_Of_Origin',37.66666666666666],UNIT['Meter',1.0]]", "WGS_1984_(ITRF00)_To_NAD_1983_2011", "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]]", "NO_PRESERVE_SHAPE", "")

# Process: Project (3)
arcpy.Project_management(CT_Demo_Roads, outline, "PROJCS['NAD_1983_2011_StatePlane_Maryland_FIPS_1900',GEOGCS['GCS_NAD_1983_2011',DATUM['D_NAD_1983_2011',SPHEROID['GRS_1980',6378137.0,298.257222101]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Lambert_Conformal_Conic'],PARAMETER['False_Easting',400000.0],PARAMETER['False_Northing',0.0],PARAMETER['Central_Meridian',-77.0],PARAMETER['Standard_Parallel_1',38.3],PARAMETER['Standard_Parallel_2',39.45],PARAMETER['Latitude_Of_Origin',37.66666666666666],UNIT['Meter',1.0]]", "'WGS_1984_(ITRF00)_To_NAD_1983 + WGS_1984_(ITRF08)_To_NAD_1983_2011'", "GEOGCS['GCS_North_American_1983',DATUM['D_North_American_1983',SPHEROID['GRS_1980',6378137.0,298.257222101]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]]", "NO_PRESERVE_SHAPE", "")

# Process: Point Density
tempEnvironment0 = arcpy.env.extent
arcpy.env.extent = outline
tempEnvironment1 = arcpy.env.mask
arcpy.env.mask = outline
arcpy.gp.PointDensity_sa(speed_tickets__2_, "NONE", speed_tick_density, "100", "Circle 1000 MAP", "SQUARE_KILOMETERS")
arcpy.env.extent = tempEnvironment0
arcpy.env.mask = tempEnvironment1

# Process: Copy Features (7)
arcpy.CopyFeatures_management(speed_tickets__2_, Speed_Tickets_shp, "", "0", "0", "0")

# Process: Make XY Event Layer (5)
arcpy.MakeXYEventLayer_management(speed_request_csv, "<U+FEFF>X", "y", speed_request_Layer, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]];-400 -400 1000000000;-100000 10000;-100000 10000;8.98315284119522E-09;0.001;0.001;IsHighPrecision", "")

# Process: Copy Features (6)
arcpy.CopyFeatures_management(speed_request_Layer, speed_requests, "", "0", "0", "0")

# Process: Project (2)
arcpy.Project_management(speed_requests, speed_requests__2_, "PROJCS['NAD_1983_2011_StatePlane_Maryland_FIPS_1900',GEOGCS['GCS_NAD_1983_2011',DATUM['D_NAD_1983_2011',SPHEROID['GRS_1980',6378137.0,298.257222101]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Lambert_Conformal_Conic'],PARAMETER['False_Easting',400000.0],PARAMETER['False_Northing',0.0],PARAMETER['Central_Meridian',-77.0],PARAMETER['Standard_Parallel_1',38.3],PARAMETER['Standard_Parallel_2',39.45],PARAMETER['Latitude_Of_Origin',37.66666666666666],UNIT['Meter',1.0]]", "WGS_1984_(ITRF00)_To_NAD_1983_2011", "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]]", "NO_PRESERVE_SHAPE", "")

# Process: Copy Features (8)
arcpy.CopyFeatures_management(speed_requests__2_, Speed_Requests_shp, "", "0", "0", "0")

