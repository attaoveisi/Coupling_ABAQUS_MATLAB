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

      parameter(P=0, D = -1)
      
      real*8 dumsvar(1,1000000)
      
      real*8 dumt
      dumt = 2e-13

c     get sensor values first; note that 
      iR_V1 = iGetSensorID('SENU1', jSensorLookUpTable)
      valueR_V1 = sensorValues(iR_V1)
      
      if (time(iStepTime) .LT. dumt) then
         svars(1) = 0
         svars(2) = 0
      else
         svars(1) = svars(1) + 1
      end if
      
      if (svars(1) .EQ. 1) then
         data dumsvar/ 1000000 * 0.0/
         svars(2) = 0
      else if ((svars(1) .NE. 1).AND.(svars(1) .NE. 0)) then
        dumsvar(1,svars(1)+1) = valueR_V1
        svars(2) = (dumsvar(1,svars(1)+1)-dumsvar(1,svars(1)))/dt
      end if
      
           
       svars(3) = P*valueR_V1+D*svars(2)
 
       ampValueNew = svars(3)
                      
 
       
      Open (15,File='C:\Temp\AmpData.txt',Position='Append',
     *         Access='Sequential')
            Write(15,*),'----------------------------------------------'
            Write(15,*),'current =' , valueR_V1
            Write(15,*),'previous =' , dumsvar(1,svars(1))


            Write(15,*),'------------------------------------------ '
c
      return
      end