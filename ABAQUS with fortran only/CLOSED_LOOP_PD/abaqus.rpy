# -*- coding: mbcs -*-
#
# Abaqus/CAE Release 6.13-1 replay file
# Internal Version: 2013_05_16-04.28.56 126354
# Run by p4wp4w on Wed Feb 10 11:11:17 2016
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
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=271.731781005859, 
    height=208.144454956055)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=ON)
a = mdb.models['Model-1'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    optimizationTasks=OFF, geometricRestrictions=OFF, stopConditions=OFF)
openMdb(pathName='C:/Temp/NewCylinderWithSubroutine.cae')
#: The model database "C:\Temp\NewCylinderWithSubroutine.cae" has been opened.
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Job closedloop_step: Analysis Input File Processor completed successfully.
#: Job closedloop_step: Abaqus/Standard completed successfully.
#: ERROR in job messaging system: Error in connection to analysis
#: Error in job closedloop_step: The executable standard.exe aborted with system error code 1073741819. Please check the .dat, .msg, and .sta files for error messages if the files exist.  If there are no error messages and you cannot resolve the problem, please run the command "abaqus job=support information=support" to report and save your system information.  Use the same command to run Abaqus that you used when the problem occurred.  Please contact your local Abaqus support office and send them the input file, the file support.log which you just created, the executable name, and the error code.
#: Job closedloop_step aborted due to errors.
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
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 1 in NSET SENSOR_POINT_1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.XYPlot('XYPlot-1')
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Job closedloop_step: Analysis Input File Processor completed successfully.
#: Job closedloop_step: Abaqus/Standard completed successfully.
#: ERROR in job messaging system: Error in connection to analysis
#: Error in job closedloop_step: The executable standard.exe aborted with system error code 1073741819. Please check the .dat, .msg, and .sta files for error messages if the files exist.  If there are no error messages and you cannot resolve the problem, please run the command "abaqus job=support information=support" to report and save your system information.  Use the same command to run Abaqus that you used when the problem occurred.  Please contact your local Abaqus support office and send them the input file, the file support.log which you just created, the executable name, and the error code.
#: Job closedloop_step aborted due to errors.
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
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 1 in NSET SENSOR_POINT_1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
mdb.save()
#: The model database has been saved to "C:\Temp\NewCylinderWithSubroutine.cae".
