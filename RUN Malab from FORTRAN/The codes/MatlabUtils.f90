! $Id: MatlabUtils.f90 1833 2012-12-18 02:37:57Z ian $
!> @file
!! Matlab utilities

!*******************************************************************************
!!
!! MODULE MatlabUtils
!> Utility procedures to make working with Matlab's external interfaces a 
!! little easier.
!!
!*******************************************************************************

MODULE MatlabUtils
  
  USE, INTRINSIC :: ISO_C_BINDING
  USE MatlabMatrix
  
  IMPLICIT NONE
  
  PRIVATE
  
  !-----------------------------------------------------------------------------
  ! Interfaces to mathworks provided routines etc
  
  PUBLIC :: mw_size
  PUBLIC :: mw_index
  
  PUBLIC :: mxUNKNOWN_CLASS
  PUBLIC :: mxCELL_CLASS
  PUBLIC :: mxSTRUCT_CLASS
  PUBLIC :: mxLOGICAL_CLASS
  PUBLIC :: mxCHAR_CLASS
  PUBLIC :: mxVOID_CLASS
  PUBLIC :: mxDOUBLE_CLASS
  PUBLIC :: mxSINGLE_CLASS
  PUBLIC :: mxINT8_CLASS
  PUBLIC :: mxUINT8_CLASS
  PUBLIC :: mxINT16_CLASS
  PUBLIC :: mxUINT16_CLASS
  PUBLIC :: mxINT32_CLASS
  PUBLIC :: mxUINT32_CLASS
  PUBLIC :: mxINT64_CLASS
  PUBLIC :: mxUINT64_CLASS
  PUBLIC :: mxFUNCTION_CLASS
  PUBLIC :: mxOPAQUE_CLASS
  PUBLIC :: mxOBJECT_CLASS
  
  PUBLIC :: mxREAL
  PUBLIC :: mxCOMPLEX
  
  !-----------------------------------------------------------------------------
  ! Interfaces to our utility routines
  
  PUBLIC :: MatlabCreateStruct
  
  PUBLIC :: MatlabCreate
  PUBLIC :: MatlabCreateString   ! String specific interfaces of MatlabCreate.
  
  PUBLIC :: MatlabGet
  PUBLIC :: MatlabGetPtr
  PUBLIC :: MatlabGetCopy
  PUBLIC :: MatlabGetAlloc
  
  PUBLIC :: MatlabGetField
  !PUBLIC :: MatlabGetFieldPtr
  PUBLIC :: MatlabGetFieldCopy
  PUBLIC :: MatlabGetFieldAlloc
  
  PUBLIC :: MatlabSet         ! Scalars only
  PUBLIC :: MatlabSetCopy     ! Arrays?
  
  PUBLIC :: MatlabSetField    ! Scalars only
  PUBLIC :: MatlabCreateField
  
  PUBLIC :: CharArrayToScalar
  PUBLIC :: CharArrayLen
  PUBLIC :: CharScalarToArray
  
  !> Create a Matlab variable that holds a structure.
  INTERFACE MatlabCreateStruct
    !> @details See MatlabUtils::MatlabCreateStruct_char.
    MODULE PROCEDURE MatlabCreateStruct_char
  END INTERFACE MatlabCreateStruct
  
  !> Create a Matlab variable that holds a string.
  INTERFACE MatlabCreateString
    MODULE PROCEDURE MatlabCreateString_char
  END INTERFACE MatlabCreateString
  
  !> Get the mxArray for a given field.
  INTERFACE MatlabGetField
    MODULE PROCEDURE MatlabGetField_real
    MODULE PROCEDURE MatlabGetField_int
    MODULE PROCEDURE MatlabGetField_logical
!    MODULE PROCEDURE MatlabGetFieldCopy_complex
    MODULE PROCEDURE MatlabGetField_mxArray
    MODULE PROCEDURE MatlabGetField_char
  END INTERFACE MatlabGetField
  
  !> Get field data from a structure.
  INTERFACE MatlabGetFieldPtr
    MODULE PROCEDURE MatlabGetFieldPtr_double1D
  END INTERFACE MatlabGetFieldPtr
  
  ! Copy field data from a structure.
  INTERFACE MatlabGetFieldCopy
    MODULE PROCEDURE MatlabGetFieldCopy_int1D
    MODULE PROCEDURE MatlabGetFieldCopy_real1D
  END INTERFACE MatlabGetFieldCopy
  
  ! Copy field data from a structure, allocating the fortran target.
  INTERFACE MatlabGetFieldAlloc
    MODULE PROCEDURE MatlabGetFieldAlloc_real1D
    MODULE PROCEDURE MatlabGetFieldAlloc_real2D
  END INTERFACE MatlabGetFieldAlloc
  
  !> Get a scalar from an array
  INTERFACE MatlabGet
    MODULE PROCEDURE MatlabGet_int
    MODULE PROCEDURE MatlabGet_real
    MODULE PROCEDURE MatlabGet_log
    MODULE PROCEDURE MatlabGet_char
  END INTERFACE MatlabGet
  
  !> Get a pointer to the array data.  The argument to receive the data is a 
  !! pointer that is then set to point to the actual storage behind the Matlab 
  !! array.
  INTERFACE MatlabGetPtr
    MODULE PROCEDURE MatlabGetPtr_double1D
    MODULE PROCEDURE MatlabGetPtr_double2D
  END INTERFACE MatlabGetPtr
  
  !> Copy array data.  The argument to receive the data is either a scalar or 
  !! an array that has previously been allocated to the correct size.
  INTERFACE MatlabGetCopy
    MODULE PROCEDURE MatlabGetCopy_int1D
    MODULE PROCEDURE MatlabGetCopy_real1D
    MODULE PROCEDURE MatlabGetCopy_real2D
  END INTERFACE MatlabGetCopy
  
  !> Allocate and copy data.  The argument to receive the data is an array 
  !! with the ALLOCATABLE attribute.
  INTERFACE MatlabGetAlloc
    MODULE PROCEDURE MatlabGetAlloc_real
    MODULE PROCEDURE MatlabGetAlloc_real2D
  END INTERFACE MatlabGetAlloc
  
  !> Copy from Fortran scalar to Matlab variable.
  INTERFACE MatlabSet
    MODULE PROCEDURE MatlabSet_real
  END INTERFACE MatlabSet
  
  !> Create Matlab array based on fortran variable.
  INTERFACE MatlabCreate
    MODULE PROCEDURE MatlabCreate_real1D
    MODULE PROCEDURE MatlabCreate_real2D
    MODULE PROCEDURE MatlabCreate_real3D
    MODULE PROCEDURE MatlabCreate_real4D
    MODULE PROCEDURE MatlabCreate_real5D
    MODULE PROCEDURE MatlabCreateString_char
  END INTERFACE MatlabCreate
  
  !> Copy from Fortran array to Matlab array.
  !!
  !! These are deprecated - Use MatlabCreate procedures instead.
  !! @todo Write MatlabCreate procedures...
  INTERFACE MatlabSetCopy
    MODULE PROCEDURE MatlabSetCopy_real1D
    MODULE PROCEDURE MatlabSetCopy_int1D
    MODULE PROCEDURE MatlabSetCopy_real2D
  END INTERFACE MatlabSetCopy
  
  !> Copy from Fortran scalar to Matlab structure.
  INTERFACE MatlabSetField
    MODULE PROCEDURE MatlabSetField_real
  END INTERFACE MatlabSetField
  
  !> Copy from Fortran scalar or array to Matlab structure.
  INTERFACE MatlabCreateField
    MODULE PROCEDURE MatlabCreateField_real
    MODULE PROCEDURE MatlabCreateField_real1D
    MODULE PROCEDURE MatlabCreateField_real2D
    MODULE PROCEDURE MatlabCreateField_char
    MODULE PROCEDURE MatlabCreateField_int
    MODULE PROCEDURE MatlabCreateField_mxarray
  END INTERFACE MatlabCreateField
  
  !-----------------------------------------------------------------------------
  ! List of error codes
  
  INTEGER, PARAMETER :: merrBase = 1000
  !> No error - it worked
  INTEGER, PARAMETER :: merrSuccess = 0
  !> Generic error
  INTEGER, PARAMETER :: merrUnspecified = merrBase + 1
  !> Field doesn't exist.
  INTEGER, PARAMETER :: merrField = merrBase + 2
  !> Cannot convert contents.
  INTEGER, PARAMETER :: merrConvert = merrBase + 3
  !> Index out of bounds.
  INTEGER, PARAMETER :: merrIndex = merrBase + 4
  !> Memory allocation problem.
  INTEGER, PARAMETER :: merrMemory = merrBase + 5
  !> Target array is wrong type.
  INTEGER, PARAMETER :: merrWrongClass = merrBase + 6
  !> Target array has wrong number of dimensions.
  INTEGER, PARAMETER :: merrWrongDims = merrBase + 7
  !> Target object is not a structure.
  INTEGER, PARAMETER :: merrNotAStruct = merrBase + 8
   
