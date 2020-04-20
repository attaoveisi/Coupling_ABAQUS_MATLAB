# -*- coding: mbcs -*-
#
# Abaqus/CAE Release 6.13-1 replay file
# Internal Version: 2013_05_16-04.28.56 126354
# Run by p4wp4w on Thu Feb 18 11:09:17 2016
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
#: Error in job closedloop_step: Problem during compilation - C:\Temp\uamp_ramp_sensor.for
#: Job closedloop_step aborted due to errors.
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Error in job closedloop_step: Problem during compilation - C:\Temp\uamp_ramp_sensor.for
#: Job closedloop_step aborted due to errors.
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
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['closedloop_step'].kill()
#: Error in job closedloop_step: Process terminated by external request (SIGTERM or SIGINT received).
#: Error in job closedloop_step: Abaqus/Standard Analysis exited with an error - Please see the  message file for possible error messages if the file exists.
#: Job closedloop_step aborted due to errors.
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=ON)
session.viewports['Viewport: 1'].assemblyDisplay.meshOptions.setValues(
    meshTechnique=ON)
elemType1 = mesh.ElemType(elemCode=C3D8E, elemLibrary=STANDARD)
elemType2 = mesh.ElemType(elemCode=C3D6E, elemLibrary=STANDARD)
elemType3 = mesh.ElemType(elemCode=C3D4E, elemLibrary=STANDARD)
a = mdb.models['Cylindrical Panel'].rootAssembly
c1 = a.instances['Piezo-1'].cells
cells1 = c1.getSequenceFromMask(mask=('[#1 ]', ), )
pickedRegions =(cells1, )
a.setElementType(regions=pickedRegions, elemTypes=(elemType1, elemType2, 
    elemType3))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.37846, 
    farPlane=4.06735, width=1.7238, height=0.958215, cameraPosition=(0.205439, 
    -1.63929, 3.07566), cameraUpVector=(0.466932, 0.864058, 0.18809), 
    cameraTarget=(0.000801593, 0.240303, 0.545993))
elemType1 = mesh.ElemType(elemCode=C3D8E, elemLibrary=STANDARD)
elemType2 = mesh.ElemType(elemCode=C3D6E, elemLibrary=STANDARD)
elemType3 = mesh.ElemType(elemCode=C3D4E, elemLibrary=STANDARD)
a = mdb.models['Cylindrical Panel'].rootAssembly
c1 = a.instances['Sensor-1'].cells
cells1 = c1.getSequenceFromMask(mask=('[#1 ]', ), )
pickedRegions =(cells1, )
a.setElementType(regions=pickedRegions, elemTypes=(elemType1, elemType2, 
    elemType3))
mdb.save()
#: The model database has been saved to "C:\Temp\NewCylinderWithSubroutine.cae".
session.viewports['Viewport: 1'].view.setValues(width=1.83493, height=1.01998, 
    viewOffsetX=0.0467315, viewOffsetY=-0.00979337)
elemType1 = mesh.ElemType(elemCode=C3D8E, elemLibrary=STANDARD)
elemType2 = mesh.ElemType(elemCode=C3D6E, elemLibrary=STANDARD)
elemType3 = mesh.ElemType(elemCode=C3D4E, elemLibrary=STANDARD)
a = mdb.models['Cylindrical Panel'].rootAssembly
c1 = a.instances['Sensor-1'].cells
cells1 = c1.getSequenceFromMask(mask=('[#1 ]', ), )
pickedRegions =(cells1, )
a.setElementType(regions=pickedRegions, elemTypes=(elemType1, elemType2, 
    elemType3))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.3356, 
    farPlane=4.00168, width=1.80079, height=1.00101, cameraPosition=(
    -0.0463995, 2.34256, 2.91158), cameraUpVector=(0.75065, 0.242717, 
    -0.614502), cameraTarget=(0.014105, 0.330864, 0.477776), 
    viewOffsetX=0.0458621, viewOffsetY=-0.00961118)
session.viewports['Viewport: 1'].view.setValues(width=1.91783, height=1.06607, 
    viewOffsetX=0.0815975, viewOffsetY=-2.30819e-005)
