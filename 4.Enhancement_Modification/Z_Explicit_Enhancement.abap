REPORT ZMKS_EXPLICIT_ENHANCEMENT.

DATA : lv_output(3) type n.

parameters : p_input1(2) type n.
parameters : p_input2(2) type n.

ENHANCEMENT-POINT ZMKSEP_50 SPOTS ZMKSES_50 .
*$*$-Start: ZMKSEP_50---------------------------------------------------------------------------$*$*
ENHANCEMENT 1  ZMKS_MULTI.    "active version

  lv_output = p_input1 * p_input2.

Write: / ' The multiplicaiton of two numbers is:', lv_output.



ENDENHANCEMENT.
*$*$-End:   ZMKSEP_50---------------------------------------------------------------------------$*$*

ENHANCEMENT-SECTION ZMKSST_50 SPOTS ZMKSES_50 .
lv_output = p_input1 / p_input2.

Write: / ' The Division of two numbers is:', lv_output.
END-ENHANCEMENT-SECTION.
*$*$-Start: ZMKSST_50---------------------------------------------------------------------------$*$*
ENHANCEMENT 1  ZMKS_ERROR_HANDLING.    "active version
if p_input2 = 0.
  Write : / 'The second input cannot be zero'.
lv_output = p_input1 / p_input2.

Write: / ' The Division of two numbers is:', lv_output.
ENDENHANCEMENT.
ENHANCEMENT 2  ZMKS_MULTI.    "active version
lv_output = p_input1 / p_input2.

Write: / ' The Division of two numbers is:', lv_output.
ENDENHANCEMENT.
*$*$-End:   ZMKSST_50---------------------------------------------------------------------------$*$*

lv_output = p_input1 + p_input2.

Write: / ' The sum of two numbers is:', lv_output.