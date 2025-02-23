REPORT z_bapi_upload.


" Define a structure for material master data
TYPES : BEGIN OF LTY_DATA,
  MATNR TYPE MATNR,    " Material Number
  MBRSH TYPE MBRSH,    " Industry Sector
  MTART TYPE MTART,    " Material Type
  MAKTX TYPE MAKTX,    " Material Description
  MEINS TYPE MEINS ,    " Base Unit of Measure
  END OF LTY_DATA.

" Internal tables and work areas
DATA : LT_DATA TYPE TABLE OF LTY_DATA.  " Table to store uploaded data
DATA : LS_DATA TYPE LTY_DATA.           " Work area for processing data
DATA : LV_FILE TYPE STRING.             " File path
DATA : LS_HEADDATA TYPE BAPIMATHEAD.
DATA : LS_CLIENTDATA TYPE BAPI_MARA.
DATA : LS_CLIENTDATAX TYPE BAPI_MARAX.
DATA : LT_DESC TYPE TABLE OF BAPI_MAKT.
DATA : LS_DESC TYPE BAPI_MAKT.
DATA : LS_RETURN TYPE BAPIRET2.
DATA : LT_RETURN TYPE TABLE OF BAPIRET2.
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
      FILENAME            = LV_FILE
      HAS_FIELD_SEPARATOR = 'X'
    TABLES
      DATA_TAB            = LT_DATA
    EXCEPTIONS
      FILE_OPEN_ERROR     = 1
      FILE_READ_ERROR     = 2
      BAD_DATA_FORMAT     = 8
      OTHERS              = 17.
  IF SY-SUBRC <> 0.
    WRITE: / 'Error uploading file'.
  ENDIF.
  LOOP AT LT_DATA INTO LS_DATA.
    LS_HEADDATA-MATERIAL = LS_DATA-MATNR.
    LS_HEADDATA-IND_SECTOR = LS_DATA-MBRSH.
    LS_HEADDATA-MATL_TYPE = LS_DATA-MTART.
    LS_HEADDATA-BASIC_VIEW = 'X'.
    LS_CLIENTDATA-BASE_UOM = 'KG'.
    LS_CLIENTDATAX-BASE_UOM = 'X'.
    LS_DESC-LANGU = SY-LANGU.
    LS_DESC-MATL_DESC = LS_DATA-MAKTX.
    APPEND LS_DESC TO LT_DESC.
    CLEAR : LS_DESC.

    CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
      EXPORTING
        HEADDATA            = LS_HEADDATA
        CLIENTDATA          = LS_CLIENTDATA
        CLIENTDATAX         = LS_CLIENTDATAX
*       PLANTDATA           =
*       PLANTDATAX          =
*       FORECASTPARAMETERS  =
*       FORECASTPARAMETERSX =
*       PLANNINGDATA        =
*       PLANNINGDATAX       =
*       STORAGELOCATIONDATA =
*       STORAGELOCATIONDATAX       =
*       VALUATIONDATA       =
*       VALUATIONDATAX      =
*       WAREHOUSENUMBERDATA =
*       WAREHOUSENUMBERDATAX       =
*       SALESDATA           =
*       SALESDATAX          =
*       STORAGETYPEDATA     =
*       STORAGETYPEDATAX    =
*       FLAG_ONLINE         = ' '
*       FLAG_CAD_CALL       = ' '
*       NO_DEQUEUE          = ' '
*       NO_ROLLBACK_WORK    = ' '
      IMPORTING
        RETURN              = LS_RETURN
      TABLES
        MATERIALDESCRIPTION = LT_DESC
*       UNITSOFMEASURE      =
*       UNITSOFMEASUREX     =
*       INTERNATIONALARTNOS =
*       MATERIALLONGTEXT    =
*       TAXCLASSIFICATIONS  =
*       RETURNMESSAGES      =
*       PRTDATA             =
*       PRTDATAX            =
*       EXTENSIONIN         =
*       EXTENSIONINX        =
      .
    APPEND LS_RETURN TO LT_RETURN.
    CLEAR : LS_RETURN,LS_HEADDATA,LS_CLIENTDATA,LS_CLIENTDATAX.
    REFRESH : LT_DESC.
  ENDLOOP.

  LOOP AT LT_RETURN INTO LS_RETURN.
    WRITE : / LS_RETURN-MESSAGE.
  ENDLOOP.