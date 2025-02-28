*&---------------------------------------------------------------------*
*& Report  ZMKS_WRITE_IN_LOCAL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_WRITE_IN_LOCAL.

TYPES : BEGIN OF LTY_DATA,
        ONO TYPE ZDEONO_50,
  ODATE TYPE ZDEODATE_50,
  PM TYPE ZDEPM_50,
  TA TYPE ZDETA_50,
  END OF LTY_DATA.

DATA : LT_DATA TYPE TABLE OF LTY_DATA.
DATA : LWA_DATA TYPE LTY_DATA.

DATA : LV_ONO TYPE ZDEONO_50.

SELECT-OPTIONS :  S_ONO FOR LV_ONO.

SELECT ONO ODATE PM TA
  FROM ZORDH_50
  INTO TABLE LT_DATA
  WHERE ONO IN  S_ONO.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
*   BIN_FILESIZE            =
    FILENAME                = 'C:\Users\Manish\Desktop\SAP_File.txt'
*   FILETYPE                = 'ASC'
*   APPEND                  = ' '
    WRITE_FIELD_SEPARATOR   = 'X'
*   HEADER                  = '00'
*   TRUNC_TRAILING_BLANKS   = ' '
*   WRITE_LF                = 'X'
*   COL_SELECT              = ' '
*   COL_SELECT_MASK         = ' '
*   DAT_MODE                = ' '
*   CONFIRM_OVERWRITE       = ' '
*   NO_AUTH_CHECK           = ' '
*   CODEPAGE                = ' '
*   IGNORE_CERR             = ABAP_TRUE
*   REPLACEMENT             = '#'
*   WRITE_BOM               = ' '
*   TRUNC_TRAILING_BLANKS_EOL       = 'X'
*   WK1_N_FORMAT            = ' '
*   WK1_N_SIZE              = ' '
*   WK1_T_FORMAT            = ' '
*   WK1_T_SIZE              = ' '
*   WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*   SHOW_TRANSFER_STATUS    = ABAP_TRUE
*   VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
*   IMPORTING
*   FILELENGTH              =
  TABLES
    DATA_TAB                = LT_DATA
*   FIELDNAMES              =
  EXCEPTIONS
    FILE_WRITE_ERROR        = 1
    NO_BATCH                = 2
    GUI_REFUSE_FILETRANSFER = 3
    INVALID_TYPE            = 4
    NO_AUTHORITY            = 5
    UNKNOWN_ERROR           = 6
    HEADER_NOT_ALLOWED      = 7
    SEPARATOR_NOT_ALLOWED   = 8
    FILESIZE_NOT_ALLOWED    = 9
    HEADER_TOO_LONG         = 10
    DP_ERROR_CREATE         = 11
    DP_ERROR_SEND           = 12
    DP_ERROR_WRITE          = 13
    UNKNOWN_DP_ERROR        = 14
    ACCESS_DENIED           = 15
    DP_OUT_OF_MEMORY        = 16
    DISK_FULL               = 17
    DP_TIMEOUT              = 18
    FILE_NOT_FOUND          = 19
    DATAPROVIDER_EXCEPTION  = 20
    CONTROL_FLUSH_ERROR     = 21
     OTHERS                  = 22.
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.