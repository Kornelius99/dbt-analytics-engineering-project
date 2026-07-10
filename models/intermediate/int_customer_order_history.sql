-- Intermediate model: reusable per-customer order history and lifetime
-- metrics. Kept separate from marts so multiple downstream models
-- (dim_customers, future churn/RFM models, etc.) can build on the same logic
-- without duplicating it.

with orders as (

    select * from {{ ref('stg_orders') }}

),

customer_history as (

    select
        customer_id,
        min(order_date)          as first_order_date,
        max(order_date)          as most_recent_order_date,
        count(order_id)          as lifetime_order_count,
        sum(total_amount)        as lifetime_revenue,
        avg(total_amount)        as avg_order_value
    from orders
    group by customer_id

)

select * from customer_history
