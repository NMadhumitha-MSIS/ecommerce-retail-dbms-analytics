import pyodbc

conn_str = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=MADHUMITHA;"
    "DATABASE=Retail;"
    "Trusted_Connection=yes;"
)

conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

def get_kpis():
    result = cursor.execute("SELECT COUNT(*) FROM dbo.Individual_Order").fetchval()
    revenue = cursor.execute("SELECT SUM(TotalAmount) FROM dbo.Individual_Order").fetchval()
    custs = cursor.execute("SELECT COUNT(DISTINCT CustomerID) FROM dbo.Individual_Order").fetchval()
    return {"orders": result, "revenue": revenue, "customers": custs}


def get_customers():
    try:
        cursor = conn.cursor()
        result = cursor.execute("SELECT CustomerID, FirstName, LastName, Email, PhoneNumber FROM dbo.Customer")
        return result.fetchall()
    except Exception as e:
        print(" DB Error in get_customers():", e)
        return []

def get_customer_by_id(customer_id):
    return cursor.execute("SELECT * FROM dbo.Customer WHERE CustomerID=?", (customer_id,)).fetchone()

def add_customer(first_name, last_name, email, phone_number):
    cursor.execute(
        "INSERT INTO dbo.Customer (FirstName, LastName, Email, PhoneNumber) VALUES (?, ?, ?, ?)",
        (first_name, last_name, email, phone_number)
    )
    conn.commit()

def delete_customer(customer_id):
    cursor = conn.cursor()

    # Step 1: Delete dependent payments
    cursor.execute("""
        DELETE FROM dbo.Payment
        WHERE OrderID IN (
            SELECT OrderID FROM dbo.Individual_Order WHERE CustomerID = ?
        )
    """, (customer_id,))

    # Step 2: Delete from shipping
    cursor.execute("""
        DELETE FROM dbo.Shipping
        WHERE AddressID IN (
            SELECT AddressID FROM dbo.Customer_Address WHERE CustomerID = ?
        )
    """, (customer_id,))

    # Step 3: Delete customer address
    cursor.execute("DELETE FROM dbo.Customer_Address WHERE CustomerID = ?", (customer_id,))

    # Step 4: Delete individual orders
    cursor.execute("DELETE FROM dbo.Individual_Order WHERE CustomerID = ?", (customer_id,))

    # Step 5: Finally, delete customer
    cursor.execute("DELETE FROM dbo.Customer WHERE CustomerID = ?", (customer_id,))

    conn.commit()

def update_customer(customer_id, first_name, last_name, email, phone_number):
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.Customer SET FirstName=?, LastName=?, Email=?, PhoneNumber=? WHERE CustomerID=?",
        (first_name, last_name, email, phone_number, customer_id)
    )
    conn.commit()

def get_orders():
    return cursor.execute("SELECT * FROM dbo.Individual_Order").fetchall()

def get_order_by_id(order_id):
    return cursor.execute("SELECT * FROM dbo.Individual_Order WHERE OrderID=?", (order_id,)).fetchone()

def add_order(customer_id, total_amount, order_date):
    cursor.execute("INSERT INTO dbo.Individual_Order (CustomerID, TotalAmount, OrderDate) VALUES (?, ?, ?)", (customer_id, total_amount, order_date))
    conn.commit()

def delete_order(order_id):
    cursor.execute("DELETE FROM dbo.Individual_Order WHERE OrderID=?", (order_id,))
    conn.commit()

def update_order(order_id, customer_id, total_amount, order_date):
    cursor.execute("UPDATE dbo.Individual_Order SET CustomerID=?, TotalAmount=?, OrderDate=? WHERE OrderID=?", (customer_id, total_amount, order_date, order_id))
    conn.commit()


def get_payments():
    cursor = conn.cursor()
    payments = []
    cursor.execute("SELECT PaymentID, OrderID, PaymentMethod, PaymentStatus, TotalAmount FROM dbo.Payment")
    for row in cursor.fetchall():
        payments.append({
            'PaymentID': row.PaymentID,
            'OrderID': row.OrderID,
            'PaymentMethod': row.PaymentMethod,
            'Status': row.PaymentStatus,
            'Amount': row.TotalAmount 
        })
    return payments

def get_shipments():
    return cursor.execute("""
        SELECT ShipmentID, OrderID, Status, Carrier, TrackingNumber, Address
        FROM dbo.Shipping
    """).fetchall()

def test_db_connection():
    try:
        result = cursor.execute("SELECT 1").fetchval()
        return result == 1
    except Exception:
        return False

def run_total_revenue_proc():
    result = cursor.execute("EXEC GetTotalRevenue").fetchone()
    return result[0] if result else 0

def run_high_value_customers_proc():
    return cursor.execute("EXEC GetHighValueCustomers").fetchall()

def get_decrypted_customers():
    return cursor.execute("""
        SELECT CustomerID, Name,
        CONVERT(varchar, DecryptByKey(EncryptedPhone)) AS DecryptedPhone
        FROM dbo.Customer
    """).fetchall()
