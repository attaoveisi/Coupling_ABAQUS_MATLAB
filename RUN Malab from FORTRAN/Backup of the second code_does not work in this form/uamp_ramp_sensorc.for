c     user amplitude subroutine
C      INTERFACE

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
C  *********************THE FIRST CHANGE IS THIS*****************     
C  *********************THE FIRST CHANGE IS THIS*****************  
C  *********************THE FIRST CHANGE IS THIS***************** 
C      AdditionalIncludeDirectories="C:\include" 
!DEC$ OBJCOMMENT LIB:"libeng.lib"
!DEC$ OBJCOMMENT LIB:"libmx.lib" 
!DEC$ OBJCOMMENT LIB:"libmat.lib"
C#define mxCopyPtrToPtr mxCopyPtrToPtr700
C!DEC$ ATTRIBUTES DECORATE,ALIAS:"engOpen" :: engopen
C      include 'fintrf.inc'
C!DEC$ ATTRIBUTES DECORATE, ALIAS:'mxCopyReal8ToPtr' :: mxCopyReal8ToPtr
      
      interface
        function engOpen (command) bind(C,name="engOpen")
        integer(INT_PTR_KIND()) :: engOpen
        character, dimension(*), intent(in) :: command
        end function engOpen
        
        !!! Use mwPointer mxCreateDoubleMatrix(m, n, ComplexFlag); mwSize m, n; integer*4 ComplexFlag; to create an m-by-n mxArray. mxCreateDoubleMatrix initializes each element in the pr array to 0.
        !!! If you set ComplexFlag to mxCOMPLEX in C (1 in Fortran), mxCreateDoubleMatrix also initializes each element in the pi array to 0.
        !!! If you set ComplexFlag to mxREAL in C (0 in Fortran), mxCreateDoubleMatrix allocates enough memory to hold m-by-n real elements. 
        !!! If you set ComplexFlag to mxCOMPLEX in C (1 in Fortran), mxCreateDoubleMatrix allocates enough memory to hold m-by-n real elements and m-by-n imaginary elements.
        function mxCreateDoubleMatrix (a1,b1,c1) 
     *           bind(C,name="mxCreateDoubleMatrix")
        integer*8 :: a1,b1,c1
        integer*8 :: mxCreateDoubleMatrix ! please double check this. 
        intent(in) :: a1,b1,c1
        end function mxCreateDoubleMatrix
  
        !!! Use mwPointer mxGetPr(pm); mwPointer pm; on arrays of type double only. Use mxIsDouble to validate the mxArray type. For other mxArray types, use mxGetData.
        !!! ointer to the first element of the real data. Returns 0 in Fortran if there is no real data.
        function mxGetPr (a2) bind(C,name="mxGetPr")
c        real*8 :: mxGetPr ! please double check this. 
c        double precision, dimension(*), intent(in) :: a2
        integer*8 :: mxGetPr ! please double check this. 
        integer*8, dimension(*), intent(in) :: a2    
        end function mxGetPr
        
        function mxGetPr(a2) result(ptr) bind(C, name='mxGetPr')
        import
        implicit none
        type(C_PTR), intent(in), value :: a2
        type(C_PTR) :: ptr
        end function mxGetPr
        
                      
        Subroutine mxCopyReal8ToPtr (a3,b3,c3)
!DEC$ ATTRIBUTES DECORATE, ALIAS:'mxCopyReal8ToPtr' :: mxCopyReal8ToPtr
        real*8 a3(1)
        integer*8 b3       
        integer*8 c3
C        intent(in) :: a3, b3, c3
        end Subroutine mxCopyReal8ToPtr
        
        !!! Only Fortran ... mxCopyReal8ToPtr(y, px, n) copies n REAL*8 values from the Fortran REAL*8 array y into the MATLAB array pointed to by px, either a pr or pi array.
C        Subroutine mxCopyReal8ToPtr (a3,b3,c3) 
C     *           bind(C,name="mxCopyReal8ToPtr")
C        double precision a3
c        real*8 :: a3(:)
c        integer*8 :: b3        
c        integer*8 :: c3
c        intent(in) :: a3,b3, c3
c        intent(out) :: b3
c        end Subroutine mxCopyReal8ToPtr
               
c        function engPutVariable (a4,b4,c4) 
c     *           bind(C,name="engPutVariable")
c        integer*8 a4
c        character(*) b4
c        integer*8 c4
c        intent(in) :: a4,b4,c4
c        end function engPutVariable
        
c        function engEvalString (a5,b5) 
c     *           bind(C,name="engEvalString")
c        integer(INT_PTR_KIND()) :: engEvalString
c        integer*8 a5
c        character(*) b5
c        intent(in) :: a5,b5
c        end function engEvalString
        
      end interface

           
        real*8 times(10), dist(10)
        integer*8 i
        data times / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0 /
        
        integer*8 M
        integer*8 N
        parameter(M=1) 
        parameter(N=10)
        
        integer*8 T(10)
c        double precision T(10)
C        integer*8 D
        double precision D
        integer*8 SS
        double precision SSS
        integer*4 status
        integer*8 mwPointer
C      integer*8 engOpen
        integer*8 ep
C      integer*8 mwpointer 
C      integer*8 MWPOINTER
C      integer*8 mwsize
        integer*8 mwSize
C      integer*8 MWSIZE
C      integer*8 mwindex
        integer*8 mwIndex
C      integer*8 MWINDEX
C      integer*8 mwsignedindex
        integer*8 mwSignedIndex
C      integer*8 MWSIGNEDINDEX

C  *********************END OF FIRST CHANGE**********************
C  *********************END OF FIRST CHANGE**********************
C  *********************END OF FIRST CHANGE**********************
      
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

      
        ep = engOpen('matlab')
        T = mxCreateDoubleMatrix(M, N, 0)
        SS = mxGetPr(T)
c        SSS = mxCopyReal8ToPtr(times, SS, N)
        Call mxCopyReal8ToPtr(times, SS, N)
c        status = engPutVariable(ep, 'T', T)
        
c        if (engEvalString(ep, 'D = .5.*(-9.8).*T.^2;') .ne. 0) then
c           write(15,*) 'engEvalString failed'
c           stop
c        endif
        
c        if (engEvalString(ep, 'plot(T,D);') .ne. 0) then 
c           write(6,*) 'engEvalString failed'
c           stop
c        endif
      
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

        if (100000 < -200*(svars(1)+svars(2)+svars(3)+svars(4))/18) then
          ampValueNew = 100000
        else if(100000<200*(svars(1)+svars(2)+svars(3)+svars(4))/18)then
          ampValueNew = -100000
        else
          ampValueNew =-200*(svars(1)+svars(2)+svars(3)+svars(4))/18
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
C      END INTERFACE