session.viewports['Viewport: 1'].view.setValues(session.views['Iso'])
mdb.save()
#: The model database has been saved to "C:\Temp\NewCylinderWithSubroutine.cae".
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.meshOptions.setValues(
    meshTechnique=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=ON)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=ON)
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.44255, 
    farPlane=3.96955, width=1.77516, height=0.984033, cameraPosition=(2.0299, 
    -1.95427, 1.5661), cameraUpVector=(0.315331, 0.904588, 0.286857), 
    cameraTarget=(0.000801504, 0.240303, 0.545993))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.5552, 
    farPlane=3.85691, width=0.573123, height=0.317703, viewOffsetX=0.0457063, 
    viewOffsetY=0.0821628)
a = mdb.models['Cylindrical Panel'].rootAssembly
n1 = a.instances['Sensor-1'].nodes
nodes1 = n1.getSequenceFromMask(mask=('[#0:19 #10000000 ]', ), )
a.Set(nodes=nodes1, name='SENSOR_POINT_1')
#: The set 'SENSOR_POINT_1' has been edited (1 node).
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=OFF)
mdb.save()
#: The model database has been saved to "C:\Temp\NewCylinderWithSubroutine.cae".
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=OFF)
session.viewports['Viewport: 1'].view.setValues(session.views['Iso'])
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
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
#: Error in job closedloop_step: Abaqus/Standard Analysis exited with an error - Please see the  message file for possible error messages if the file exists.
#: Job closedloop_step aborted due to errors.
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
#* XypError: History output cannot be located for the variable 'Electrical 
#* potential: EPOT PI: PIEZO-1 Node 256 in NSET ACTUATOR_POIN2' in the step(s) 
#* specified.
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: PIEZO-1 Node 244 in NSET ACTUATOR_POINT1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
odb = session.odbs['C:/Temp/closedloop_step.odb']
xy1 = xyPlot.XYDataFromHistory(odb=odb, 
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 37 in NSET SENSOR_POINT_4', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Error in job closedloop_step: Problem during compilation - C:\Temp\uamp_ramp_sensor.for
#: Job closedloop_step aborted due to errors.
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Error in job closedloop_step: Problem during compilation - C:\Temp\uamp_ramp_sensor.for
#: Job closedloop_step aborted due to errors.
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Job closedloop_step: Analysis Input File Processor completed successfully.
mdb.jobs['closedloop_step'].kill()
#: Error in job closedloop_step: Process terminated by external request (SIGTERM or SIGINT received).
#: Job closedloop_step: Abaqus/Standard was terminated prior to analysis completion.
#: Error in job closedloop_step: Abaqus/Standard Analysis exited with an error - Please see the  message file for possible error messages if the file exists.
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
    outputVariableName='Electrical potential: EPOT PI: SENSOR-1 Node 637 in NSET SENSOR_POINT_1', 
    steps=('Step-1', ), )
c1 = session.Curve(xyData=xy1)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
a = mdb.models['Cylindrical Panel'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=ON, bcs=ON, 
    predefinedFields=ON, connectors=ON)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=ON)
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.39681, 
    farPlane=4.00641, width=1.74191, height=0.965605, cameraPosition=(2.38992, 
    -1.31466, 1.90548), cameraUpVector=(-0.0259229, 0.938411, 0.344548), 
    cameraTarget=(0.000801504, 0.240303, 0.545993))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.49204, 
    farPlane=3.88434, width=1.81112, height=1.00397, cameraPosition=(2.86134, 
    -0.872431, 1.2969), cameraUpVector=(-0.0912493, 0.937005, 0.337187), 
    cameraTarget=(0.00719862, 0.246304, 0.537735))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.54027, 
    farPlane=3.83611, width=1.33289, height=0.738869, viewOffsetX=0.028441, 
    viewOffsetY=0.140784)
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.4739, 
    farPlane=4.18695, width=1.29806, height=0.719563, cameraPosition=(1.104, 
    1.92557, 3.18375), cameraUpVector=(-0.109731, 0.614677, -0.781109), 
    cameraTarget=(0.00829899, 0.29787, 0.709071), viewOffsetX=0.0276978, 
    viewOffsetY=0.137106)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=OFF, bcs=OFF, 
    predefinedFields=OFF, connectors=OFF)
mdb.jobs['closedloop_step'].submit(consistencyChecking=OFF)
#: The job input file "closedloop_step.inp" has been submitted for analysis.
#: Job closedloop_step: Analysis Input File Processor completed successfully.
#: Error in job closedloop_step: Too many attempts made for this increment
#: Job closedloop_step: Abaqus/Standard aborted due to errors.
#: Error in job closedloop_step: Abaqus/Standard Analysis exited with an error - Please see the  message file for possible error messages if the file exists.
#: Job closedloop_step aborted due to errors.
