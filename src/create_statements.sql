USE SalesDataWarehouse;
GO

DROP TABLE IF EXISTS DimInvoice;
CREATE TABLE DimInvoice (
    invoice_pk INT IDENTITY(1,1) PRIMARY KEY,
    invoice_id NVARCHAR(30),
    returned CHAR(1) CHECK (returned IN ('Y', 'N')),
    discount CHAR(1) CHECK (discount IN ('Y', 'N'))
);
CREATE NONCLUSTERED INDEX idx_invoice_id ON DimInvoice(invoice_id);
GO

DROP TABLE IF EXISTS DimCustomer;
CREATE TABLE DimCustomer (
    customer_pk INT IDENTITY(1,1) PRIMARY KEY,
    customer_id NVARCHAR(20),
    country NVARCHAR(50),
    continent NVARCHAR(50)
);
CREATE NONCLUSTERED INDEX idx_customer_id ON DimCustomer(customer_id);
GO

DROP TABLE IF EXISTS DimProduct;
CREATE TABLE DimProduct (
    product_pk INT IDENTITY(1,1) PRIMARY KEY,
    product_id NVARCHAR(50),
    description NVARCHAR(255),
    product_category NVARCHAR(100),
    seasonal CHAR(1) CHECK (seasonal IN ('Y', 'N'))
);
CREATE NONCLUSTERED INDEX idx_product_id ON DimProduct(product_id);
GO

DROP TABLE IF EXISTS DimDate;
CREATE TABLE DimDate (
    date_pk INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    year INT,
    month INT,
    day INT,
    weekday INT,
    quarter INT
);
CREATE NONCLUSTERED INDEX idx_date_id ON DimDate(date_id);
GO

DROP TABLE IF EXISTS DimTime;
CREATE TABLE DimTime (
    time_pk INT IDENTITY(1,1) PRIMARY KEY,
    time_id INT,
    hours INT,
    minutes INT,
    seconds INT,
    time_of_day NVARCHAR(20)
);
CREATE NONCLUSTERED INDEX idx_time_id ON DimTime(time_id);
GO

DROP TABLE IF EXISTS FactSales_Staging;
CREATE TABLE FactSales_Staging (
    invoice_id NVARCHAR(30),
    product_id NVARCHAR(50),
    customer_id NVARCHAR(20),
    date_id INT,
    time_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    total_amount DECIMAL(12, 2)
);
GO

DROP TABLE IF EXISTS FactSales;
CREATE TABLE FactSales (
    invoice_fk INT,
    product_fk INT,
    customer_fk INT,
    date_fk INT,
    time_fk INT,
    quantity INT,
    price DECIMAL(10, 2),
    total_amount DECIMAL(12, 2),
    FOREIGN KEY (invoice_fk) REFERENCES DimInvoice(invoice_pk),
    FOREIGN KEY (product_fk) REFERENCES DimProduct(product_pk),
    FOREIGN KEY (customer_fk) REFERENCES DimCustomer(customer_pk),
    FOREIGN KEY (date_fk) REFERENCES DimDate(date_pk),
    FOREIGN KEY (time_fk) REFERENCES DimTime(time_pk)
);
GO
