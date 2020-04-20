#include "fintrf.h"


C
#if 0
C
C     fengdemo.F
C     .F file need to be preprocessed to generate .for equivalent
C
#endif
C
C     fengdemo.f
C
C     This is a simple program that illustrates how to call the MATLAB
C     Engine functions from a FORTRAN program.
C
C Copyright 1984-2011 The MathWorks, Inc.
C======================================================================
C 

      program main
C     Declarations
      implicit none
      mwPointer engOpen, engGetVariable, mxCreateDoubleMatrix
      mwPointer mxGetPr
      mwPointer ep, T, D 
      double precision time(10), dist(10)
      integer engPutVariable, engEvalString, engClose
      integer temp, status
      mwSize i
      data time / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0 /
      
      mwSize M, N
      parameter(M=1) 
      parameter(N=10) 
        write(6,*) 'kamyar kargani point'
C
      ep = engOpen('matlab')

C
        end
