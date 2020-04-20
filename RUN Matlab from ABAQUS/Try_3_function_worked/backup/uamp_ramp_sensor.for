C     user amplitude subroutine

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

!DEC$ OBJCOMMENT LIB:"libeng.lib"
!DEC$ OBJCOMMENT LIB:"libmx.lib" 
!DEC$ OBJCOMMENT LIB:"libmat.lib"
      
      interface
      
        !!! This routine allows you to start a MATLAB process for using MATLAB as a computational engine.
        !!! mwPointer ENGOPEN(startcmd) character*(*) startcmd
        function ENGOPEN (command) bind(C,name="ENGOPEN")
        integer(INT_PTR_KIND()) :: ENGOPEN
        character, dimension(*), intent(in) :: command
        end function ENGOPEN
        
        !!! Use mwPointer MXCREATEDOUBLEMATRIX730(m, n, ComplexFlag); mwSize m, n; integer*4 ComplexFlag; to create an m-by-n mxArray. MXCREATEDOUBLEMATRIX730 initializes each element in the pr array to 0.
        !!! If you set ComplexFlag to mxCOMPLEX in C (1 in Fortran), MXCREATEDOUBLEMATRIX730 also initializes each element in the pi array to 0.
        !!! If you set ComplexFlag to mxREAL in C (0 in Fortran), MXCREATEDOUBLEMATRIX730 allocates enough memory to hold m-by-n real elements. 
        !!! If you set ComplexFlag to mxCOMPLEX in C (1 in Fortran), MXCREATEDOUBLEMATRIX730 allocates enough memory to hold m-by-n real elements and m-by-n imaginary elements.
        function MXCREATEDOUBLEMATRIX730 (a1,b1,c1) 
     *           bind(C,name="MXCREATEDOUBLEMATRIX730")
        integer*8 :: a1,b1,c1
        integer*8 :: MXCREATEDOUBLEMATRIX730 ! please double check this. 
        intent(in) :: a1,b1,c1
        end function MXCREATEDOUBLEMATRIX730
        
        !!! Call mxCreateDoubleScalar to create a scalar double mxArray. When you finish using the mxArray, call mxDestroyArray to destroy it.
        !!! mwPointer mxCreateDoubleScalar(value); real*8 value
        function MXCREATEDOUBLESCALAR (a11) 
     *           bind(C,name="MXCREATEDOUBLESCALAR")
        real*8 :: a11
        integer*8 :: MXCREATEDOUBLESCALAR ! please double check this. 
        intent(in) :: a11
        end function MXCREATEDOUBLESCALAR  
        
        !!! mxDestroyArray deallocates the memory occupied by the specified mxArray
        !!! subroutine mxDestroyArray(pm) mwPointer pm
        Subroutine MXDESTROYARRAY (a111)
!DEC$ ATTRIBUTES DECORATE, ALIAS:"MXDESTROYARRAY" :: MXDESTROYARRAY
        integer*8, dimension(*) :: a111 ! please double check this. 
        end Subroutine MXDESTROYARRAY  
        
C **************************************************************************************************************************************************************************************
  
        !!! Use mwPointer MXGETPR(pm); mwPointer pm; on arrays of type double only. Use mxIsDouble to validate the mxArray type. For other mxArray types, use mxGetData.
        !!! Pointer to the first element of the real data. Returns 0 in Fortran if there is no real data.
        function MXGETPR(a2) result(ptr) bind(C, name='MXGETPR')
        import
        implicit none
        integer*8, dimension(*), intent(in) :: a2
        integer*8 :: ptr
        end function MXGETPR
        
        function MXGETPRS(a2s) result(ptrs) bind(C, name='MXGETPR')
        import
        implicit none
        integer*8, intent(in) :: a2s
        integer*8 :: ptrs
        end function MXGETPRS
