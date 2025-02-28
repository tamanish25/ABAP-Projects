FUNCTION ZMKS_ADD_NUMBERS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(GV_NUM1) TYPE  NUMC2
*"     REFERENCE(GV_NUM2) TYPE  NUMC2
*"  EXPORTING
*"     REFERENCE(GV_SUM) TYPE  NUMC3
*"  EXCEPTIONS
*"      NOT_ZERO
*"----------------------------------------------------------------------

  IF GV_NUM1 = 0 OR GV_NUM2 = 0.
    RAISE NOT_ZERO.
    else.
    GV_SUM = GV_NUM1 + GV_NUM2.
  ENDIF.


  ENDFUNCTION.