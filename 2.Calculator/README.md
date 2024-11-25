# Z_CALCULATOR Program

This repository contains the SAP ABAP program `z_Calculator`, a simple calculator application designed to perform basic arithmetic operations. The program uses the selection screen feature in SAP to allow users to input numbers and choose an operation to perform on those numbers.

---

## Features

- **Arithmetic Operations**: Supports addition, subtraction, multiplication, and division.
- **Interactive Selection Screen**: 
  - Allows users to input two numbers.
  - Includes radio button options to select the desired operation.
- **Dynamic Result Display**: Displays the result or an error message (e.g., for division by zero) on the selection screen.

---

## Code Details

### **Input Parameters**
- `p_num1`: First number (integer, default is 0).
- `p_num2`: Second number (integer, default is 0).

### **Operation Selection**
- Radio button group for selecting one of the following operations:
  - **Add** (`r_add`)
  - **Subtract** (`r_sub`)
  - **Multiply** (`r_mul`)
  - **Divide** (`r_div`)

### **Result Display**
- The result of the operation is displayed dynamically on the selection screen.
- If division by zero is attempted, an error message is displayed.

---

## Program Logic

1. **Selection Screen Input**: Users provide two numbers and select an operation via radio buttons.
2. **Validation and Calculation**:
   - Based on the selected operation, the program performs the appropriate calculation.
   - Division by zero is handled gracefully by showing an error message.
3. **Output Result**: The calculated result is displayed on the selection screen.

---

## Usage Instructions

1. Import the `z_calculator` program into your SAP system.
2. Execute the program to access the selection screen.
3. Provide the required inputs:
   - Enter two numbers in the respective fields.
   - Select an operation using the radio buttons.
4. Press **Enter** to calculate the result.
5. View the result or error message displayed on the screen.

---

## Example Scenario

- **Input**:  
  `p_num1 = 10`, `p_num2 = 2`, select **Multiply** (`r_mul`).
- **Output**:  
  Result = `20`.

- **Input**:  
  `p_num1 = 5`, `p_num2 = 0`, select **Divide** (`r_div`).
- **Output**:  
  Result = `Error: Division by 0`.

---


