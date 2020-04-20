! $Id: MatlabMatFile.f90 822 2010-06-01 11:40:42Z harvi $
!> @file
!! Defines the MatlabMatrix module.

!*******************************************************************************
!!
!! MODULE MatlabMatFile
!> Fortran wrappers for the contents of mat.h.
!!
!*******************************************************************************

MODULE MatlabMatFile

  USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_PTR, C_INTPTR_T,  &
      C_SIZE_T, C_INT, C_CHAR
      
  IMPLICIT NONE
  
  PRIVATE

  !> Interfaces to Matlab's external mat* routines.
  INTERFACE
    !> Open a mat file.
    FUNCTION matOpen(filename, mode) RESULT(mfile) BIND(C, NAME='matOpen')
      IMPORT
      IMPLICIT NONE
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: filename
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: mode
      TYPE(C_PTR) :: mfile      
    END FUNCTION matOpen
    
    !> Close a mat file.
    FUNCTION matClose(pMF) RESULT(rc) BIND(C, NAME='matClose')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF      
      INTEGER(C_INT) :: rc
    END FUNCTION matClose
    
    !> Get the ANSI C FILE pointer for the MAT file.
    FUNCTION matGetFp(pMF) RESULT(file) BIND(C, NAME='matGetFp')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      TYPE(C_PTR) :: file
    END FUNCTION matGetFp
    
    !> Write array value with the specified name to the MAT file.
    FUNCTION matPutVariable(pMF, name, pA) RESULT(rc)  &
        BIND(C, NAME='matPutVariable')    
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR), INTENT(IN), VALUE :: pA
      INTEGER(C_INT) :: rc
    END FUNCTION matPutVariable
    
    !> Write array value with the specified name to the MAT file as a global.
    FUNCTION matPutVariableAsGlobal(pMF, name, pA) RESULT(rc)  &
        BIND(C, NAME='matPutVariableAsGlobal')    
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR), INTENT(IN), VALUE :: pA
      INTEGER(C_INT) :: rc
    END FUNCTION
    
    !> Read the array value for the specified variable name from a MAT file.
    FUNCTION matGetVariable(pMF, name) RESULT(pm)  &
        BIND(C, NAME='matGetVariable')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR) :: pm
    END FUNCTION matGetVariable
    
    !> Read the next array value from the current file location of the MAT 
    !! file.
    FUNCTION matGetNextVariable(pMF, nameptr) RESULT(pm)  &
        BIND(C, NAME='matGetNextVariable')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      TYPE(C_PTR), INTENT(IN), VALUE :: nameptr   ! const char**
      TYPE(C_PTR) :: pm
    END FUNCTION matGetNextVariable
    
    !> Read the array header of the next array value in a MAT file.
    FUNCTION matGetNextVariableInfo(pMF, nameptr) RESULT(pm)  &
        BIND(C, NAME='matGetNextVariableInfo')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      TYPE(C_PTR), INTENT(IN), VALUE :: nameptr  ! const char**
      TYPE(C_PTR) :: pm
    END FUNCTION matGetNextVariableInfo
    
    !> Read the array header for the variable with the specified name from the 
    !! MAT file.
    FUNCTION matGetVariableInfo(pMF, name) RESULT(pm)  &
        BIND(C, NAME='matGetVariableInfo')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR) :: pm
    END FUNCTION matGetVariableInfo

    !> Remove a variable with the specified name from the MAT file.
    FUNCTION matDeleteVariable(pMF, name) RESULT(pm)  &
        BIND(C, NAME='matDeleteVariable')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR) :: pm
    END FUNCTION matDeleteVariable
    
    !> Get a list of the names of the arrays in a MAT file.
    FUNCTION matGetDir(pMF, num) RESULT(list) BIND(C, NAME='matGetDir')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pMF
      INTEGER(C_INT), INTENT(OUT) :: num
      TYPE(C_PTR) :: list    ! char**
    END FUNCTION
  END INTERFACE
  
  ! Expose above
  PUBLIC :: matOpen
  PUBLIC :: matClose
  PUBLIC :: matGetFp
  PUBLIC :: matPutVariable
  PUBLIC :: matPutVariableAsGlobal
  PUBLIC :: matGetVariable
  PUBLIC :: matGetNextVariable
  PUBLIC :: matGetNextVariableInfo
  PUBLIC :: matGetVariableInfo
  PUBLIC :: matDeleteVariable
  PUBLIC :: matGetDir

END MODULE MatlabMatFile
