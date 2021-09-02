import sqlite3
from django.shortcuts import render
# from bangazonapi.models import Order
from bangazonreports.views import Connection

def incomplete_orders_list(request):
    """[summary]

    Args:
        request ([type]): [description]
    """
    if request.method == 'GET':
        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = sqlite3.Row
            db_cursor = conn.cursor()

            db_cursor.execute("""
            SELECT
            bangazonapi_order.id AS order_id,
            SUM(bangazonapi_product.price) AS order_total,
            auth_user.first_name || " " || auth_user.last_name AS customer_name
            FROM bangazonapi_order
            JOIN bangazonapi_orderproduct
            ON bangazonapi_orderproduct.order_id = bangazonapi_order.id
            JOIN bangazonapi_product
            ON bangazonapi_product.id = bangazonapi_orderproduct.product_id
            JOIN auth_user
            ON auth_user.id = bangazonapi_order.customer_id
            WHERE bangazonapi_order.payment_type_id IS NULL
            GROUP BY bangazonapi_order.id
            """)

            database = db_cursor.fetchall()

            incomplete_orders = {}

            for row in database:
                uid = row["order_id"]

                incomplete_orders[uid] = {}
                incomplete_orders[uid]["order_id"] = uid
                incomplete_orders[uid]["customer_name"] = row["customer_name"]
                incomplete_orders[uid]["order_total"] = row["order_total"]


    list_of_incomplete_orders = incomplete_orders.values()

    template = 'orders/incompleteorders.html'
    context = {'incomplete_orders_list': list_of_incomplete_orders}

    return render(request, template, context)