C **************************************************************************************************************************************************************************************       
        
        !!! mxCopyReal8ToPtr copies n REAL*8 values from the Fortran REAL*8 array y into the MATLAB array pointed to by px.
        !!! subroutine mxCopyReal8ToPtr(y, px, n); real*8 y(n); mwPointer px; mwSize n             
        Subroutine MXCOPYREAL8TOPTR730 (a3,b3,c3)
!DEC$ ATTRIBUTES DECORATE, ALIAS:"MXCOPYREAL8TOPTR730" :: MXCOPYREAL8TOPTR730
        real*8 a3(*)
        integer*8 b3       
        integer*8 c3
        end Subroutine MXCOPYREAL8TOPTR730
        
        !!! ENGPUTVARIABLE writes mxArray pm to the engine ep, giving it the variable name name.
        !!! integer*4 ENGPUTVARIABLE(ep, name, pm); mwPointer ep, pm; character*(*) name
        function ENGPUTVARIABLE (a4,b4,c4) 
     *           bind(C,name="ENGPUTVARIABLE")
        integer*8, intent(in) :: a4
        character, dimension(*), intent(in) :: b4
        integer*8, dimension(*), intent(in) :: c4
        end function ENGPUTVARIABLE
        
        !!! ENGEVALSTRING evaluates the expression contained in string for the MATLAB engine session, ep, previously started by ENGOPEN.
        !!! integer*4 ENGEVALSTRING(ep, string) mwPointer ep character*(*) string
        function ENGEVALSTRING (a5,b5) 
     *           bind(C,name="ENGEVALSTRING")
        integer(INT_PTR_KIND()) :: ENGEVALSTRING
        integer*8, intent(in) :: a5
        character, dimension(*), intent(in) :: b5
        end function ENGEVALSTRING
        
        !!! ENGGETVARIABLE reads the named mxArray from the MATLAB engine session associated with ep.
        !!! mwPointer ENGGETVARIABLE(ep, name) mwPointer ep character*(*) name
        function ENGGETVARIABLE (a6,b6) 
     *           bind(C,name="ENGGETVARIABLE")
        integer*8 :: ENGGETVARIABLE
        integer*8, intent(in) :: a6
        character, dimension(*), intent(in) :: b6
        end function ENGGETVARIABLE
        
        !!! mxCopyPtrToReal8 copies n REAL*8 values from the MATLAB array pointed to by px into the Fortran REAL*8 array y. 
        !!! subroutine mxCopyPtrToReal8(px, y, n) mwPointer px real*8 y(n) mwSize n
        Subroutine MXCOPYPTRTOREAL8730 (a7,b7,c7)
