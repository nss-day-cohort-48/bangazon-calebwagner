-- SELECT
--     f.id,
--     f.customer_id,
--     f.seller_id,
--     c.phone_number,
--     c.address,
--     u.id user_id,
--     u.username,
--     u.first_name || ' ' || u.last_name AS full_name,
--     u.email
-- FROM
--     bangazonapi_favorite f
-- JOIN
--     bangazonapi_customer c ON c.id = f.customer_id
-- JOIN
--     auth_user u ON c.user_id = u.id

-- SELECT
--     o.id,
--     o.payment_type_id,
--     o.customer_id,
--     u.id user_id,
--     u.username,
--     u.first_name || ' ' || u.last_name AS full_name
-- FROM bangazonapi_order o
-- JOIN bangazonapi_customer c ON c.id = o.customer_id
-- JOIN auth_user u ON c.user_id = u.id


-- SELECT
--     o.id order_id,
--     SUM(p.price) AS total_price,
--     p.
--     u.id user_id,
--     u.username,
--     u.first_name || ' ' || u.last_name AS full_name
-- FROM bangazonapi_order o
-- JOIN bangazonapi_product p ON c.id = o.customer_id
-- JOIN auth_user u ON c.user_id = u.id

-- SELECT
-- o.id,
-- u.first_name || ' ' || u.last_name AS full_name,
-- sum(p.price) AS order_total,
-- count(op.id) AS num_items
-- FROM
--     bangazonapi_order AS o
-- JOIN
--     bangazonapi_customer AS c ON c.id = o.customer_id
-- JOIN
--     auth_user AS u ON u.id = c.user_id
-- JOIN LEFT
--     bangazonapi_orderproduct AS op ON op.order_id = o.id
-- JOIN
--     LEFT bangazonapi_product AS p ON op.product_id = p.id
--     WHERE o.payment_type_id NOTNULL
--     GROUP BY o.id

-- SELECT
--     o.id,
--     u.first_name || ' ' || u.last_name AS full_name,
--     sum(p.price) AS order_total,
--     count(op.id) AS num_items
-- FROM bangazonapi_order AS o
-- JOIN bangazonapi_customer AS c ON c.id = o.customer_id
-- JOIN auth_user AS u ON u.id = c.user_id
-- LEFT JOIN bangazonapi_orderproduct AS op ON op.order_id = o.id
-- LEFT JOIN bangazonapi_product AS p ON op.product_id = p.id
-- WHERE o.payment_type_id NOTNULL
-- GROUP BY o.id


-- SELECT
--     o.id,
--     u.first_name || ' ' || u.last_name AS customer_name,
--     sum(p.price) AS order_total
-- FROM bangazonapi_order AS o
-- JOIN bangazonapi_orderproduct AS op ON op.order_id = o.id
-- JOIN bangazonapi_product AS p ON op.product_id = p.id
-- JOIN auth_user AS u ON u.id = o.customer_id
-- WHERE o.payment_type_id IS NOT NULL
-- GROUP BY o.id

                -- SELECT
                -- bangazonapi_order.id AS order_id,
                -- SUM(bangazonapi_product.price) AS total_price,
                -- auth_user.first_name || " " || auth_user.last_name AS customer_name
                -- FROM bangazonapi_Order

                -- JOIN bangazonapi_OrderProduct

                -- ON bangazonapi_OrderProduct.order_id = bangazonapi_order.id


                -- JOIN bangazonapi_Product
                -- ON bangazonapi_Product.id = bangazonapi_OrderProduct.product_id

                -- JOIN auth_user
                -- ON auth_user.id = bangazonapi_Order.customer_id
                -- WHERE bangazonapi_order.payment_type_id IS NULL
                -- GROUP BY bangazonapi_order.id


SELECT
-- I want to secect the orderId, total balance of order, and users name
    bangazonapi_order.id AS order_id,
    SUM(bangazonapi_product.price) AS order_total,
    auth_user.first_name || " " || auth_user.last_name AS customer_name
-- from the orders table, I want you to ...
FROM bangazonapi_order
-- join the order and order_product tables
JOIN bangazonapi_orderproduct
-- "ON" shows the connection between tables so ...
-- connect the order_product table with the property order_id ...
-- to the id of the orders table
    ON bangazonapi_orderproduct.order_id = bangazonapi_order.id
-- now join the product table to order_product column
JOIN bangazonapi_product
-- ... by the connection
    ON bangazonapi_product.id = bangazonapi_orderproduct.product_id
JOIN auth_user
    ON auth_user.id = bangazonapi_order.customer_id
WHERE bangazonapi_order.payment_type_id IS NULL
GROUP BY bangazonapi_order.id