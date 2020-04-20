# -*- coding: mbcs -*-
#
# Abaqus/CAE Release 6.13-1 replay file
# Internal Version: 2013_05_16-04.28.56 126354
# Run by p4wp4w on Sat Feb 20 12:43:04 2016
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
#: Abaqus Error: 
#: This error may have occurred due to a change to the Abaqus Scripting
#: Interface. Please see the Abaqus Scripting Manual for the details of
#: these changes. Also see the "Example environment files" section of 
#: the Abaqus Site Guide for up-to-date examples of common tasks in the
#: environment file.
#: Execution of "onCaeGraphicsStartup()" in the site directory failed.
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=234.086990356445, 
    height=208.144454956055)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=ON)
openMdb(pathName='C:/Temp/NewCylinderWithSubroutine.cae')
#: The model database "C:\Temp\NewCylinderWithSubroutine.cae" has been opened.
session.viewports['Viewport: 1'].setValues(displayedObject=None)
p = mdb.models['Cylindrical Panel'].parts['Cylinder']
session.viewports['Viewport: 1'].setValues(displayedObject=p)
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    optimizationTasks=OFF, geometricRestrictions=OFF, stopConditions=OFF)
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Job closedloop_step: Analysis Input File Processor completed successfully.
o3 = session.openOdb(name='C:/Temp/closedloop_step.odb')
#: Model: C:/Temp/closedloop_step.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     3
#: Number of Meshes:             3
#: Number of Element Sets:       9
#: Number of Node Sets:          30
#: Number of Steps:              1
session.viewports['Viewport: 1'].setValues(displayedObject=o3)
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.XYPlot('XYPlot-1')
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 1 in NSET SENSOR_POINT_1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 8 in NSET SENSOR_POINT_5', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 7 in NSET SENSOR_POINT_4', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=ON)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=OFF)
o3 = session.openOdb(name='C:/Temp/closedloop_step.odb')
session.viewports['Viewport: 1'].setValues(displayedObject=o3)
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 15 in NSET SENSOR_POINT_9', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 7 in NSET SENSOR_POINT_4', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Spatial displacement: U2 PI: CYLINDER-1 Node 26 in NSET SET-1', 
    )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['closedloop_step'].kill()
#: Error in job closedloop_step: Process terminated by external request (SIGTERM or SIGINT received).
#: Job closedloop_step: Abaqus/Standard was terminated prior to analysis completion.
#: Error in job closedloop_step: Unable to delete file(s) C:\Users\p4wp4w\AppData\Local\Temp\p4wp4w_closedloop_step_2460. Please check that you have file ownership and permissions for removal.
mdb.save()
#: The model database has been saved to "C:\Temp\NewCylinderWithSubroutine.cae".
