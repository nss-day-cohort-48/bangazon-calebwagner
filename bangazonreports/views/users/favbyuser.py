import sqlite3
from django.shortcuts import render
from bangazonapi.models import Favorite
from bangazonreports.views import Connection

def user_favorite_list(request):
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
                    f.id,
                    f.customer_id,
                    f.seller_id,
                    c.phone_number,
                    c.address,
                    u.id user_id,
                    u.username,
                    u.first_name || ' ' || u.last_name AS full_name,
                    u.email
                FROM
                    bangazonapi_favorite f
                JOIN
                    bangazonapi_customer c ON c.id = f.customer_id
                JOIN
                    auth_user u ON c.user_id = u.id
            """)

            database = db_cursor.fetchall()

            favorites_by_user = {}

            for row in database:
                favorite = Favorite()
                favorite.customer_id = row["customer_id"]
                favorite.seller_id = row["seller_id"]

                uid = row["user_id"]

                if uid in favorites_by_user:
                    favorites_by_user[uid]['favorites'].append(favorite)

                else:
                    favorites_by_user[uid] = {}
                    favorites_by_user[uid]["id"] = uid
                    favorites_by_user[uid]["full_name"] = row["full_name"]
                    favorites_by_user[uid]["favorites"] = [favorite]

    list_of_users_with_favorites = favorites_by_user.values()

    template = 'users/favorited_sellers_by_customer.html'
    context = {'user_favorite_list': list_of_users_with_favorites}

    return render(request, template, context)
