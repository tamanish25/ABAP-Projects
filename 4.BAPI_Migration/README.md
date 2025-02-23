# 🚀 BAPI for Material Master Upload Program - ABAP

This repository contains two ABAP programs for **bulk uploading and updating Material Master (MM) data** in SAP using **BAPI_MATERIAL_SAVEDATA**.

## 📂 **Programs Overview**
1. **Standard BAPI-Based Upload (`Z_Bapi_upload`)**
   - Uses **BAPI_MATERIAL_SAVEDATA** to create/update Material Master data.
   - Reads data from a text file and updates SAP.
   - Standard fields: Material Number, Industry Sector, Material Type, Description, Base Unit of Measure.

2. **Custom BAPI Implementation (`Z_Custom_Bapi`)**
   - Implements a **custom BAPI **.
   - Adds **two custom fields**:
     - `ZZSYSTEM`: Stores information about **legacy systems**.
     - `ZZMTYPE`: Specifies whether the material is **obsolete or valid**.
   - Enhances `BAPI_MATERIAL_SAVEDATA` by integrating custom fields in **EXTENSIONIN**.

---

## 📌 **Program 1: Standard BAPI Material Upload**
### 🔹 **How It Works**
1. Reads **Material Master data** from an external file.
2. Calls **BAPI_MATERIAL_SAVEDATA** to update the data in SAP.
3. If successful, the material is **committed to the database**; otherwise, an error message is shown.

### 🔹 **File Format (CSV)**
| MATNR  | MBRSH | MTART | MAKTX         | MEINS |
|--------|------|------|--------------|------|
| 1000001 | M    | FERT  | Finished Product | PC   |
| 1000002 | I    | HALB  | Semi-Finished  | KG   |

### 🔹 **Code Highlights**
- Uses `GUI_UPLOAD` to read files.
- Maps **Material Master** fields dynamically.
- Uses `BAPI_MATERIAL_SAVEDATA` for transaction integrity.

---

## 📌 **Program 2: Custom BAPI for Material Upload**
### 🔹 **Custom BAPI: `Z_Custom_bapi`**
This program implements a **custom BAPI ** to handle:
1. **Legacy system information (`ZZSYSTEM`)**.
2. **Material status (Obsolete/Valid) (`ZZMTYPE`)**.

### 🔹 **Enhancements**
- Uses **BAPI_TE_MARA & BAPI_TE_MARAX** to store **custom fields** in `EXTENSIONIN`.
- Converts **custom fields to character format** before passing them to `BAPI_MATERIAL_SAVEDATA`.
- Ensures **error handling** .

### 🔹 **File Format (CSV)**
| MATNR  | MBRSH | MTART | MAKTX         | MEINS | ZZSYSTEM | ZZMTYPE  |
|--------|------|------|--------------|------|---------|---------|
| 1000001 | M    | FERT  | Finished Product | PC   | LEG1 | VALID    |
| 1000002 | I    | HALB  | Semi-Finished  | KG   | LEG2 | OBSOLETE |

### 🔹 **Steps to Use**
1. Upload the tab separated **text file** with custom fields.
2. The program maps the data and updates SAP.
3. `ZZSYSTEM` and `ZZMTYPE` are stored via **BAPI_TE_MARA**.
4. Transaction commits only on success.

### 🔹 **Enhancements**
- Uses **BAPI_TE_MARA & BAPI_TE_MARAX** to store **custom fields** in `EXTENSIONIN`.
- Converts **custom fields to character format** before passing them to `BAPI_MATERIAL_SAVEDATA`.
- Ensures **error handling** and **rollback for failed updates**.

## 🔧 **Custom BAPI Setup**
### 🔹 **1️⃣ Changes in MARA Table**
The following fields were added to the **MARA table**:
```abap
ZZSYSTEM TYPE CHAR20, " Legacy System Information
ZZMTYPE  TYPE CHAR10, " Material Status (Valid/Obsolete)


---

## 🛠 **Installation & Execution**
1. **Download the ABAP programs** and upload them to your SAP system.
2. Execute the program using `SE38` or `SA38`.
3. Select the appropriate text file.
4. Click **Execute (F8)**.
5. Check **ALV output or error logs** for results.

---



## 📜 **License**
This project is open-source and available under the **MIT License**.