REPORT z_calculator.

* Declare variables for the input and output
DATA: result TYPE string, " Result of the operation
      operation TYPE c.   " Selected operation

* Create selection screen
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

  PARAMETERS: p_num1 TYPE i DEFAULT 0. " First number
  PARAMETERS: p_num2 TYPE i DEFAULT 0. " Second number

  " Add radio buttons for operations
  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS: r_add TYPE c RADIOBUTTON GROUP grp1 DEFAULT 'X'.
    SELECTION-SCREEN COMMENT (10) text-002 FOR FIELD r_add. " Add

    PARAMETERS: r_sub TYPE c RADIOBUTTON GROUP grp1.
    SELECTION-SCREEN COMMENT (15) text-003 FOR FIELD r_sub. " Subtract

    PARAMETERS: r_mul TYPE c RADIOBUTTON GROUP grp1.
    SELECTION-SCREEN COMMENT (15) text-004 FOR FIELD r_mul. " Multiply

    PARAMETERS: r_div TYPE c RADIOBUTTON GROUP grp1.
    SELECTION-SCREEN COMMENT (15) text-005 FOR FIELD r_div. " Divide
  SELECTION-SCREEN END OF LINE.

  " Display result dynamically
  SELECTION-SCREEN: COMMENT 2(20) text-006, " Label for result
                    COMMENT 23(20) result_. " Result field as text

SELECTION-SCREEN END OF BLOCK b1.



* Logic to calculate on Enter
AT SELECTION-SCREEN.
  CLEAR: result, operation.

  " Perform calculation based on selected operation
  IF r_add = 'X'.
    operation = 'Add'.
    result = p_num1 + p_num2.
  ELSEIF r_sub = 'X'.
    operation = 'Subtract'.
    result = p_num1 - p_num2.
  ELSEIF r_mul = 'X'.
    operation = 'Multiply'.
    result = p_num1 * p_num2.
  ELSEIF r_div = 'X'.
    operation = 'Divide'.
    IF p_num2 NE 0.
      result = p_num1 / p_num2.
    ELSE.
      result = 'Error: Division by 0'.
    ENDIF.
  ENDIF.

  " Display result as a string
  result_ = result.