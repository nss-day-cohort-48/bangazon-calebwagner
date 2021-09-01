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