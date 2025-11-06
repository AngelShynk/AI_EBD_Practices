-- Semi-structured demo: e-commerce orders (BigQuery Standard SQL)

-- BigQuery (GoogleSQL)

CREATE OR REPLACE TABLE `demo.orders_raw` (
  order_id INT64,
  order_data JSON
);

INSERT INTO `demo.orders_raw` (order_id, order_data) VALUES
(1, JSON '''{
  "customer": {"id": 301, "name": "Anna"},
  "payment": {"method": "card", "currency": "UAH"},
  "shipping": {"city": "Kyiv", "country": "UA"},
  "items": [
    {"product_id": 1001, "category": "electronics", "quantity": 1, "price": 299.99},
    {"product_id": 1002, "category": "accessories", "quantity": 2, "price": 19.99}
  ],
  "totals": {"amount": 339.97, "discount": 0.00},
  "channel": "web",
  "timestamp": "2025-11-01T09:10:00Z"
}'''),
(2, JSON '''{
  "customer": {"id": 302, "name": "Ben"},
  "payment": {"method": "paypal", "currency": "UAH"},
  "shipping": {"city": "Lviv", "country": "UA"},
  "items": [
    {"product_id": 2001, "category": "apparel", "quantity": 2, "price": 49.50},
    {"product_id": 2002, "category": "apparel", "quantity": 1, "price": 15.00}
  ],
  "totals": {"amount": 114.00, "discount": 0.00},
  "channel": "mobile",
  "timestamp": "2025-11-01T11:20:00Z"
}'''),
(3, JSON '''{
  "customer": {"id": 303, "name": "Cara"},
  "payment": {"method": "apple_pay", "currency": "UAH"},
  "shipping": {"city": "Kharkiv", "country": "UA"},
  "items": [
    {"product_id": 3001, "category": "home", "quantity": 1, "price": 129.00},
    {"product_id": 3002, "category": "home", "quantity": 3, "price": 25.00}
  ],
  "totals": {"amount": 183.60, "discount": 20.40},
  "channel": "web",
  "timestamp": "2025-11-01T18:55:00Z"
}'''),
(4, JSON '''{
  "customer": {"id": 304, "name": "Diego"},
  "payment": {"method": "card", "currency": "UAH"},
  "shipping": {"city": "Odesa", "country": "UA"},
  "items": [
    {"product_id": 4001, "category": "electronics", "quantity": 1, "price": 899.00}
  ],
  "totals": {"amount": 899.00, "discount": 0.00},
  "channel": "web",
  "timestamp": "2025-11-02T08:00:00Z"
}'''),
(5, JSON '''{
  "customer": {"id": 305, "name": "Elena"},
  "payment": {"method": "crypto", "currency": "UAH"},
  "shipping": {"city": "Dnipro", "country": "UA"},
  "items": [
    {"product_id": 5001, "category": "books", "quantity": 3, "price": 12.00},
    {"product_id": 5002, "category": "toys", "quantity": 1, "price": 25.00}
  ],
  "totals": {"amount": 61.00, "discount": 0.00},
  "channel": "mobile",
  "timestamp": "2025-11-02T16:45:00Z"
}'''),
(6, JSON '''{
  "customer": {"id": 306, "name": "Farid"},
  "payment": {"method": "paypal", "currency": "UAH"},
  "shipping": {"city": "Kyiv", "country": "UA"},
  "items": [
    {"product_id": 6001, "category": "sports", "quantity": 1, "price": 59.99},
    {"product_id": 6002, "category": "sports", "quantity": 2, "price": 29.99}
  ],
  "totals": {"amount": 119.97, "discount": 0.00},
  "channel": "web",
  "timestamp": "2025-11-03T09:30:00Z"
}'''),
(7, JSON '''{
  "customer": {"id": 307, "name": "Grace"},
  "payment": {"method": "card", "currency": "UAH"},
  "shipping": {"city": "Lviv", "country": "UA"},
  "items": [
    {"product_id": 7001, "category": "beauty", "quantity": 2, "price": 19.99},
    {"product_id": 7002, "category": "beauty", "quantity": 1, "price": 9.99}
  ],
  "totals": {"amount": 44.97, "discount": 5.00},
  "channel": "mobile",
  "timestamp": "2025-11-03T19:05:00Z"
}'''),
(8, JSON '''{
  "customer": {"id": 308, "name": "Hugo"},
  "payment": {"method": "apple_pay", "currency": "UAH"},
  "shipping": {"city": "Zaporizhzhia", "country": "UA"},
  "items": [
    {"product_id": 8001, "category": "apparel", "quantity": 1, "price": 69.00},
    {"product_id": 8002, "category": "accessories", "quantity": 3, "price": 9.50}
  ],
  "totals": {"amount": 97.50, "discount": 0.00},
  "channel": "web",
  "timestamp": "2025-11-04T12:15:00Z"
}'''),
(9, JSON '''{
  "customer": {"id": 309, "name": "Ines"},
  "payment": {"method": "card", "currency": "UAH"},
  "shipping": {"city": "Kyiv", "country": "UA"},
  "items": [
    {"product_id": 9001, "category": "home", "quantity": 1, "price": 199.00},
    {"product_id": 9002, "category": "electronics", "quantity": 1, "price": 49.00}
  ],
  "totals": {"amount": 248.00, "discount": 0.00},
  "channel": "web",
  "timestamp": "2025-11-05T18:10:30Z"
}'''),
(10, JSON '''{
  "customer": {"id": 310, "name": "Josh"},
  "payment": {"method": "paypal", "currency": "UAH"},
  "shipping": {"city": "Chernihiv", "country": "UA"},
  "items": [
    {"product_id": 10001, "category": "books", "quantity": 2, "price": 25.00},
    {"product_id": 10002, "category": "toys", "quantity": 2, "price": 19.00}
  ],
  "totals": {"amount": 88.00, "discount": 0.00},
  "channel": "mobile",
  "timestamp": "2025-11-06T07:05:00Z"
}''');


SELECT * FROM demo.orders_raw;

-- Task 1 (0.5)
-- Requirement (per payment method):
-- - Total revenue (sum of totals.amount)
-- - Count of unique customers (customer.id)
-- - Latest order timestamp

-- Task 2 (0.5)
-- Goal: item-level insight.
-- Write a query that returns, for each item.category and payment method:
-- - Total quantity of items
-- - Number of unique customers who purchased
-- - Most recent order timestamp for such purchases