!DEC$ ATTRIBUTES DECORATE, ALIAS:"MXCOPYPTRTOREAL8730" :: MXCOPYPTRTOREAL8730
        integer*8 a7
        real*8 b7       
        integer*8 c7
        end Subroutine MXCOPYPTRTOREAL8730
        
        function engClose (a8) bind(C,name="engClose")
        integer(INT_PTR_KIND()) :: engClose
        integer*8, intent(in) :: a8
        end function engClose
        
      end interface

      
      
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC      
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC      
      
      
      
        ! Engine Config. parameters
        integer*4 status
        integer*8 ep
        
        ! Time vector parameters
        integer*8 T(5)
        double precision timestep1, timestep2
        double precision timeV(2)
           ! output
        integer*8 Mo, No
        parameter(Mo=1) 
        parameter(No=1) 
           ! input
        integer*8 Mp, Np
        parameter(Mi=1) 
        parameter(Ni=5) 
        double precision dummeng(5)
        
        ! Dummy amplitude variable
        real*8 Dumm1
        integer*8 Dumm2
        real*8 Dumm3
        
        ! Dummy variable for saving sensor data
        real*8 dumsvar(1,1000000)
        
        ! Dummy time value indicating the starting of the experiment
        real*8 dumt
        
        ! counter
        integer*8 counter
      
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

        ! Get the data from Abaqus (Plant Output)
        ! User code to compute  ampValue = F(sensors)
        iR_V1 = iGetSensorID('SENU1', jSensorLookUpTable)
        valueR_V1 = sensorValues(iR_V1)
        dummeng(2) = valueR_V1
        
        ! Start Matlab Engine
        ep = ENGOPEN('matlab')
               
        ! Predefine time vector
        T = MXCREATEDOUBLEMATRIX730(Mi, Ni, 0)
       
        ! Creat time vector in Fortran: (current increment)
        timestep1 = time(iStepTime)
        timestep2 = timestep1 + dt
        timeV(1) = timestep1
        timeV(2) = timestep2
        dummeng(3) = timestep1
        dummeng(4) = dt
        
        dummeng(5) = ampValueOld 
        
        ! Increment counter
        dumt = 1e-13
        if (timestep1 .LT. dumt) then
           svars(1) = 0
        else
           svars(1) = svars(1) + 1
        end if
        counter = svars(1)

        ! Save the sensor data
        if (svars(1) .EQ. 1) then
           data dumsvar/ 1000000 * 0.0/
        else if ((svars(1) .NE. 1).AND.(svars(1) .NE. 0)) then
           dumsvar(1,svars(1)+1) = valueR_V1
        end if
        dummeng(1) = dumsvar(1,svars(1))
                
        ! Creat time vector in Matlab: Copy from Fortran Array to Matlab Array
        Call MXCOPYREAL8TOPTR730(dummeng, MXGETPR(T), Ni)

        ! Write the time vector in Matlab variable entitled T: 'T'
        status = ENGPUTVARIABLE(ep, 'TT', T)
        
        ! Check point 1:
        if (status .ne. 0) then 
           write(6,*) 'ENGPUTVARIABLE failed: Check point 1'
           stop
        endif
        
        ! Evaluate the expression in Matlab Engine
        ! Check point 2:
        ! [controlsignal] = pidfunc(plantoutputp, plantoutputc, currenttime, dt, lastcontrolinput)
c        if (ENGEVALSTRING(ep, 'Dumm1 = pidfunc(dumsvar(1,svars(1)), 
c     *      valueR_V1,timestep1,dt,ampValueOld);') .ne. 0) then
c           write(15,*) 'ENGEVALSTRING failed: check point 2'
c           stop
c        endif
        
        ! Evaluate the expression in Matlab Engine
        ! Check point 2:
        if (ENGEVALSTRING(ep, 'Dumm1 = pidfunc(TT);') .ne. 0) then
           write(6,*) 'ENGEVALSTRING failed: check point 2'
           stop
        endif
        
        ! Read the results array in Matlab evaluation from Engine session
        Dumm2 = ENGGETVARIABLE(ep, 'Dumm1')
        
        ! Copy from Matlab Array to Fortran array 
        call MXCOPYPTRTOREAL8730(MXGETPRS(Dumm2), Dumm3, No) 
        
        ! Return the Abaqus variables        
        svars(2) = Dumm3

        ! Create the next updated amplitude 
        ampValueNew = Dumm3
c        ampValueNew = -1
       
       ! Destroy the array
        call MXDESTROYARRAY(T)           
        
        ! Ope a text file in C:/temp and write the results inside
        Open (15,File='C:\Temp\AmpData.txt',Position='Append',
     *        Access='Sequential')
        
          if (svars(1) .EQ. 1) then 
             REWIND 15
          end if
            
            Write(15,*),'----------------------------------------------'
            Write(15,*),'Status_Engine =' , ep
            Write(15,*),'Status_T =' , status
            Write(15,*),'Status_call_T =' , T
            Write(15,*),'valueR_V1 =' , valueR_V1
            Write(15,*),'ampValueNew =' , ampValueNew
            Write(15,*),'t1 =' , timestep1
            Write(15,*),'t2 =' , timestep2
            Write(15,*),'counter =' , counter
            Write(15,*),'------------------------------------------ '

        return
        end
