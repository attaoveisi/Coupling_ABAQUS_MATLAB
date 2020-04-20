c     user amplitude subroutine
      Subroutine uamp(
C          passed in for information and state variables
     *     ampName, time, ampValueOld, dt, nProps, props, nSvars, svars,
     *     lFlagsInfo, nSensor, sensorValues, sensorNames, 
     *     jSensorLookUpTable, 
C          to be defined
     *     ampValueNew, 
     *     lFlagsDefine,
     *     AmpDerivative, AmpSecDerivative, AmpIncIntegral,
     *     AmpIncDoubleIntegral)
      
      include 'aba_param.inc'

C     svars - additional state variables, similar to (V)UEL
      dimension sensorValues(nSensor), svars(nSvars), props(nProps)
      character*80 sensorNames(nSensor)
      character*80 ampName

C     time indices
      parameter (iStepTime        = 1,
     *           iTotalTime       = 2,
     *           nTime            = 2)
C     flags passed in for information
      parameter (iInitialization   = 1,
     *           iRegularInc       = 2,
     *           iCuts             = 3,
     *           ikStep            = 4,
     *           nFlagsInfo        = 4)
C     optional flags to be defined
      parameter (iComputeDeriv       = 1,
     *           iComputeSecDeriv    = 2,
     *           iComputeInteg       = 3,
     *           iComputeDoubleInteg = 4,
     *           iStopAnalysis       = 5,
     *           iConcludeStep       = 6,
     *           nFlagsDefine        = 6)
      dimension time(nTime), lFlagsInfo(nFlagsInfo),
     *          lFlagsDefine(nFlagsDefine)
      dimension jSensorLookUpTable(*)


C     User code to compute  ampValue = F(sensors)

c     get sensor values first; note that 
      iR_V1 = iGetSensorID('SENU1', jSensorLookUpTable)
      valueR_V1 = sensorValues(iR_V1)
      iR_V2 = iGetSensorID('SENU2', jSensorLookUpTable)
      valueR_V2 = sensorValues(iR_V2)   
      iR_V3 = iGetSensorID('SENU3', jSensorLookUpTable)
      valueR_V3 = sensorValues(iR_V3)   
      iR_V4 = iGetSensorID('SENU4', jSensorLookUpTable)
      valueR_V4 = sensorValues(iR_V4)   
      iR_V5 = iGetSensorID('SENU5', jSensorLookUpTable)
      valueR_V5 = sensorValues(iR_V5)   
      iR_V6 = iGetSensorID('SENU6', jSensorLookUpTable)
      valueR_V6 = sensorValues(iR_V6)   
      iR_V7 = iGetSensorID('SENU7', jSensorLookUpTable)
      valueR_V7 = sensorValues(iR_V7)   
      iR_V8 = iGetSensorID('SENU8', jSensorLookUpTable)
      valueR_V8 = sensorValues(iR_V8)   
      iR_V9 = iGetSensorID('SENU9', jSensorLookUpTable)
      valueR_V9 = sensorValues(iR_V9)   
      iR_V10 = iGetSensorID('SENU10', jSensorLookUpTable)
      valueR_V10 = sensorValues(iR_V10)   
      iR_V11 = iGetSensorID('SENU11', jSensorLookUpTable)
      valueR_V11 = sensorValues(iR_V11)   
      iR_V12 = iGetSensorID('SENU12', jSensorLookUpTable)
      valueR_V12 = sensorValues(iR_V12)   
      iR_V13 = iGetSensorID('SENU13', jSensorLookUpTable)
      valueR_V13 = sensorValues(iR_V13)   
      iR_V14 = iGetSensorID('SENU14', jSensorLookUpTable)
      valueR_V14 = sensorValues(iR_V14)   
      iR_V15 = iGetSensorID('SENU15', jSensorLookUpTable)
      valueR_V15 = sensorValues(iR_V15)   
      iR_V16 = iGetSensorID('SENU16', jSensorLookUpTable)
      valueR_V16 = sensorValues(iR_V16)
      iR_V17 = iGetSensorID('SENU17', jSensorLookUpTable)
      valueR_V17 = sensorValues(iR_V17)   
      iR_V18 = iGetSensorID('SENU18', jSensorLookUpTable)
      valueR_V18 = sensorValues(iR_V18)   

      
       svars(1) = valueR_V1+valueR_V2+valueR_V3+valueR_V4+valueR_V5 
       svars(2) = valueR_V6+valueR_V7+valueR_V8+valueR_V9+valueR_V10
       svars(3) = valueR_V11+valueR_V12+valueR_V13+valueR_V14 
       svars(4) = valueR_V15+valueR_V16+valueR_V17+valueR_V18

      if (10000000 < 200*(svars(1)+svars(2)+svars(3)+svars(4))/18) then
          ampValueNew = 10000000
      elseif(200*(svars(1)+svars(2)+svars(3)+svars(4))/18<-10000000)then
          ampValueNew = -10000000
      else
          ampValueNew =200*(svars(1)+svars(2)+svars(3)+svars(4))/18
      end if
 
       
c      Open (15,File='C:\Temp\AmpData.txt',Position='Append')
c      &     Access='Sequential')
c            Write(15,*),'----------------------------------------------'
c            Write(15,*),'iR_V3 =' , iR_V3
c            Write(15,*),'iR_V3A =' , iR_V3A
c            Write(15,*),'iR_V3B =' , iR_V3B
c            Write(15,*),'valueR_V3 =' , valueR_V3
c            Write(15,*),'valueR_V3A =' , valueR_V3A
c            Write(15,*),'valueR_V3B =' , valueR_V3B
c            Write(15,*),'t =' , t
c            Write(15,*),'svars(1) = ', svars(1)
c            Write(15,*),'svars(2)= ', svars(2)
c            Write(15,*),'svars(3) = ', svars(3)
c            Write(15,*),'svars(4) = ', svars(4)
c            Write(15,*),'svars(5) = ', svars(5)
c            Write(15,*),'ampValueNew = ', ampValueNew
c            Write(15,*),'------------------------------------------ '
c
      return
      end