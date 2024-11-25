<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
</head>
<body>
    <h1>SQL Project: Retail Database Administration</h1>



### **README: SQL Project - Retail Database Administration**

---

#### **Overview**
This project demonstrates essential tasks of a Database Administrator (DBA) using a retail dataset. It includes data import, normalization, query performance optimization, stored procedures, and database backup and recovery.

---

### **Directory Structure**
1. **`retail_db_backup.sql`**:
   - **Description**: A backup file of the retail database created using `pg_dump`.
   - **Purpose**: Ensures data integrity and recoverability in case of data loss.

2. **`Retailsales.csv`**:
   - **Description**: Original dataset containing retail sales data, including customer, product, and store information.
   - **Columns**:
     - `customer_id`, `product_id`, `store_id`, `date`, `sales`, `revenue`, `stock`, `price`, `promo_type_1`, `promo_bin_1`, `promo_type_2`.

3. **`queries_and_procedures.sql`**:
   - **Description**: A collection of SQL queries and stored procedures developed throughout the project.
   - **Contents**:
     - Table creation, data import, normalization, indexing, and reusable SQL procedures and functions.

---

### **Steps Covered**

#### **1. Database Setup**
- Imported the dataset using the `COPY` command:
  ```sql
  COPY retail_sales
  FROM '/path/to/Retailsales.csv'
  DELIMITER ',' CSV HEADER;
  ```

---

#### **2. Normalization**
- Created relational tables for customers, products, and stores:
  ```sql
  CREATE TABLE customers (customer_id INT PRIMARY KEY);
  CREATE TABLE products (product_id VARCHAR(50) PRIMARY KEY);
  CREATE TABLE stores (store_id VARCHAR(50) PRIMARY KEY);
  ```

---

#### **3. Query Optimization**
- Added indexes to improve query performance:
  ```sql
  CREATE INDEX idx_customer_id ON transactions(customer_id);
  CREATE INDEX idx_product_id ON transactions(product_id);
  CREATE INDEX idx_store_id ON transactions(store_id);
  ```

---

#### **4. Stored Procedures and Functions**

1. **Function: Total Stock by Product**
   - Calculates the total stock for a specific product:
     ```sql
     CREATE OR REPLACE FUNCTION total_stock_by_product(product_id_input VARCHAR)
     RETURNS INT AS $$
     BEGIN
         RETURN (
             SELECT SUM(stock)
             FROM transactions
             WHERE product_id = product_id_input
         );
     END;
     $$ LANGUAGE plpgsql;
     ```

2. **Procedure: Update Stock**
   - Deducts the quantity sold from the stock:
     ```sql
     CREATE OR REPLACE PROCEDURE update_stock(product_id_input VARCHAR, store_id_input VARCHAR, quantity_sold INT)
     LANGUAGE plpgsql
     AS $$
     BEGIN
         UPDATE transactions
         SET stock = stock - quantity_sold
         WHERE product_id = product_id_input AND store_id = store_id_input;
         RAISE NOTICE 'Stock updated for product % in store %. Quantity sold: %', product_id_input, store_id_input, quantity_sold;
     END;
     $$;
     ```

3. **Procedure: Reset Stock**
   - Resets stock levels for all products in a store:
     ```sql
     CREATE OR REPLACE PROCEDURE reset_stock(store_id_input VARCHAR, default_stock INT)
     LANGUAGE plpgsql
     AS $$
     BEGIN
         UPDATE transactions
         SET stock = default_stock
         WHERE store_id = store_id_input;
         RAISE NOTICE 'Stock reset to % for all products in store %', default_stock, store_id_input;
     END;
     $$;
     ```

---

#### **5. Backup and Recovery**
- Backed up the database:
  ```bash
  pg_dump -U postgres -d retail_db > retail_db_backup.sql
  ```

- Restored the database:
  ```bash
  psql -U postgres -d retail_db < retail_db_backup.sql
  ```

---

### **Usage**

1. **To Load the Backup**:
   ```bash
   psql -U postgres -d retail_db < retail_db_backup.sql
   ```

2. **To Execute Queries**:
   Open `queries_and_procedures.sql` in your SQL client and run the queries.

---

### **Learning Outcomes**
- Setting up a database and importing data.
- Normalizing tables and optimizing queries.
- Writing reusable functions and procedures.
- Performing database backups and recovery processes.

