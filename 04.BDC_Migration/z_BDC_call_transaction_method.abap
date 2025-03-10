REPORT ZMKS_CALL_TRANSACTION.

" Define a structure for material master data
TYPES : BEGIN OF LTY_DATA,
  MATNR TYPE MATNR,    " Material Number
  MBRSH TYPE MBRSH,    " Industry Sector
  MTART TYPE MTART,    " Material Type
  MAKTX TYPE MAKTX,    " Material Description
  MEINS TYPE MEINS,    " Base Unit of Measure
  END OF LTY_DATA.

" Internal tables and work areas
DATA : LT_DATA TYPE TABLE OF LTY_DATA.  " Table to store uploaded data
DATA : LS_DATA TYPE LTY_DATA.           " Work area for processing data
DATA : LV_FILE TYPE STRING.             " File path
DATA : LT_BDCDATA TYPE TABLE OF BDCDATA. " Table for BDC data
DATA : LS_BDCDATA TYPE BDCDATA.         " Work area for BDC data
DATA : LT_MESSTAB TYPE TABLE OF BDCMSGCOLL. " Table for message logs
DATA : LS_MESSTAB TYPE BDCMSGCOLL.       " Work area for message logs
DATA : LV_MESSAGE TYPE STRING.           " String to hold message output

" File selection parameter
PARAMETERS : P_FILE TYPE LOCALFILE.

" File selection dialog box
AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      PROGRAM_NAME  = SYST-CPROG
      DYNPRO_NUMBER = SYST-DYNNR
      FIELD_NAME    = ' '
    IMPORTING
      FILE_NAME     = P_FILE.

  LV_FILE = P_FILE.

START-OF-SELECTION.

" Upload file data into internal table
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    FILENAME                = LV_FILE
    HAS_FIELD_SEPARATOR     = 'X'
  TABLES
    DATA_TAB                = LT_DATA
  EXCEPTIONS
    FILE_OPEN_ERROR         = 1
    FILE_READ_ERROR         = 2
    BAD_DATA_FORMAT         = 8
    OTHERS                  = 17.
IF SY-SUBRC <> 0.
  WRITE: / 'Error uploading file'.
ENDIF.

" Processing each record for BDC data
LOOP AT LT_DATA INTO LS_DATA.

  " Initial screen for MM01 transaction
  PERFORM BDC_DYNPRO      USING 'SAPLMGMM' '0060'.
  PERFORM BDC_FIELD       USING 'BDC_CURSOR' 'RMMG1-MTART'.
  PERFORM BDC_FIELD       USING 'BDC_OKCODE' '=ENTR'.
  PERFORM BDC_FIELD       USING 'RMMG1-MATNR' LS_DATA-MATNR.
  PERFORM BDC_FIELD       USING 'RMMG1-MBRSH' LS_DATA-MBRSH.
  PERFORM BDC_FIELD       USING 'RMMG1-MTART' LS_DATA-MTART.

  " Selecting the required views in MM01
  PERFORM BDC_DYNPRO      USING 'SAPLMGMM' '0070'.
  PERFORM BDC_FIELD       USING 'BDC_CURSOR' 'MSICHTAUSW-DYTXT(01)'.
  PERFORM BDC_FIELD       USING 'BDC_OKCODE' '=ENTR'.
  PERFORM BDC_FIELD       USING 'MSICHTAUSW-KZSEL(01)' 'X'.

  " Material description and unit of measure
  PERFORM BDC_DYNPRO      USING 'SAPLMGMM' '4004'.
  PERFORM BDC_FIELD       USING 'BDC_OKCODE' '=BU'.
  PERFORM BDC_FIELD       USING 'MAKT-MAKTX' LS_DATA-MAKTX.
  PERFORM BDC_FIELD       USING 'MARA-MEINS' 'KG'.
  PERFORM BDC_FIELD       USING 'MARA-MTPOS_MARA' 'NORM'.

  " Call MM01 transaction to create material
  CALL TRANSACTION 'MM01' USING LT_BDCDATA
        MODE 'E' UPDATE 'S' MESSAGES INTO LT_MESSTAB.
  REFRESH LT_BDCDATA.

ENDLOOP.

" Display messages
LOOP AT LT_MESSTAB INTO LS_MESSTAB.
  CALL FUNCTION 'MESSAGE_TEXT_BUILD'
    EXPORTING
      MSGID               = LS_MESSTAB-MSGID
      MSGNR               = LS_MESSTAB-MSGNR
      MSGV1               = LS_MESSTAB-MSGV1
      MSGV2               = LS_MESSTAB-MSGV2
      MSGV3               = LS_MESSTAB-MSGV3
      MSGV4               = LS_MESSTAB-MSGV4
    IMPORTING
      MESSAGE_TEXT_OUTPUT = LV_MESSAGE.
  WRITE : / LV_MESSAGE.
ENDLOOP.

" Subroutine for BDC screen navigation
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR LS_BDCDATA.
  LS_BDCDATA-PROGRAM  = PROGRAM.
  LS_BDCDATA-DYNPRO   = DYNPRO.
  LS_BDCDATA-DYNBEGIN = 'X'.
  APPEND LS_BDCDATA TO LT_BDCDATA.
ENDFORM.

" Subroutine for inserting fields in BDC session
FORM BDC_FIELD USING FNAM FVAL.
  CLEAR LS_BDCDATA.
  LS_BDCDATA-FNAM = FNAM.
  LS_BDCDATA-FVAL = FVAL.
  APPEND LS_BDCDATA TO LT_BDCDATA.
ENDFORM.
