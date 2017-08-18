# Import arcpy module
import arcpy

arcpy.env.workspace = "G:\DC Policy Center\Urban Heat Island"
arcpy.env.overwriteOutput = True

# Local variables:
ScratchGDB = 'G:\DC Policy Center\Urban Heat Island\Data\Spatial Data\Scratch.gdb'
Band_10 = "Data\Spatial Data\Imagery\LC08_L1TP_015033_20150817_20170226_01_T1\LC08_L1TP_015033_20150817_20170226_01_T1_B10.tif"
Band_11 = "Data\Spatial Data\Imagery\LC08_L1TP_015033_20150817_20170226_01_T1\LC08_L1TP_015033_20150817_20170226_01_T1_B11.tif"
DC = 'G:\GIS DATA\USA\District of Columbia\Census_Geography\census.gdb\Census_Tract'



def landsat_temp(Band10, Band11, Area):
	B10_Rad = ScratchGDB + '\B10_Rad.tif'
	B11_Rad = ScratchGDB + '\B11_Rad.tif'
	B10_Temp = ScratchGDB + '\B10_Temp.tif'
	B11_Temp = ScratchGDB + '\B11_Temp.tif'
	Temperature = ScratchGDB + '\Temperature.tif'
	Clip_Temp = ScratchGDB + '\Final_Temperature.tif'
	
	# Band 10 to Radiance
	arcpy.gp.RasterCalculator_sa("0.0003342 * " + Band10 + " + 0.1", B10_Rad)
	# Band 11 to Radiance
	arcpy.gp.RasterCalculator_sa("0.0003342 * " + Band11 + " + 0.1", B11_Rad)

	# Band 10 Radiance to Temperature
	arcpy.gp.RasterCalculator_sa("1321.08 / ln(774.89 / " + B10_Rad + " + 1) - 272.15", B10_Temp)
	# Band 11 Radiance to Temperature
	arcpy.gp.RasterCalculator_sa("1201.14 / ln(480.89 / " + B11_Rad + " + 1) - 272.15", B11_Temp)
	
	# Execute CellStatistics
	arcpy.gp.CellStatistics_sa("B10_Temp;B11_Temp", Temperature, "MEAN", "DATA")
	
	extents = Temperature.extent

	# Clip Raster to DC Borders
	arcpy.Clip_management(Temperature, extents, Clip_Temp, Area, "", "NONE", "NO_MAINTAIN_EXTENT")

	arcpy.AddSpatialIndex_management(Clip_Temp)
	
	
landsat_temp(Band_10, Band_11, DC)	
