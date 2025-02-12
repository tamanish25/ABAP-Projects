# SAP BDC Material Master Upload (MM01)

## Overview
This ABAP program automates the **material master data migration** into the SAP MM **MARA** table using **BDC Call Transaction (MM01)**. The program reads material data from a **tab-separated file** and processes bulk material creation in SAP.

## Features
- Uses **BDC Call Transaction** to create materials in SAP.
- Reads input data from a **tab-separated file (.txt)**.
- Automates data entry in **MM01** transaction.
- Implements **error handling, logging, and validation**.
- Improves efficiency and reduces manual effort in material master creation.

## File Format
The input file must be **tab-separated** and follow the below format:

```txt
ZMKS_MAT11	B	FERT	Material1
ZMKS_MAT12	B	FERT	Material2
ZMKS_MAT13	B	FERT	Material3
ZMKS_MAT14	B	FERT	Material4
ZMKS_MAT15	B	FERT	Material5
```

### Field Descriptions
| Column   | Description                   |
|----------|-------------------------------|
| MATNR    | Material Number (e.g., ZMKS_MAT11) |
| MBRSH    | Industry Sector (e.g., B) |
| MTART    | Material Type (e.g., FERT - Finished Product) |
| MAKTX    | Material Description |

## How to Use
### 1. Upload the File in SAP
- Use the program selection screen to browse and upload the **.txt** file.
- Ensure that the file is correctly formatted with tab-separated values.

### 2. Execute the ABAP Program
- Run the program in SAP.
- The program will read the file and populate the **BDC session** for transaction **MM01**.
- The script will simulate user inputs across SAP screens.

### 3. Verify the Logs
- Messages related to material creation will be displayed in the **SAP output log**.
- Any errors will be logged for debugging and correction.

## ABAP Program Summary
The ABAP program performs the following operations:
1. **Reads the file** using `GUI_UPLOAD`.
2. **Processes each record** and formats it for BDC.
3. **Navigates through MM01 screens** using `BDC_DYNPRO`.
4. **Populates fields** using `BDC_FIELD`.
5. **Calls the MM01 transaction** to create the material.
6. **Displays success/error messages** in SAP.

## Prerequisites
- SAP system access with MM01 transaction authorization.
- ABAP development environment (SE38/SE80) to execute the program.

## License
This project is open-source and free to use for SAP automation projects.

---
📌 *Ensure that the uploaded file follows the correct format to prevent data migration errors.*