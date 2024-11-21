# ABAP Program: Fetch and Display Combined Order Data

## Overview

This ABAP program is designed to fetch data from two SAP database tables: an **Order Header table** (`zordh_50`) and an **Order Item table** (`zordi_50`). The program combines data from both tables based on selected order numbers and displays the output in a classical report format. 

### Key Features:
- Fetches order header details for user-selected order numbers.
- Retrieves corresponding order item details for the selected order headers using `FOR ALL ENTRIES`.
- Combines data into a single output table containing:
  - All columns from the Order Header table.
  - Selected columns (`item_no` and `qty`) from the Order Item table.
- Displays the combined data in a user-friendly format.

---

## Table Structures

### Order Header Table (`zordh_50`)
| Field Name | Data Type   | Description          |
|------------|-------------|----------------------|
| `ono`      | `zdeono_50` | Order Number         |
| `odate`    | `zdate_50`  | Order Date           |
| `ta`       | `zdeta_50`  | Transaction Amount   |
| `curr`     | `zdecur_50` | Currency             |

### Order Item Table (`zordi_50`)
| Field Name | Data Type   | Description      |
|------------|-------------|------------------|
| `ono`      | `zdeono_50` | Order Number     |
| `item_no`  | `zitemno_50`| Item Number      |
| `qty`      | `zqty_50`   | Quantity         |

---

## How It Works

1. **User Input**:
   - The program accepts a mandatory range of order numbers (`s_ono`) using `SELECT-OPTIONS`.
   - The user must provide at least one valid order number.

2. **Data Retrieval**:
   - The program fetches matching records from the **Order Header table** based on the user input.
   - Using `FOR ALL ENTRIES`, it retrieves related data from the **Order Item table** for the fetched headers.

3. **Data Combination**:
   - Combines the header and item data into a single output internal table (`lt_output`).
   - Includes all fields from the header table and selected fields (`item_no`, `qty`) from the item table.

4. **Output Display**:
   - Displays the combined data in a classical report format, with clear headers and tabular alignment.

---

## ABAP Code

You can find the full ABAP program in this repository under the file `zfetch_combined_data.abap`.

---

## Installation and Usage

1. **Prerequisites**:
   - SAP system with access to the database tables `zordh_50` and `zordi_50`.
   - Proper table and field definitions as mentioned above.

2. **Setup**:
   - Upload the program code to the SAP system using SE38 (ABAP Editor) or a transport request.
   - Ensure that the database tables are populated with test or real data.

3. **Execution**:
   - Run the program in the ABAP Editor (SE38) or through a transaction code.
   - Provide a valid range of order numbers as input.
   - View the combined data output in the classical report format.

---
## Acknowledgements

Special thanks to the SAP community for their invaluable resources and guidance.