CONTAINS
  
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! Matrix creation helpers
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateStruct_char
  !> Creates a structure mxarray.
  !!
  !! @param[in]     fieldnames
  !!
  !! @param[in]     m                 Optional number of rows.  One if not 
  !! present.
  !!
  !! @param[in]     n                 Number of columns.  One if not present.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreateStruct_char(fieldnames, m, n) RESULT(mxstruct)
    
    !---------------------------------------------------------------------------
    ! Arguments.
    
    CHARACTER(*), INTENT(IN), DIMENSION(:) :: fieldnames
    INTEGER, INTENT(IN), OPTIONAL :: m
    INTEGER, INTENT(IN), OPTIONAL :: n
    
    ! Function result
    TYPE(C_PTR) :: mxstruct
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER(mw_size) :: local_m
    INTEGER(mw_size) :: local_n
    
    TYPE(C_PTR) :: ptr_array(SIZE(fieldnames))
    
    TYPE :: string
      CHARACTER(KIND=C_CHAR), ALLOCATABLE, DIMENSION(:) :: buf
    END TYPE string
    TYPE(string) :: buffers(SIZE(fieldnames))
    
    INTEGER :: i
    
    !***************************************************************************
    
    IF (PRESENT(m)) THEN
      local_m = m
    ELSE
      local_m = 1
    END IF
    IF (PRESENT(n)) THEN
      local_n = n
    ELSE
      local_n = 1
    END IF
    
    ! Create null terminated copies of our field names
    DO i = 1, SIZE(fieldnames)
      CALL AllocArrayFromCharScalar(TRIM(fieldnames(i)), buffers(i)%buf)
      ptr_array(i) = C_LOC(buffers(i)%buf)
    END DO
    
    mxstruct = mxCreateStructMatrix( local_m, local_n,  &
        SIZE(fieldnames, KIND=C_INT),  &
        ptr_array )
    
  END FUNCTION MatlabCreateStruct_char
  
  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateString_char
  !> Creates a Matlab variable that holds a scalar string.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreateString_char(str) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    CHARACTER(LEN=*), INTENT(IN) :: str
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !***************************************************************************
    
    mxarray = mxCreateString(str // C_NULL_CHAR)
    
  END FUNCTION MatlabCreateString_char
  
  
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! Basic mxArray operations
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGet_int
  !> Gets an INTEGER value from an mxArray.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGet_int(mxarray, val, stat, i1, i2)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: i1
    INTEGER, INTENT(IN), OPTIONAL :: i2
    
    TYPE(C_PTR) data_ptr
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER idx, count
    INTEGER va(1)
    
    !***************************************************************************

    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    
    idx = get_fortran_index(mxarray, i1, i2)
    count = mxGetNumberOfElements(mxarray)
    IF (idx > count) THEN
      stat = merrIndex
      RETURN
    END IF
    
    class_id = mxGetClassID(mxarray)
    SELECT CASE (class_id)
    CASE (mxSINGLE_CLASS)
      CALL int_from_single(data_ptr, count, va, idx)
    CASE (mxDOUBLE_CLASS)
      CALL int_from_double(data_ptr, count, va, idx)
    CASE (mxLOGICAL_CLASS)
      CALL int_from_logical(data_ptr, count, va, idx)
    CASE (mxINT8_CLASS, mxUINT8_CLASS)
      CALL int_from_int8(data_ptr, count, va, idx)
    CASE (mxINT16_CLASS, mxUINT16_CLASS)
      CALL int_from_int16(data_ptr, count, va, idx)
    CASE (mxINT32_CLASS, mxUINT32_CLASS)
      CALL int_from_int32(data_ptr, count, va, idx)
    CASE (mxINT64_CLASS, mxUINT64_CLASS)
      CALL int_from_int64(data_ptr, count, va, idx)
    CASE DEFAULT
      stat = merrConvert
      RETURN
    END SELECT
    val = va(1)
    stat = merrSuccess
    
  END SUBROUTINE MatlabGet_int

  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGet_log
  !> Gets a LOGICAL value from an mxArray.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGet_log(mxarray, val, stat, i1, i2)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    LOGICAL, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: i1
    INTEGER, INTENT(IN), OPTIONAL :: i2
    
    INTEGER vi
    
    !***************************************************************************

    CALL MatlabGet(mxarray, vi, stat, i1, i2)
    IF (stat /= 0) RETURN
    IF (vi /= 0) THEN
      val = .TRUE.
    ELSE
      val = .FALSE.
    END IF
    stat = merrSuccess
    
  END SUBROUTINE MatlabGet_log


  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGet_real
  !> Gets a REAL value from an mxArray.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGet_real(mxarray, val, stat, i1, i2)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: i1        
    INTEGER, INTENT(IN), OPTIONAL :: i2
    
    TYPE(C_PTR) data_ptr
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER idx, count
    REAL va(1)
    
    !***************************************************************************
    
    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF

    idx = get_fortran_index(mxarray, i1, i2)
    count = mxGetNumberOfElements(mxarray)
    IF (idx > count) THEN
      stat = merrIndex
      RETURN
    END IF
    
    class_id = mxGetClassID(mxarray)
    SELECT CASE (class_id)
    CASE (mxSINGLE_CLASS)
      CALL real_from_single(data_ptr, count, va, idx)
    CASE (mxDOUBLE_CLASS)
      CALL real_from_double(data_ptr, count, va, idx)
    CASE (mxLOGICAL_CLASS)
      CALL real_from_logical(data_ptr, count, va, idx)
    CASE (mxINT8_CLASS, mxUINT8_CLASS)
      CALL real_from_int8(data_ptr, count, va, idx)
    CASE (mxINT16_CLASS, mxUINT16_CLASS)
      CALL real_from_int16(data_ptr, count, va, idx)
    CASE (mxINT32_CLASS, mxUINT32_CLASS)
      CALL real_from_int32(data_ptr, count, va, idx)
    CASE (mxINT64_CLASS, mxUINT64_CLASS)
      CALL real_from_int64(data_ptr, count, va, idx)
    CASE DEFAULT
      stat = merrConvert
      RETURN
    END SELECT
    val = va(1)
    stat = merrSuccess
    
  END SUBROUTINE MatlabGet_real

  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGet_char
  !> Gets a CHARACTER value from an mxArray.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGet_char(mxarray, val, stat)
    
    USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_F_POINTER

    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxarray
    CHARACTER(:), ALLOCATABLE, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: c_str
    CHARACTER, POINTER :: f_str(:)
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER :: numel
    
    INTEGER :: i
    
    !***************************************************************************

    class_id = mxGetClassID(mxarray)
    IF (class_id /= mxCHAR_CLASS) THEN
      stat = merrConvert
      RETURN
    END IF
    
    numel = mxGetNumberOfElements(mxarray)     
    c_str = mxArrayToString(mxarray)
    IF (.NOT. C_ASSOCIATED(c_str)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    CALL C_F_POINTER(c_str, f_str, [numel])
    ALLOCATE(CHARACTER(numel) :: val)
    FORALL (i = 1:numel) val(i:i) = f_str(i)
    CALL mxFree(c_str)
    stat = merrSuccess  
    
  END SUBROUTINE MatlabGet_char


  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetCopy_int1D
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetCopy_int1D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(OUT) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) data_ptr
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER count
    
    !***************************************************************************
    
    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) RETURN
    
    count = mxGetNumberOfElements(mxarray)
    
    class_id = mxGetClassID(mxarray)
    SELECT CASE (class_id)
    CASE (mxSINGLE_CLASS)
      CALL int_from_single(data_ptr, count, val)
    CASE (mxDOUBLE_CLASS)
      CALL int_from_double(data_ptr, count, val)
    CASE (mxLOGICAL_CLASS)
      CALL int_from_logical(data_ptr, count, val)
    CASE (mxINT8_CLASS, mxUINT8_CLASS)
      CALL int_from_int8(data_ptr, count, val)
    CASE (mxINT16_CLASS, mxUINT16_CLASS)
      CALL int_from_int16(data_ptr, count, val)
    CASE (mxINT32_CLASS, mxUINT32_CLASS)
      CALL int_from_int32(data_ptr, count, val)
    CASE (mxINT64_CLASS, mxUINT64_CLASS)
      CALL int_from_int64(data_ptr, count, val)
    CASE DEFAULT
      stat = merrConvert    ! Cannot convert
      RETURN
    END SELECT
    stat = merrSuccess

  END SUBROUTINE MatlabGetCopy_int1D


  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetCopy_real1D
  !!
  !*****************************************************************************    

  SUBROUTINE MatlabGetCopy_real1D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(OUT) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) data_ptr
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER count

    !***************************************************************************
    
    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) RETURN
    
    count = mxGetNumberOfElements(mxarray)
    
    class_id = mxGetClassID(mxarray)
    SELECT CASE (class_id)
    CASE (mxSINGLE_CLASS)
      CALL real_from_single(data_ptr, count, val)
    CASE (mxDOUBLE_CLASS)
      CALL real_from_double(data_ptr, count, val)
    CASE (mxLOGICAL_CLASS)
      CALL real_from_logical(data_ptr, count, val)
    CASE (mxINT8_CLASS, mxUINT8_CLASS)
      CALL real_from_int8(data_ptr, count, val)
    CASE (mxINT16_CLASS, mxUINT16_CLASS)
      CALL real_from_int16(data_ptr, count, val)
    CASE (mxINT32_CLASS, mxUINT32_CLASS)
      CALL real_from_int32(data_ptr, count, val)
    CASE (mxINT64_CLASS, mxUINT64_CLASS)
      CALL real_from_int64(data_ptr, count, val)
    CASE DEFAULT
      stat = merrConvert    ! Cannot convert
      RETURN
    END SELECT
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetCopy_real1D     


  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetCopy_real2D
  !!
  !*****************************************************************************    

  SUBROUTINE MatlabGetCopy_real2D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(OUT) :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) data_ptr
    INTEGER(KIND(mxUNKNOWN_CLASS)) class_id
    INTEGER count

    !***************************************************************************
    
    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) RETURN
    
    count = mxGetNumberOfElements(mxarray)
    
    class_id = mxGetClassID(mxarray)
    SELECT CASE (class_id)
    CASE (mxSINGLE_CLASS)
      CALL real_from_single(data_ptr, count, val)
    CASE (mxDOUBLE_CLASS)
      CALL real_from_double(data_ptr, count, val)
    CASE (mxLOGICAL_CLASS)
      CALL real_from_logical(data_ptr, count, val)
    CASE (mxINT8_CLASS, mxUINT8_CLASS)
      CALL real_from_int8(data_ptr, count, val)
    CASE (mxINT16_CLASS, mxUINT16_CLASS)
      CALL real_from_int16(data_ptr, count, val)
    CASE (mxINT32_CLASS, mxUINT32_CLASS)
      CALL real_from_int32(data_ptr, count, val)
    CASE (mxINT64_CLASS, mxUINT64_CLASS)
      CALL real_from_int64(data_ptr, count, val)
    CASE DEFAULT
      stat = merrConvert    ! Cannot convert
      RETURN
    END SELECT
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetCopy_real2D       


  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetPtr_double1D
  !> Gets a 1D REAL array from an mxArray.
  !!
  !! @param[in]     mxarray       C-pointer to the mxArray.
  !!
  !! @param[out]    val           Pointer to a one dimensional REAL(C_DOUBLE) 
  !! array.
  !!
  !! @param[out]    stat          Error code - non-zero on error.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGetPtr_double1D(mxarray, val, stat)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL(C_DOUBLE), INTENT(OUT), POINTER :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Locals
    TYPE(C_PTR) ptr
    
    !***************************************************************************
    
    ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    IF (mxGetClassID(mxarray) /= mxDOUBLE_CLASS) THEN
      stat = merrConvert
      RETURN
    END IF
    CALL C_F_POINTER(ptr, val, [mxGetNumberOfElements(mxArray)])
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetPtr_double1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetPtr_double2D
  !> Gets a 2D REAL array from an mxArray.
  !!
  !! @param[in]     mxarray       C-pointer to the mxArray.
  !!
  !! @param[out]    val           Pointer to a two dimensional REAL(C_DOUBLE) 
  !! array.
  !!
  !! @param[out]    stat          Error code - non-zero on error.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGetPtr_double2D(mxarray, val, stat)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL(C_DOUBLE), INTENT(OUT), POINTER :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Locals
    TYPE(C_PTR) ptr
    
    !***************************************************************************
    
    ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    IF (mxGetClassID(mxarray) /= mxDOUBLE_CLASS) THEN
      stat = merrConvert
      RETURN
    END IF
    CALL C_F_POINTER(ptr, val, [mxGetM(mxArray), mxGetN(mxArray)])
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetPtr_double2D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabAllocCopy_real
  !> Allocates a 1D REAL array of the appropriate size and then copies across
  !! the data in an mxArray.
  !!
  !! @param[in]     mxarray           C-pointer to the mxArray.
  !!
  !! @param[out]    val               Variable to receive the data.
  !!
  !! @param[out]    stat              Error code - non zero on error.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGetAlloc_real(mxarray, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(OUT), ALLOCATABLE :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER :: num_dims
    TYPE(C_PTR) :: dims_ptr
    INTEGER(mw_size), POINTER :: dims(:)
    
    !***************************************************************************
    
    num_dims = mxGetNumberOfDimensions(mxArray)
    IF (num_dims > 2) THEN
      stat = 4    ! Wrong rank
      RETURN
    END IF
    
    dims_ptr = mxGetDimensions(mxarray)
    IF (.NOT. C_ASSOCIATED(dims_ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    CALL C_F_POINTER(dims_ptr, dims, [num_dims])
    
    IF (num_dims == 2) THEN
      ALLOCATE(val(dims(1) * dims(2)), STAT=stat)
    ELSE
      ALLOCATE(val(dims(1)), STAT=stat)
    END IF
    IF (stat /= 0) RETURN
    
    CALL MatlabGetCopy(mxarray, val, stat)
  
  END SUBROUTINE MatlabGetAlloc_real

  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetAlloc_real2D
  !> Allocates a 2D REAL array of the appropriate size and then copies across
  !! the data in an mxArray.
  !!
  !! @param[in]     mxarray     C-pointer to the mxArray.
  !!
  !! @param[out]    val         Variable to receive the data.
  !!
  !! @param[out]    stat        Error code - non zero on error.
  !!
  !*****************************************************************************

  SUBROUTINE MatlabGetAlloc_real2D(mxarray, val, stat)
    
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(OUT), ALLOCATABLE :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    INTEGER num_dims
    TYPE(C_PTR) dims_ptr
    INTEGER(mw_size), POINTER :: dims(:)
    
    !***************************************************************************
    
    num_dims = mxGetNumberOfDimensions(mxArray)
    IF (num_dims /= 2) THEN
      stat = 4    ! Wrong rank
      RETURN
    END IF
    
    dims_ptr = mxGetDimensions(mxarray)
    IF (.NOT. C_ASSOCIATED(dims_ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    CALL C_F_POINTER(dims_ptr, dims, [num_dims])
    
    ALLOCATE(val(dims(1),dims(2)), STAT=stat)
    IF (stat /= 0) RETURN
    
    CALL MatlabGetCopy(mxarray, val, stat)
  
  END SUBROUTINE MatlabGetAlloc_real2D

  
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! Structure mxArray operations
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetField_int
  !> Get a field as an INTEGER.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetField_int(mxstruct, index, name, val, stat, m, n)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    INTEGER, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: m
    INTEGER, INTENT(IN), OPTIONAL :: n
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGet(mxfield, val, stat, m, n)
    
  END SUBROUTINE MatlabGetField_int
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetField_logical
  !> Get a field as an LOGICAL.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetField_logical(mxstruct, index, name, val, stat, m, n)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    LOGICAL, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: m
    INTEGER, INTENT(IN), OPTIONAL :: n
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGet(mxfield, val, stat, m, n)
    
  END SUBROUTINE MatlabGetField_logical
     
     
  !> Get a field as a mxArray pointer.
  SUBROUTINE MatlabGetField_mxArray(mxstruct, index, name, mxField, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    TYPE(C_PTR), INTENT(OUT) :: mxField
    INTEGER, INTENT(OUT) :: stat
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField
      RETURN
    END IF
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetField_mxArray

  
  !> Get a field as a REAL.
  SUBROUTINE MatlabGetField_real(mxstruct, index, name, val, stat, m, n)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    REAL, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN), OPTIONAL :: m
    INTEGER, INTENT(IN), OPTIONAL :: n
    
    ! Local variables
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGet(mxfield, val, stat, m, n)
    
  END SUBROUTINE MatlabGetField_real
   

  !> Get a field as a CHARACTER.
  SUBROUTINE MatlabGetField_char(mxstruct, index, name, val, stat)

    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    CHARACTER(:), ALLOCATABLE, INTENT(OUT) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGet(mxfield, val, stat)
    
  END SUBROUTINE MatlabGetField_char


  !> Copies a field as a one dimensional INTEGER array
  SUBROUTINE MatlabGetFieldCopy_int1D(mxStruct, index, name, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxStruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    INTEGER, INTENT(OUT) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxStruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxField)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGetCopy(mxfield, val, stat)
    
  END SUBROUTINE MatlabGetFieldCopy_int1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetFieldPtr_double1D
  !> Get a field as a one dimensional REAL array pointer.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetFieldPtr_double1D(mxStruct, index, name, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxStruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    REAL(C_DOUBLE), INTENT(OUT), POINTER :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) :: mxField
    TYPE(C_PTR) :: real_ptr
    
    !***************************************************************************
    
    mxField = mxGetField( mxStruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxField)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    real_ptr = mxGetPr(mxField)
    IF (.NOT. C_ASSOCIATED(real_ptr)) THEN
      stat = merrUnspecified
      RETURN
    END IF
    CALL C_F_POINTER(real_ptr, val)
    stat = merrSuccess
    
  END SUBROUTINE MatlabGetFieldPtr_double1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetFieldCopy_real1D
  !> Copies a field as a one dimensional REAL array
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetFieldCopy_real1D(mxstruct, index, name, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    REAL, INTENT(OUT) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    ! Local variables
    TYPE(C_PTR) mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGetCopy(mxfield, val, stat)
    
  END SUBROUTINE MatlabGetFieldCopy_real1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetFieldAlloc_real1D
  !> Allocates an appropriate sized array and then copies across the data in
  !! the field
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetFieldAlloc_real1D(mxstruct, index, name, val, stat)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    REAL, INTENT(OUT), ALLOCATABLE :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGetAlloc(mxfield, val, stat)
    
  END SUBROUTINE MatlabGetFieldAlloc_real1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabGetFieldAlloc_real2D
  !> Allocates an appropriate sized array and then copies across the data in
  !! the field
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabGetFieldAlloc_real2D(mxstruct, index, name, val, stat)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: index
    REAL, INTENT(OUT), ALLOCATABLE :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    
    !***************************************************************************
    
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
      stat = merrField  ! Field doesn't exist
      RETURN
    END IF
    CALL MatlabGetAlloc(mxfield, val, stat)
    
  END SUBROUTINE MatlabGetFieldAlloc_real2D
  
  
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! MatlabCreate functions
  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateField_real1D
  !> Creates a Matlab variable that holds a real vector.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreate_real1D(val) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    REAL, INTENT(IN) :: val(:)
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    ! Fortran equivalent of data_ptr.
    REAL(C_DOUBLE), POINTER :: fptr(:)    
    
    !***************************************************************************

    pm = mxCreateDoubleMatrix(SIZE(val, KIND=mw_size), 1_mw_size, mxREAL)
    IF (.NOT. C_ASSOCIATED(pm)) RETURN
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    mxarray = pm
  
  END FUNCTION MatlabCreate_real1D
  
  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateField_real2D
  !> Creates a Matlab variable that holds a 2D real array.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreate_real2D(val) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    REAL, INTENT(IN) :: val(:,:)
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    ! Fortran equivalent of data_ptr.
    REAL(C_DOUBLE), POINTER :: fptr(:,:)
        
    !***************************************************************************

    pm = mxCreateDoubleMatrix( SIZE(val,1,KIND=mw_size),  &
        SIZE(val,2,KIND=mw_size), mxREAL )
    IF (.NOT. C_ASSOCIATED(pm)) RETURN
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    mxarray = pm
  
  END FUNCTION MatlabCreate_real2D

  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateField_real3D
  !> Creates a Matlab variable that holds a 3D real array.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreate_real3D(val) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    REAL, INTENT(IN) :: val(:,:,:)
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER(mw_size) :: dims(3)
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    ! Fortran equivalent of data_ptr.
    REAL(C_DOUBLE), POINTER :: fptr(:,:,:)    
    
    !***************************************************************************

    dims = SHAPE(val)
    pm = mxCreateNumericArray(3_mw_size, dims, mxDOUBLE_CLASS, mxREAL)
    IF (.NOT. C_ASSOCIATED(pm)) RETURN    
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    mxarray = pm
  
  END FUNCTION MatlabCreate_real3D

  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateField_real4D
  !> Creates a Matlab variable that holds a 4D real array.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreate_real4D(val) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    REAL, INTENT(IN) :: val(:,:,:,:)
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER(mw_size) :: dims(4)
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    ! Fortran equivalent of data_ptr.
    REAL(C_DOUBLE), POINTER :: fptr(:,:,:,:)    
    
    !***************************************************************************

    dims = SHAPE(val)
    pm = mxCreateNumericArray(4_mw_size, dims, mxDOUBLE_CLASS, mxREAL)
    IF (.NOT. C_ASSOCIATED(pm)) RETURN    
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    mxarray = pm
  
  END FUNCTION MatlabCreate_real4D

  
  !*****************************************************************************
  !!
  !! FUNCTION MatlabCreateField_real4D
  !> Creates a Matlab variable that holds a 4D real array.
  !!
  !*****************************************************************************
  
  FUNCTION MatlabCreate_real5D(val) RESULT(mxarray)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    REAL, INTENT(IN) :: val(:,:,:,:,:)
    
    ! Function result
    TYPE(C_PTR) :: mxarray
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER(mw_size) :: dims(5)    
    TYPE(C_PTR) :: pm    
    TYPE(C_PTR) :: data_ptr    
    ! Fortran equivalent of data_ptr.
    REAL(C_DOUBLE), POINTER :: fptr(:,:,:,:,:)    
    
    !***************************************************************************

    dims = SHAPE(val)
    pm = mxCreateNumericArray(5_mw_size, dims, mxDOUBLE_CLASS, mxREAL)
    IF (.NOT. C_ASSOCIATED(pm)) RETURN    
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    mxarray = pm
  
  END FUNCTION MatlabCreate_real5D

  
  !-----------------------------------------------------------------------------  
  !-----------------------------------------------------------------------------
  !
  ! MatlabSet functions
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabSet_real
  !!
  !! The target must have a class id of mxDOUBLE_CLASS.
  !!
  !! Changes the size of the target to be a scalar.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabSet_real(mxarray, val, stat)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: data_ptr, old_data_ptr
    REAL(C_DOUBLE), POINTER :: fptr
    
    !***************************************************************************
        
    IF (mxGetClassID(mxarray) /= mxDOUBLE_CLASS) THEN
      stat = merrWrongClass
      RETURN
    END IF
        
    data_ptr = mxGetPr(mxarray)
    IF (.NOT. C_ASSOCIATED(data_ptr)) THEN
      CALL allocate_and_set_data_ptr(mxarray, 1, data_ptr, stat)
      IF (stat /= 0) RETURN
    ELSE
      ! check we are big enough for a scalar double
      IF (mxGetNumberOfElements(mxarray) < 1) THEN
        old_data_ptr = data_ptr
        CALL allocate_and_set_data_ptr(mxarray, 1, data_ptr, stat)
        IF (stat /= 0) RETURN
        CALL mxFree(old_data_ptr)
      END IF
    END IF
    
    ! copy data
    CALL C_F_POINTER(data_ptr, fptr)
    fptr = val
    
    ! Delete imaginary data, if it exists
    data_ptr = mxGetPi(mxarray)
    IF (C_ASSOCIATED(data_ptr)) THEN
      CALL mxSetPi(mxarray, C_NULL_PTR)
    END IF
    
    ! Set size of the array
    stat = mxSetDimensions(mxarray, [1_mw_size, 1_mw_size], 2_mw_size)
    
  END SUBROUTINE MatlabSet_real
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabSetCopy_int1D
  !!
  !! Requires the target to already be the right sized matrix.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabSetCopy_int1D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(IN) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    REAL(C_DOUBLE), POINTER :: data_ptr(:)
    
    !***************************************************************************
    
    CALL MatlabGetPtr(mxarray, data_ptr, stat)
    IF (stat /= 0) RETURN
    data_ptr = val
    stat = merrSuccess
    
  END SUBROUTINE MatlabSetCopy_int1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabSetCopy_real1D
  !!
  !! Requires the target to already be the right sized matrix.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabSetCopy_real1D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(IN) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    REAL(C_DOUBLE), POINTER :: data_ptr(:)
    
    !***************************************************************************
    
    CALL MatlabGetPtr(mxarray, data_ptr, stat)
    IF (stat /= 0) RETURN
    data_ptr = val
    stat = merrSuccess
    
  END SUBROUTINE MatlabSetCopy_real1D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabSetCopy_real2D
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabSetCopy_real2D(mxarray, val, stat)
  
    ! Arguments
    TYPE(C_PTR), INTENT(IN) :: mxarray
    REAL, INTENT(IN) :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    REAL(C_DOUBLE), POINTER :: data_ptr(:,:)
    
    !***************************************************************************
    
    CALL MatlabGetPtr(mxarray, data_ptr, stat)
    IF (stat /= 0) RETURN
    data_ptr = val
    stat = merrSuccess
    
  END SUBROUTINE MatlabSetCopy_real2D
  
  
  !-----------------------------------------------------------------------------  
  !-----------------------------------------------------------------------------
  !
  ! MatlabSetField functions
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabSetField_real
  !> Copies a REAL value across to a field in a Matlab structure.
  !!
  !! If the structure doesn't contain the field the the field is created.  If 
  !! the array held by the structure for the given field isn't large enough to
  !! hold the value it is expanded.
  !!
  !! If the field already exists it must be of class mxDOUBLE_CLASS.
  !!
  !! If you want to just set the field to be a single scalar, then use
  !! MatlabCreateField.
  !!
  !! @param[in]     m                 Row coordinate.
  !!
  !! @param[in]     n                 Column coordinate.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabSetField_real(mxstruct, index, name, val, stat, m, n)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    REAL, INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    INTEGER, INTENT(IN) :: m
    INTEGER, INTENT(IN) :: n
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: mxfield
    TYPE(C_PTR) :: data_ptr
    REAL(C_DOUBLE), POINTER :: fptr(:)
    
    !***************************************************************************

    ! See if the field already exists
    mxfield = mxGetField( mxstruct, INT(index - 1, mw_index),  &
        name // C_NULL_CHAR )
    IF (.NOT. C_ASSOCIATED(mxfield)) THEN
    
      ! The field doesn't exist - create it from scratch.
      mxfield = mxCreateDoubleMatrix(INT(m, mw_size), INT(n, mw_size), mxREAL)
      IF (.NOT. C_ASSOCIATED(mxfield)) THEN
        stat = merrMemory
        RETURN
      END IF      
      CALL replace_field(mxstruct, index, name, mxfield, stat)
      
    ELSE
    
      ! See if the field is the right type
      IF (mxGetClassID(mxfield) /= mxDOUBLE_CLASS) THEN
        stat = merrWrongClass
        RETURN
      END IF
      
      ! See if we need to expand the field.
      IF (.NOT. is_big_enough(mxfield, m, n)) THEN
        ! Need to expand
        CALL grow_array(mxfield, m, n, stat)
        IF (stat /= 0) RETURN
      END IF
      
    END IF
    
    CALL C_F_POINTER(mxGetPr(mxfield), fptr, [mxGetNumberOfElements(mxfield)])
    fptr(get_fortran_index_from_two(mxfield, m, n)) = val
    
    data_ptr = mxGetPi(mxfield)
    IF (C_ASSOCIATED(data_ptr)) THEN
      CALL C_F_POINTER(data_ptr, fptr, [mxGetNumberOfElements(mxfield)])
      fptr(get_fortran_index_from_two(mxfield, m, n)) = 0
    END IF      
    
    stat = merrSuccess
    
  END SUBROUTINE MatlabSetField_real
    
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_real
  !> Creates a field in a Matlab structure that holds a single real value.
  !!
  !! If the structure already contains the field then its current contents
  !! are replaced.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_real(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    REAL, INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    
    !***************************************************************************

    pm = mxCreateDoubleScalar(val)
    IF (.NOT. C_ASSOCIATED(pm)) THEN
      stat = merrMemory
      RETURN
    END IF
    
    CALL replace_field(mxstruct, index, name, pm, stat)    
    IF (stat /= 0) THEN
      CALL mxDestroyArray(pm)
    END IF
      
  END SUBROUTINE MatlabCreateField_real
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_real1D
  !> Creates a field in a Matlab structure that holds a real vector.
  !!
  !! If the structure already contains the field then its current contents
  !! are replaced.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_real1D(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    REAL, INTENT(IN) :: val(:)
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    REAL(C_DOUBLE), POINTER :: fptr(:)
    
    !***************************************************************************

    pm = mxCreateDoubleMatrix(SIZE(val, KIND=mw_size), 1_mw_size, mxREAL)
    IF (.NOT. C_ASSOCIATED(pm)) THEN
      stat = merrMemory
      RETURN
    END IF    
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    CALL replace_field(mxstruct, index, name, pm, stat)
    IF (stat /= 0) THEN
      CALL mxDestroyArray(pm)
    END IF
    
  END SUBROUTINE MatlabCreateField_real1D
  
    
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_real1D
  !> Creates a field in a Matlab structure that holds a real array.
  !!
  !! If the structure already contains the field then its current contents
  !! are replaced.
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_real2D(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    REAL, INTENT(IN) :: val(:,:)
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    TYPE(C_PTR) :: data_ptr
    REAL(C_DOUBLE), POINTER :: fptr(:,:)
    
    !***************************************************************************

    pm = mxCreateDoubleMatrix( SIZE(val,1,KIND=mw_size),  &
        SIZE(val,2,KIND=mw_size), mxREAL )
    IF (.NOT. C_ASSOCIATED(pm)) THEN
      stat = merrMemory
      RETURN
    END IF    
    data_ptr = mxGetPr(pm)
    CALL C_F_POINTER(data_ptr, fptr, SHAPE(val))
    fptr = val
    
    CALL replace_field(mxstruct, index, name, pm, stat)
    IF (stat /= 0) THEN
      CALL mxDestroyArray(pm)
    END IF
      
  END SUBROUTINE MatlabCreateField_real2D
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_char
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_char(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    CHARACTER(*), INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    
    !***************************************************************************
    
    pm = mxCreateString(val // C_NULL_CHAR)
    IF (.NOT. C_ASSOCIATED(pm)) THEN
      stat = merrMemory
      RETURN
    END IF    
        
    CALL replace_field(mxstruct, index, name, pm, stat)
    IF (stat /= 0) THEN
      CALL mxDestroyArray(pm)
    END IF
    
  END SUBROUTINE MatlabCreateField_char

    
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_int
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_int(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    INTEGER, INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm
    
    !***************************************************************************
    
    pm = mxCreateDoubleScalar(REAL(val, C_DOUBLE))
    IF (.NOT. C_ASSOCIATED(pm)) THEN
      stat = merrMemory
      RETURN
    END IF

    CALL replace_field(mxstruct, index, name, pm, stat)
    IF (stat /= 0) THEN
      CALL mxDestroyArray(pm)
    END IF
    
  END SUBROUTINE MatlabCreateField_int

    
  !*****************************************************************************
  !!
  !! SUBROUTINE MatlabCreateField_mxarray
  !!
  !*****************************************************************************
  
  SUBROUTINE MatlabCreateField_mxarray(mxstruct, index, name, val, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    TYPE(C_PTR), INTENT(IN) :: val
    INTEGER, INTENT(OUT) :: stat
    
    !***************************************************************************
    
    CALL replace_field(mxstruct, index, name, val, stat)
    
  END SUBROUTINE MatlabCreateField_mxarray

    
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! Other support procedures
  
  
  !*****************************************************************************
  !!
  !! FUNCTION CharArrayToScalar
  !> Convert a null terminated array of CHARACTERs to a single CHARACTER 
  !! scalar with the appropriate length.
  !!
  !! @param[in]     array             Null terminated array of characters (for 
  !! example, from a C-function call).
  !!
  !! @return A default character scalar with a copy of the characters in 
  !! array. 
  !!
  !*****************************************************************************
  
  PURE FUNCTION CharArrayToScalar(array) RESULT(scalar)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: array
    ! Function result
    CHARACTER(LEN=CharArrayLen(array)) scalar
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER :: i
    
    !*************************************************************************            
    
    FORALL (i = 1:LEN(scalar)) scalar(i:i) = array(i)
    
  END FUNCTION CharArrayToScalar
    
    
  !***************************************************************************
  !!
  !! FUNCTION CharArrayLen
  !> Determines the length of a null terminated character array.
  !!
  !! @param[in]     array     Null terminated array of characters (for 
  !! example, from a C-function call).
  !!
  !! @return Number of characters in array, up to but not including the 
  !! first null character.
  !!
  !***************************************************************************
      
  PURE FUNCTION CharArrayLen(array) RESULT(l)
  
    !---------------------------------------------------------------------------
    ! Arguments
    
    CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: array      
    ! Function result
    INTEGER :: l
    
    !*************************************************************************
    
    l = 0
    DO WHILE(array(l+1) /= C_NULL_CHAR)
      l = l + 1
    END DO
    
  END FUNCTION CharArrayLen
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE CharScalarToArray
  !> Copy from a charater scalar to an NULL terminated array.
  !!
  !! @param[in]     scalar            The character scalar.
  !!
  !! @param[out]    array             The output array, that will be allocated
  !! to LEN(scalar) + 1 and terminated with a NULL character.
  !!
  !*****************************************************************************
  
  FUNCTION CharScalarToArray(scalar) RESULT(array)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    CHARACTER(*), INTENT(IN) :: scalar
    CHARACTER(KIND=C_CHAR) :: array(LEN(scalar)+1)
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER :: i
    
    !***************************************************************************
    
    FORALL(i = 1:LEN(scalar)) array(i) = scalar(i:i)
    array(SIZE(array)) = C_NULL_CHAR    
    
  END FUNCTION CharScalarToArray
      
  
  !*****************************************************************************
  !!
  !! SUBROUTINE AllocArrayFromCharScalar
  !> Copy from a charater scalar to an allocatable NULL terminated array.
  !!
  !! @param[in]     scalar            The character scalar.
  !!
  !! @param[out]    array             The output array, that will be allocated
  !! to LEN(scalar) + 1 and terminated with a NULL character.
  !!
  !*****************************************************************************
  
  SUBROUTINE AllocArrayFromCharScalar(scalar, array)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    CHARACTER(*), INTENT(IN) :: scalar
    CHARACTER(KIND=C_CHAR), INTENT(OUT), ALLOCATABLE :: array(:)
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER :: i
    
    !***************************************************************************
    
    ALLOCATE(array(LEN(scalar) + 1))
    FORALL(i = 1:LEN(scalar)) array(i) = scalar(i:i)
    array(SIZE(array)) = C_NULL_CHAR    
    
  END SUBROUTINE AllocArrayFromCharScalar
      
  
  !-----------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  !
  ! Conversion functions
    
      
  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_int8(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT8_T), POINTER :: dp(:)      
    INTEGER(1), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_int8


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_int16(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT16_T), POINTER :: dp(:)      
    INTEGER(2), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_int16


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_int32(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT32_T), POINTER :: dp(:)      
    INTEGER(4), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_int32


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_int64(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT64_T), POINTER :: dp(:)      
    INTEGER(8), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_int64


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_single(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    REAL(C_FLOAT), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_single 
  
  
  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_double(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    REAL(C_DOUBLE), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_double
      
      
  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE real_from_logical(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    REAL, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_SIGNED_CHAR), POINTER :: dp(:)
    INTEGER(1), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE real_from_logical
      
      
  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_int8(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT8_T), POINTER :: dp(:)      
    INTEGER(1), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_int8


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_int16(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT16_T), POINTER :: dp(:)      
    INTEGER(2), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_int16


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_int32(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT32_T), POINTER :: dp(:)      
    INTEGER(4), POINTER :: dp(:)
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_int32


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_int64(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_INT64_T), POINTER :: dp(:)      
    INTEGER(8), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_int64


  !***************************************************************************
  !
  !
  !! @param[in]     idx               One based index into the array.
  !!
  !***************************************************************************    
  
  SUBROUTINE int_from_single(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    REAL(C_FLOAT), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_single 

  
  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_double(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    REAL(C_DOUBLE), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_double


  !***************************************************************************
  !
  !***************************************************************************    
  
  SUBROUTINE int_from_logical(data_ptr, count, val, idx)    
  
    TYPE(C_PTR), INTENT(IN) :: data_ptr
    INTEGER, INTENT(IN) :: count
    INTEGER, INTENT(OUT) :: val(*)
    INTEGER, INTENT(IN), OPTIONAL :: idx
    
    !INTEGER(C_SIGNED_CHAR), POINTER :: dp(:)
    INTEGER(1), POINTER :: dp(:)      
    
    !*************************************************************************      
    
    CALL C_F_POINTER(data_ptr, dp, [count])
    IF (.NOT. PRESENT(idx)) THEN
      val(1:count) = dp
    ELSE 
      ! m is present
      val(1) = dp(idx)
    END IF    
    
  END SUBROUTINE int_from_logical
      
  
  !*****************************************************************************
  !!
  !! Returns a one based index into a one dimensional sequence of the given
  !! array that corresponds to the given row (@a m) and column (@a n) 
  !! ordinates.
  !!
  !*****************************************************************************
      
  FUNCTION get_fortran_index_from_two(mxarray, m, n) RESULT(idx)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(IN) :: m
    INTEGER, INTENT(IN) :: n

    ! Function result    
    INTEGER :: idx
    
    !---------------------------------------------------------------------------
    ! Local variables
  
    INTEGER(mw_index) :: subs(2)
    
    !***************************************************************************
  
    subs(1) = m - 1
    subs(2) = n - 1
    
    idx = mxCalcSingleSubscript(mxarray, 2_mw_size, subs) + 1
    
  END FUNCTION get_fortran_index_from_two
  
  
  !*****************************************************************************
  !!
  !! Returns a one based index into a one dimensional sequence of the given
  !! array that corresponds to the given row (@a m) and column (@a n) 
  !! ordinates.  If the arguments are not present then 1 is assumed.
  !!
  !*****************************************************************************
      
  FUNCTION get_fortran_index(mxarray, m, n) RESULT(idx)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(IN), OPTIONAL :: m
    INTEGER, INTENT(IN), OPTIONAL :: n

    ! Function result    
    INTEGER :: idx
    
    !---------------------------------------------------------------------------
    ! Local variables
  
    INTEGER(mw_index) :: subs(2)
    
    !***************************************************************************
  
    IF (PRESENT(m)) THEN
      subs(1) = m - 1
    ELSE
      subs(1) = 0
    END IF
    
    IF (PRESENT(n)) THEN
      subs(2) = n - 1
    ELSE
      subs(2) = 0
    END IF
    
    idx = mxCalcSingleSubscript(mxarray, 2_mw_size, subs) + 1
    
  END FUNCTION get_fortran_index
  
  
  SUBROUTINE allocate_and_set_data_ptr(mxarray, n, data_ptr, stat)
  
    !---------------------------------------------------------------------------
    ! Arguments
  
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(IN) :: n
    TYPE(C_PTR), INTENT(OUT) :: data_ptr
    INTEGER, INTENT(OUT) :: stat
    
    !*************************************************************************
    
    ! The 8 byte allowance per element is platform specific.
    ! @todo replace with C_SIZEOF
    data_ptr = mxCalloc(INT(n, mw_size), 8_mw_size)
    IF (.NOT. C_ASSOCIATED(data_ptr)) THEN
      ! memory allocation failed
      stat = merrMemory
      RETURN
    END IF
    CALL mxSetPr(mxarray, data_ptr)
    stat = merrSuccess
    
  END SUBROUTINE allocate_and_set_data_ptr
    
  
  !*****************************************************************************
  !!
  !! @ returns .TRUE. if the array is big enough to hold the given element
  !! index.
  !!
  !*****************************************************************************
  
  FUNCTION is_big_enough(mxarray, m, n) RESULT(r)
  
    TYPE(C_PTR), INTENT(IN) :: mxarray
    INTEGER, INTENT(IN) :: m
    INTEGER, INTENT(IN) :: n
    ! Function result
    LOGICAL :: r
    
    !***************************************************************************
    
    r = (m <= mxGetM(mxarray)) .AND. (n <= mxGetN(mxarray))
  
  END FUNCTION is_big_enough
  
  
  !*****************************************************************************
  !!
  !! mxarray must be two dimensional.
  !!
  !*****************************************************************************
  
  SUBROUTINE grow_array(mxarray, m, n, stat)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR) :: mxarray
    INTEGER, INTENT(IN) :: m
    INTEGER, INTENT(IN) :: n
    INTEGER, INTENT(OUT) :: stat

    !---------------------------------------------------------------------------
    ! Local variables
    
    INTEGER :: m_old, n_old
    
    TYPE(C_PTR) :: old_ptr
    TYPE(C_PTR) :: new_ptr
    REAL(C_DOUBLE), POINTER :: new_fptr(:)
    REAL(C_DOUBLE), POINTER :: old_fptr(:)

    REAL(C_DOUBLE), POINTER :: new_fptri(:)
    REAL(C_DOUBLE), POINTER :: old_fptri(:)
    
    TYPE(C_PTR) :: new_mxarray
    
    INTEGER :: ic, ir
    INTEGER(mw_index) :: inew, iold
    
    !***************************************************************************
    
    ! Check dimension count - we can only deal with two.
    IF (mxGetNumberOfDimensions(mxarray) > 2) THEN
      stat = merrWrongDims
      RETURN
    END IF
    
    ! Check existing size
    m_old = mxGetM(mxarray)
    n_old = mxGetN(mxarray)    
    IF ((m_old >= m) .AND. (n_old >= n)) THEN
      ! Array is already big enough - not an error.
      stat = merrSuccess
      RETURN
    END IF
          
    !---------------------------------------------------------------------------
    ! Create an mxarray that is of the grown size    
    
    ! Check whether it is real or complex
    old_ptr = mxGetPi(mxarray)
    IF (C_ASSOCIATED(old_ptr)) THEN
      ! real and complex
      new_mxarray = mxCreateDoubleMatrix( INT(MAX(m, m_old), mw_size),  &
          INT(MAX(n, n_old), mw_size), mxCOMPLEX )
    ELSE
      ! real only
      new_mxarray = mxCreateDoubleMatrix( INT(MAX(m, m_old), mw_size),  &
          INT(MAX(n, n_old), mw_size), mxREAL )
    END IF
    IF (.NOT. C_ASSOCIATED(new_mxarray)) THEN
      stat = merrMemory
    END IF
    ! Need to destroy array before return from this point on.
    
    !---------------------------------------------------------------------------
    ! Set fortran pointers.
    IF (C_ASSOCIATED(old_ptr)) THEN
      CALL C_F_POINTER( old_ptr, old_fptri,  &
          [mxGetNumberOfElements(mxarray)] )
          
      new_ptr = mxGetPi(new_mxarray)
      CALL C_F_POINTER( new_ptr, new_fptri,  &
          [mxGetNumberOfElements(new_mxarray)] )
    ELSE
      ! Use fortran pointers to flag that there is no imaginary data.
      old_fptri => NULL()
      new_fptri => NULL()
    END IF
    
    old_ptr = mxGetPr(mxarray)
    CALL C_F_POINTER( old_ptr, old_fptr,  &
        [mxGetNumberOfElements(mxarray)] )
        
    new_ptr = mxGetPr(new_mxarray)
    CALL C_F_POINTER( new_ptr, new_fptr,  &
        [mxGetNumberOfElements(new_mxarray)] )
              
    !---------------------------------------------------------------------------
    ! Copy data between fortran pointers
    
    DO ic = 1, n
      DO ir = 1, m 
        IF ((ir <= m_old) .AND. (ic <= n_old)) THEN
          inew = get_fortran_index_from_two(new_mxarray, ir, ic)
          iold = get_fortran_index_from_two(mxarray, ir, ic)
          new_fptr(inew) = old_fptr(iold)
          IF (ASSOCIATED(old_fptri)) new_fptri(inew) = old_fptri(iold)
        END IF
      END DO
    END DO
    
    ! swap data pointers
    CALL swap_ptr(new_mxarray, mxarray)
    
    ! Cleanup
    CALL mxDestroyArray(new_mxarray)
    
  END SUBROUTINE grow_array
  
  
  !*****************************************************************************
  !!
  !> Swaps the real data of two mxarrays.
  !!
  !*****************************************************************************
  
  SUBROUTINE swap_ptr(a, b)
    
    !---------------------------------------------------------------------------
    ! Arguments
    
    TYPE(C_PTR), INTENT(INOUT) :: a
    TYPE(C_PTR), INTENT(INOUT) :: b
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: tmp
    
    !***************************************************************************
    
    tmp = mxGetPr(a)
    CALL mxSetPr(a, mxGetPr(b))
    CALL mxSetPr(b, tmp)
    
  END SUBROUTINE swap_ptr            
  
  
  !*****************************************************************************
  !!
  !! SUBROUTINE replace_field
  !> Replaces the field data with a give matrix.  
  !!
  !! @param[in]     mxstruct          The structure.
  !!
  !! @param[in]     index             One based index into @a mxstruct.
  !!
  !! @param[in]     name              Name of the field.
  !!
  !! @param[in]     pm                The matrix to put in the field.
  !!
  !! @param[out]    stat              Error code - non zero on error.
  !!
  !! If the field doesn't exist it is created.  Destroys the old contents of 
  !! the field.
  !!
  !*****************************************************************************
  
  SUBROUTINE replace_field(mxstruct, index, name, pm, stat)
  
    !---------------------------------------------------------------------------
    ! Arguments
  
    TYPE(C_PTR), INTENT(IN) :: mxstruct
    INTEGER, INTENT(IN) :: index
    CHARACTER(*), INTENT(IN) :: name
    TYPE(C_PTR), INTENT(IN) :: pm
    INTEGER, INTENT(OUT) :: stat
    
    !---------------------------------------------------------------------------
    ! Local variables
    
    TYPE(C_PTR) :: pm_old
    INTEGER(C_INT) :: field_num
    
    !***************************************************************************
    
    field_num = mxGetFieldNumber(mxstruct, name // C_NULL_CHAR)    
    IF (field_num < 0) THEN
      ! Error accessing existing contents - make sure we have a structure.
      IF (mxIsStruct(mxstruct) == 0) THEN
        stat = merrNotAStruct
        RETURN
      END IF
      ! The field doesn't exist - create it.
      field_num = mxAddField(mxstruct, name // C_NULL_CHAR)
      IF (field_num < 0) THEN
        stat = merrField
        RETURN
      END IF
      pm_old = C_NULL_PTR
    ELSE
      pm_old = mxGetFieldByNumber( mxstruct, INT(index - 1, mw_index),  &
          field_num )
    END IF
    CALL mxSetFieldByNumber(mxstruct, INT(index - 1, mw_index), field_num, pm)
    IF (C_ASSOCIATED(pm_old)) CALL mxDestroyArray(pm_old)
    stat = merrSuccess
    
  END SUBROUTINE replace_field
      
END MODULE MatlabUtils