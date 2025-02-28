*&---------------------------------------------------------------------*
*& Report  ZMKS_WRITE_IN_SAP_SERVER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_WRITE_IN_SAP_SERVER.


TYPES : BEGIN OF LTY_DATA,
        ONO TYPE ZDEONO_50,
  ODATE TYPE ZDEODATE_50,
  PM TYPE ZDEPM_50,

  END OF LTY_DATA.

DATA : LT_DATA TYPE TABLE OF LTY_DATA.
DATA : LWA_DATA TYPE LTY_DATA.
DATA : LV_FILENAME(20) TYPE C VALUE '/tmp/order.txt'.
DATA : LV_ONO TYPE ZDEONO_50.
DATA : LV_STRING TYPE STRING.

SELECT-OPTIONS :  S_ONO FOR LV_ONO.

SELECT ONO ODATE PM
  FROM ZORDH_50
  INTO TABLE LT_DATA
  WHERE ONO IN  S_ONO.

OPEN DATASET LV_FILENAME FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
IF SY-SUBRC = 0.
  LOOP AT LT_DATA INTO LWA_DATA.
    CONCATENATE LWA_DATA-ONO
    LWA_DATA-ODATE
    LWA_DATA-PM
    INTO LV_STRING SEPARATED BY '#'.
    TRANSFER lv_string to lv_filename.
  ENDLOOP.
  close DATASET lv_filename.
  ENDIF.