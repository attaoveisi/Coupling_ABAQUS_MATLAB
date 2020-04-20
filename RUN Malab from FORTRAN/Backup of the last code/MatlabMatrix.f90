! $Id: MatlabMatrix.f90 1891 2013-02-20 04:28:31Z ian $
!> @file
!! Defines the MatlabMatrix module.


!*******************************************************************************
!!
!! MODULE MatlabMatrix
!> Fortran wrappers for the contents of matrix.h.
!!
!*******************************************************************************

MODULE MatlabMatrix
  
  USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_PTR, C_INTPTR_T,  &
      C_SIZE_T, C_INT, C_CHAR, C_BOOL
  
  IMPLICIT NONE
  
  PRIVATE
  
  ! In the following, we assume that MX_COMPAT_32 was not defined in the 
  ! matlab header file tmwtypes.h.  If that symbol was defined, then the 
  ! mw_size and mw_index parameters should be C_INT_T instead.
  
  !> Integer kind to use for mwSize.
  !!
  !! Should be 4 on 32 bit, 8 on 64 bit.
  INTEGER, PARAMETER, PUBLIC :: mw_size = C_SIZE_T
  
  !> Integer kind to use for mwIndex.
  !!
  !! Should be 4 on 32 bit, 8 on 64 bit.
  INTEGER, PARAMETER, PUBLIC :: mw_index = C_SIZE_T
  
  !> Integer kind to use for mxChar
  INTEGER, PARAMETER, PUBLIC :: mw_char = 2   ! C_INT16_T
  
  !> mxClassID enum
  !!
  !! Used as return values from mxGetClassID.
  ENUM, BIND(C)
    !> The class cannot be determined.
    !!
    !! You cannot specify this category for an mxArray; however, mxGetClassID 
    !! can return this value if it cannot identify the class.
    ENUMERATOR :: mxUNKNOWN_CLASS = 0
    !> Identifies a cell mxArray.
    ENUMERATOR :: mxCELL_CLASS
    !> Identifies a structure mxArray.
    ENUMERATOR :: mxSTRUCT_CLASS
    !> Identifies a logical mxArray, an mxArray whose data is represented 
    !! as mxLogical.
    ENUMERATOR :: mxLOGICAL_CLASS
    !> Identifies a string mxArray, an mxArray whose data is represented 
    !! as mxChar.
    ENUMERATOR :: mxCHAR_CLASS
    !> Not documented.
    ENUMERATOR :: mxVOID_CLASS
    !> Identifies a numeric mxArray whose data is stored as double-precision, 
    !! floating-point numbers.
    ENUMERATOR :: mxDOUBLE_CLASS
    !> Identifies a numeric mxArray whose data is stored as single-precision, 
    !! floating-point numbers.
    ENUMERATOR :: mxSINGLE_CLASS
    !> Identifies a numeric mxArray whose data is stored as signed 8-bit 
    !! integers.
    ENUMERATOR :: mxINT8_CLASS
    !> Identifies a numeric mxArray whose data is stored as unsigned 8-bit 
    !! integers.
    ENUMERATOR :: mxUINT8_CLASS
    !> Identifies a numeric mxArray whose data is stored as signed 16-bit 
    !! integers.
    ENUMERATOR :: mxINT16_CLASS
    !> Identifies a numeric mxArray whose data is stored as unsigned 16-bit 
    !! integers.
    ENUMERATOR :: mxUINT16_CLASS
    !> Identifies a numeric mxArray whose data is stored as signed 32-bit 
    !! integers.
    ENUMERATOR :: mxINT32_CLASS
    !> Identifies a numeric mxArray whose data is stored as unsigned 32-bit 
    !! integers.
    ENUMERATOR :: mxUINT32_CLASS
    !> Identifies a numeric mxArray whose data is stored as signed 64-bit 
    !! integers.
    ENUMERATOR :: mxINT64_CLASS
    !> Identifies a numeric mxArray whose data is stored as unsigned 64-bit 
    !! integers.
    ENUMERATOR :: mxUINT64_CLASS
    !> Identifies a function handle mxArray.
    ENUMERATOR :: mxFUNCTION_CLASS
    ENUMERATOR :: mxOPAQUE_CLASS
    ENUMERATOR :: mxOBJECT_CLASS
  END ENUM
  
  ! Expose the above
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
  
  !> mxComplexity enum.
  ENUM, BIND(C)
    !> Identifies an mxArray with no imaginary components.
    ENUMERATOR :: mxREAL = 0
    !> Identifies an mxArray with imaginary components.
    ENUMERATOR :: mxCOMPLEX
  END ENUM
  
  ! Expose the above
  PUBLIC mxREAL
  PUBLIC mxCOMPLEX
  
  TYPE, BIND(C) :: NumberArrayType
    TYPE(C_PTR) :: pdata                     ! void  *pdata;
    TYPE(C_PTR) :: pimag_data                ! void  *pimag_data;
    TYPE(C_PTR) :: reserved5                 ! void  *reserved5;
    INTEGER(C_SIZE_T) :: reserved6(3)        ! size_t reserved6[3];
  END TYPE NumberArrayType
  
  TYPE, BIND(C) :: mxArrayInt
    TYPE(C_PTR) :: reserved                  ! void    *reserved;
    INTEGER(C_INT) :: reserved1(2)           ! int      reserved1[2];
    TYPE(C_PTR) :: reserved2                 ! void    *reserved2;
    INTEGER(C_SIZE_T) :: number_of_dims      ! size_t  number_of_dims;
    INTEGER(C_INT) :: reserved3              ! unsigned int reserved3;
    INTEGER(C_INT) :: flags                  ! flags bitfields;
    INTEGER(C_SIZE_T) :: reserved4(2)        ! size_t reserved4[2];
    TYPE(NumberArrayType) :: number_array    ! struct { } number_array;
  END TYPE mxArrayInt
  
  !> Interfaces to Matlab's external mx* routines.
  INTERFACE
    
    !> Add field to structure array.
    FUNCTION mxAddField(pm, fieldname) RESULT(field_num)  &
        BIND(C, NAME='mxAddField')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: fieldname
      INTEGER(C_INT) :: field_num
    END FUNCTION mxAddField
    
    !> Convert array to string.
    FUNCTION mxArrayToString(array_ptr) RESULT(c_str)  &
        BIND(C, NAME='mxArrayToString')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: array_ptr
      TYPE(C_PTR) :: c_str
    END FUNCTION mxArrayToString
    
    !> Offset from first element to desired element.
    FUNCTION mxCalcSingleSubscript(pm, nsubs, subs) RESULT(numel)  &
        BIND(C, NAME='mxCalcSingleSubscript')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_size), INTENT(IN), VALUE :: nsubs
      INTEGER(mw_index), INTENT(IN) :: subs(*)
      INTEGER(mw_index) :: numel
    END FUNCTION mxCalcSingleSubscript
    
    !> Allocate dynamic memory for array using MATLAB memory manager
    FUNCTION mxCalloc(n, size) RESULT(ptr) BIND(C, NAME='mxCalloc')
      IMPORT
      IMPLICIT NONE
      INTEGER(mw_size), INTENT(IN), VALUE :: n
      INTEGER(mw_size), INTENT(IN), VALUE :: size
      TYPE(C_PTR) ptr
    END FUNCTION mxCalloc
    
    !> Identifier corresponding to class.
    FUNCTION mxClassIDFromClassName(classname) RESULT(classid)  &
        BIND(C, NAME='mxClassIDFromClassName')
      IMPORT
      IMPLICIT NONE
      CHARACTER(KIND=C_CHAR), INTENT(IN) :: classname(*)
      INTEGER(KIND(mxUNKNOWN_CLASS)) :: classid
    END FUNCTION mxClassIDFromClassName
    
    !> Create 2-D, double-precision, floating-point mxArray initialized to 0.
    FUNCTION mxCreateDoubleMatrix(m, n, complexflag) RESULT(mxarray)  &
        BIND(C, NAME='mxCreateDoubleMatrix')
      IMPORT
      IMPLICIT NONE
      INTEGER(mw_size), INTENT(IN), VALUE :: m
      INTEGER(mw_size), INTENT(IN), VALUE :: n
      INTEGER(KIND(mxCOMPLEX)), INTENT(IN), VALUE :: complexflag
      TYPE(C_PTR) :: mxarray
    END FUNCTION mxCreateDoubleMatrix
    
    !> Create scalar, double-precision array initialised to specified value.
    FUNCTION mxCreateDoubleScalar(value) RESULT(mxarray)  &
        BIND(C, NAME='mxCreateDoubleScalar')
      IMPORT
      IMPLICIT NONE
      REAL(C_DOUBLE), INTENT(IN), VALUE :: value
      TYPE(C_PTR) :: mxarray
    END FUNCTION mxCreateDoubleScalar
    
    !> Create unpopulated N-D numeric mxArray.
    FUNCTION mxCreateNumericArray(ndim, dims, classid, complexflag)  &
        RESULT(mxarray) BIND(C, NAME='mxCreateNumericArray')
      IMPORT
      IMPLICIT NONE
      INTEGER(mw_size), INTENT(IN), VALUE :: ndim
      INTEGER(mw_size), INTENT(IN) :: dims(*)
      INTEGER(KIND(mxUNKNOWN_CLASS)), INTENT(IN), VALUE :: classid
      INTEGER(KIND(mxCOMPLEX)), INTENT(IN), VALUE :: complexflag
      ! Function result
      TYPE(C_PTR) :: mxarray
    END FUNCTION mxCreateNumericArray
    
    !> Create 1-by-N string mxArray initialized to specified string.
    FUNCTION mxCreateString(str) RESULT(pm) BIND(C, NAME='mxCreateString')
      IMPORT
      IMPLICIT NONE
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: str
      TYPE(C_PTR) :: pm
    END FUNCTION mxCreateString
    
    !> Create unpopulated N-D structure mxArray.
    FUNCTION mxCreateStructArray(ndim, dims, nfields, fieldnames) RESULT(ptr)  &
        BIND(C, NAME='mxCreateStructArray')
      IMPORT
      IMPLICIT NONE
      INTEGER(mw_size), INTENT(IN), VALUE :: ndim
      INTEGER(mw_size), INTENT(IN) :: dims(*)
      INTEGER(C_INT), INTENT(IN), VALUE :: nfields
      ! pointer to pointer to char - array of pointers
      TYPE(C_PTR), INTENT(IN) :: fieldnames(*)
      TYPE(C_PTR) :: ptr
    END FUNCTION mxCreateStructArray
    
    !> Create unpopulated 2-D structure mxArray.
    FUNCTION mxCreateStructMatrix(m, n, nfields, fieldnames) RESULT(ptr)  &
        BIND(C, NAME='mxCreateStructMatrix')
      IMPORT
      IMPLICIT NONE
      INTEGER(mw_size), INTENT(IN), VALUE :: m
      INTEGER(mw_size), INTENT(IN), VALUE :: n
      INTEGER(C_INT), INTENT(IN), VALUE :: nfields
      ! pointer to pointer to char - array of pointers
      TYPE(C_PTR), INTENT(IN) :: fieldnames(*)
      TYPE(C_PTR) :: ptr
    END FUNCTION mxCreateStructMatrix
    
    !> Free dynamic memory allocated by mxCreate* functions
    SUBROUTINE mxDestroyArray(pm) BIND(C, NAME='mxDestroyArray')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
    END SUBROUTINE mxDestroyArray
    
    !> Free dynamic memory allocated by mxCalloc, mxMalloc, or mxRealloc.
    SUBROUTINE mxFree(ptr) BIND(C, NAME='mxFree')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: ptr
    END SUBROUTINE mxFree
    
    !> Get class of mxArray.
    FUNCTION mxGetClassID(pm) RESULT(classid) BIND(C, NAME='mxGetClassID')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(KIND(mxUNKNOWN_CLASS)) classid
    END FUNCTION mxGetClassID
    
    !> Get pointer to dimensions array.
    FUNCTION mxGetDimensions(pm) RESULT(dim_ptr)  &
        BIND(C, NAME='mxGetDimensions')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      TYPE(C_PTR) :: dim_ptr
    END FUNCTION mxGetDimensions
    
    !> Get field value, given field name and index into structure array.
    FUNCTION mxGetField(pm, index, name) RESULT(field_ptr)  &
        BIND(C, NAME='mxGetField')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_index), INTENT(IN), VALUE :: index
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: name
      TYPE(C_PTR) :: field_ptr
    END FUNCTION mxGetField
    
    !> Get field value, given field number and index into structure array.
    FUNCTION mxGetFieldByNumber(pm, index, fieldnumber) RESULT(field_ptr)  &
        BIND(C, NAME='mxGetFieldByNumber')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_index), INTENT(IN), VALUE :: index
      INTEGER(C_INT), INTENT(IN), VALUE :: fieldnumber
      TYPE(C_PTR) :: field_ptr
    END FUNCTION mxGetFieldByNumber
    
    !> Get field number, give field name in structure array.
    FUNCTION mxGetFieldNumber(pm, fieldname) RESULT(num)  &
        BIND(C, NAME='mxGetFieldNumber')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: fieldname
      INTEGER(C_INT) :: num
    END FUNCTION mxGetFieldNumber
    
    !> Get number of rows in mxArray.
    FUNCTION mxGetM(pm) RESULT(m) BIND(C, NAME='mxGetM')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(C_SIZE_T) :: m
    END FUNCTION mxGetM
    
    !> Get number of columns in mxArray.
    FUNCTION mxGetN(pm) RESULT(n) BIND(C, NAME='mxGetN')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(C_SIZE_T) :: n
    END FUNCTION mxGetN
    
    !> Get number of dimensions in mxArray.
    FUNCTION mxGetNumberOfDimensions(pm) RESULT(num_dim)  &
        BIND(C, NAME='mxGetNumberOfDimensions')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_size) :: num_dim
    END FUNCTION mxGetNumberOfDimensions
    
    !> Get number of elements in mxArray.
    FUNCTION mxGetNumberOfElements(pm) RESULT(num_el)  &
        BIND(C, NAME='mxGetNumberOfElements')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_size) :: num_el
    END FUNCTION mxGetNumberOfElements
    
    !> Get a pointer to the imaginary data elements in an mxArray.
    FUNCTION mxGetPi(pm) RESULT(ptr) BIND(C, NAME='mxGetPi')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      TYPE(C_PTR) :: ptr
    END FUNCTION mxGetPi
    
    !> Get a pointer to the real data in an mxArray.
    FUNCTION mxGetPr(pm) RESULT(ptr) BIND(C, NAME='mxGetPr')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      TYPE(C_PTR) :: ptr
    END FUNCTION mxGetPr
    
    !> Get real component of first data element in mxArray.
    FUNCTION mxGetScalar(pm) RESULT(val) BIND(C, NAME='mxGetScalar')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      REAL(C_DOUBLE) :: val
    END FUNCTION mxGetScalar
    
    !> Determine whether input is structure mxArray.
    FUNCTION mxIsStruct(pm) RESULT(l) BIND(C, NAME='mxIsStruct')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(C_BOOL) :: l
    END FUNCTION mxIsStruct
    
    !> Modify number of dimensions and size of each dimension.
    FUNCTION mxSetDimensions(pm, dims, ndim) RESULT(val)  &
        BIND(C, NAME='mxSetDimensions')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_size), INTENT(IN) :: dims(*)
      INTEGER(mw_size), INTENT(IN), VALUE :: ndim
      INTEGER(C_INT) :: val
    END FUNCTION mxSetDimensions
    
    !> Set structure array field, given structure field name and array index.
    SUBROUTINE mxSetField(pm, index, fieldname, pvalue)  &
        BIND(C, NAME='mxSetField')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_index), INTENT(IN), VALUE :: index
      CHARACTER(KIND=C_CHAR), INTENT(IN), DIMENSION(*) :: fieldname
      TYPE(C_PTR), INTENT(IN), VALUE :: pvalue
    END SUBROUTINE mxSetField
    
    !> Set structure array field, given field number and index
    SUBROUTINE mxSetFieldByNumber(pm, index, fieldnumber, pvalue)  &
        BIND(C, NAME='mxSetFieldByNumber')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      INTEGER(mw_index), INTENT(IN), VALUE :: index
      INTEGER(C_INT), INTENT(IN), VALUE :: fieldnumber
      TYPE(C_PTR), INTENT(IN), VALUE :: pvalue
    END SUBROUTINE mxSetFieldByNumber
    
    !> Set new imaginary data for mxArray.
    SUBROUTINE mxSetPi(pm, pi) BIND(C, NAME='mxSetPi')
      IMPORT
      IMPLICIT NONE
      TYPE(C_PTR), INTENT(IN), VALUE :: pm
      TYPE(C_PTR), INTENT(IN), VALUE :: pi
    END SUBROUTINE mxSetPi
    
  END INTERFACE
  
  ! Expose above
  PUBLIC :: mxAddField
  PUBLIC :: mxArrayToString
  PUBLIC :: mxCalcSingleSubscript
  PUBLIC :: mxCalloc
  PUBLIC :: mxClassIDFromClassName
  PUBLIC :: mxCreateDoubleMatrix
  PUBLIC :: mxCreateDoubleScalar
  PUBLIC :: mxCreateNumericArray
  PUBLIC :: mxCreateString
  PUBLIC :: mxCreateStructMatrix
  PUBLIC :: mxDestroyArray
  PUBLIC :: mxFree
  PUBLIC :: mxGetClassID
  PUBLIC :: mxGetDimensions
  PUBLIC :: mxGetField
  PUBLIC :: mxGetFieldByNumber
  PUBLIC :: mxGetFieldNumber
  PUBLIC :: mxGetM
  PUBLIC :: mxGetN
  PUBLIC :: mxGetNumberOfDimensions
  PUBLIC :: mxGetNumberOfElements
  PUBLIC :: mxGetPi
  PUBLIC :: mxGetPr
  PUBLIC :: mxGetScalar
  PUBLIC :: mxIsStruct
  PUBLIC :: mxSetDimensions
  PUBLIC :: mxSetField
  PUBLIC :: mxSetFieldByNumber
  PUBLIC :: mxSetPi
  
END MODULE MatlabMatrix
