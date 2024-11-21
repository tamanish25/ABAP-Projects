*&---------------------------------------------------------------------*
*& Report  ZMK2_CLASSICAL_REPORT_from_HEADER and ITEM TABLES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zfetch_order_data.

" Define the structure for order header
TYPES: BEGIN OF lty_order_header,
         ono   TYPE zdeono_50,
         odate TYPE zdate_50,
         ta    TYPE zdeta_50,
         curr  TYPE zdecur_50,
       END OF lty_order_header.

" Define the structure for order item
TYPES: BEGIN OF lty_order_item,
         ono      TYPE zdeono_50,
         item_no  TYPE zitemno_50,
         qty      TYPE zqty_50,
       END OF lty_order_item.

" Define the structure for output
TYPES: BEGIN OF lty_output,
         ono      TYPE zdeono_50,
         odate    TYPE zdate_50,
         ta       TYPE zdeta_50,
         curr     TYPE zdecur_50,
         item_no  TYPE zitemno_50,
         qty      TYPE zqty_50,
       END OF lty_output.

" Internal tables and work areas
DATA: lt_order_header TYPE TABLE OF lty_order_header,
      lwa_order_header TYPE lty_order_header.

DATA: lt_order_item TYPE TABLE OF lty_order_item,
      lwa_order_item TYPE lty_order_item.

DATA: lt_output TYPE TABLE OF lty_output,
      lwa_output TYPE lty_output.

" Local variable for order number
DATA: lv_ono TYPE zdeono_50.

" Define select-options for input with mandatory check
SELECT-OPTIONS: s_ono FOR lv_ono OBLIGATORY.

START-OF-SELECTION.

  " Fetch data from the order header table
  SELECT ono
         odate
         ta
         curr
    INTO TABLE lt_order_header
    FROM zordh_50
    WHERE ono IN s_ono.

  " Check if data exists in order header table
  IF lt_order_header IS NOT INITIAL.
    " Fetch data from the order item table using FOR ALL ENTRIES
    SELECT ono
           item_no
           qty
      INTO TABLE lt_order_item
      FROM zordi_50
      FOR ALL ENTRIES IN lt_order_header
      WHERE ono = lt_order_header-ono.

    " Combine data into output table
    LOOP AT lt_order_header INTO lwa_order_header.
      " Find matching entries in order item table
      LOOP AT lt_order_item INTO lwa_order_item WHERE ono = lwa_order_header-ono.
        CLEAR lwa_output.
        lwa_output-ono = lwa_order_header-ono.
        lwa_output-odate = lwa_order_header-odate.
        lwa_output-ta = lwa_order_header-ta.
        lwa_output-curr = lwa_order_header-curr.
        lwa_output-item_no = lwa_order_item-item_no.
        lwa_output-qty = lwa_order_item-qty.
        APPEND lwa_output TO lt_output.
      ENDLOOP.
    ENDLOOP.

    " Display combined output
    WRITE: / 'Combined Output Data:'.
    WRITE: / sy-uline.
    WRITE: / 'Order Number', 20 'Order Date', 40 'Transaction Amount', 60 'Currency', 80 'Item No', 100 'Quantity'.
    WRITE: / sy-uline.

    LOOP AT lt_output INTO lwa_output.
      WRITE: / lwa_output-ono,
               20 lwa_output-odate,
               40 lwa_output-ta,
               60 lwa_output-curr,
               80 lwa_output-item_no,
               100 lwa_output-qty.
    ENDLOOP.

  ELSE.
    WRITE: / 'No data found in the Order Header table for the selected Order Numbers.'.
  ENDIF.