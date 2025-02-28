*&---------------------------------------------------------------------*
*& Report  ZMKS_RTTS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_RTTS.

PARAMETERS p1_table type TABNAME.

data : o_typedescr type ref to cl_abap_typedescr,
      o_structdescr type ref to cl_abap_structdescr,
      o_tabledescr type ref to cl_abap_tabledescr.

***********************************************************************Dynamic instantiation

CALL METHOD CL_ABAP_TYPEDESCR=>DESCRIBE_BY_NAME
  EXPORTING
    P_NAME         = p1_table
  RECEIVING
    P_DESCR_REF    = O_TYPEDESCR
 EXCEPTIONS
       TYPE_NOT_FOUND = 1
    OTHERS         = 2
        .
IF SY-SUBRC eq 1.
Message ' Type not found' type 'i'.
elseif sy-subrc = 1.
  Message 'unknown exception' type 'i'.
ENDIF.

if o_typedescr is BOund.
************  type cast the object to appropriate desc

****************o_structdescr = o_typedescr

  o_structdescr ?= o_typedescr.

  endif.
  if o_structdescr is bound.
*    TRY.
    CALL METHOD CL_ABAP_TABLEDESCR=>CREATE
      EXPORTING
        P_LINE_TYPE  = o_structdescr
*        P_TABLE_KIND = TABLEKIND_STD
*        P_UNIQUE     = ABAP_FALSE
*        P_KEY        =
*        P_KEY_KIND   = KEYDEFKIND_DEFAULT
      RECEIVING
        P_RESULT     =  o_tabledescr
        .
*     CATCH CX_SY_TABLE_CREATION .
*    ENDTRY.

    endif.

*   create object
    data ref_wa type ref to data.
    data ref_itab type ref to data.

    create data ref_wa type handle o_structdescr.
    create data ref_itab type handle o_tabledescr.

*********************** value assignment


    field-symbols <fs>.   "Single field
    FIELD-SYMBOLS <fwa> type any. "work area
    field-symbols <ftab> type any table. "int table
    assign ref_wa->* to <fwa>.
    Assign ref_itab->* to <ftab>.

*************************** Retrieve data

    select * from (P1_TABLE) into Table <ftab>.

      if sy-subrc = 0.
        loop at <ftab> into <fwa>.
          do.
            Assign COMPONENT sy-index of structure <fwa> to <fs>.
            if sy-subrc = 0.
              write <fs>.
              else. exit.
              endif.
              enddo.
              new-line.
              endloop. endif.