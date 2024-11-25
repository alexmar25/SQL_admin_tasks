CREATE DATABASE retail_db;

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id VARCHAR(50) REFERENCES products(product_id),
    store_id VARCHAR(50) REFERENCES stores(store_id),
    date DATE,
    sales INT,
    revenue NUMERIC,
    stock INT,
    price NUMERIC,
    promo_type_1 VARCHAR(50),
    promo_bin_1 VARCHAR(50),
    promo_type_2 VARCHAR(50)
);

