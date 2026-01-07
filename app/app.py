from flask import Flask, render_template, request, redirect, session, make_response
import db  
app = Flask(__name__)
app.secret_key = "super_secret_key_123"  

import csv
from io import StringIO

@app.route('/admin/test_connection')
def test_connection():
    success = db.test_db_connection()
    return render_template('admin.html', db_status=success)

@app.route('/')
def dashboard():
    if not session.get('logged_in'):
        return redirect('/login')
    kpis = db.get_kpis()
    return render_template('dashboard.html', kpis=kpis)


@app.route('/admin')
def admin():
    if not session.get('logged_in'):
        return redirect('/login')
    return render_template('admin.html')

@app.route('/customers')
def customers():
    all_customers = db.get_customers()
    return render_template('customers.html', customers=all_customers)

@app.route('/orders')
def orders():
    all_orders = db.get_orders()
    return render_template('orders.html', orders=all_orders)

@app.route('/payments')
def payments():
    all_payments = db.get_payments()
    return render_template('payments.html', payments=all_payments)

@app.route('/shipping')
def shipping():
    all_shipments = db.get_shipments()
    return render_template('shipping.html', shipping=all_shipments)

@app.route('/customers/add', methods=['POST'])
def add_customer():
    first_name = request.form['first_name']
    last_name = request.form['last_name']
    email = request.form['email']
    phone_number = request.form['phone'] 
    db.add_customer(first_name, last_name, email, phone_number)
    return redirect('/customers')


@app.route('/delete_customer/<int:id>')
def delete_customer(id):
    db.delete_customer(id)
    return redirect('/customers')

@app.route('/edit_customer/<int:id>', methods=['GET', 'POST'])
def edit_customer(id):
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        db.update_customer(id, first_name, last_name, email, phone_number)
        return redirect('/customers')
    else:
        customer = db.get_customer_by_id(id)
        return render_template('edit_customer.html', customer=customer)

@app.route('/admin/run_revenue')
def run_revenue():
    revenue = db.run_total_revenue_proc()
    return render_template('admin.html', revenue=revenue)

@app.route('/admin/high_value_customers')
def high_value_customers():
    customers = db.run_high_value_customers_proc()
    return render_template('admin.html', high_value_customers=customers)

@app.route('/admin/decrypted_customers')
def decrypted_customers():
    customers = db.get_decrypted_customers()
    return render_template('admin.html', decrypted_customers=customers)

@app.route('/add_order', methods=['POST'])
def add_order():
    db.add_order(request.form['customer_id'], request.form['total_amount'], request.form['order_date'])
    return redirect('/orders')

@app.route('/delete_order/<int:id>')
def delete_order(id):
    db.delete_order(id)
    return redirect('/orders')

@app.route('/edit_order/<int:id>', methods=['GET', 'POST'])
def edit_order(id):
    if request.method == 'POST':
        db.update_order(
            id,
            request.form['customer_id'],
            request.form['total_amount'],
            request.form['order_date']
        )
        return redirect('/orders')
    else:
        order = db.get_order_by_id(id)
        return render_template('edit_order.html', order=order)

@app.route('/export/customers')
def export_customers():
    data = db.get_all_customers_raw()

    columns = [desc[0] for desc in cursor.description]

    # Use StringIO for in-memory CSV
    si = StringIO()
    writer = csv.writer(si)
    writer.writerow(columns)
    writer.writerows(data)

    output = make_response(si.getvalue())
    output.headers["Content-Disposition"] = "attachment; filename=customers.csv"
    output.headers["Content-type"] = "text/csv"
    return output

@app.route('/powerbi')
def powerbi():
    return render_template('powerbi.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['username'] == 'admin' and request.form['password'] == 'admin123':
            session['logged_in'] = True
            return redirect('/admin')
        else:
            return "Invalid credentials"
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
