-- Mart: customer dimension enriched with lifetime order metrics from the
-- intermediate layer. This is the table analysts join fct_orders against.

with customer_history as (

    select * from {{ ref('int_customer_order_history') }}

)

select
    customer_id,
    first_order_date,
    most_recent_order_date,
    lifetime_order_count,
    lifetime_revenue,
    avg_order_value,
    case
        when lifetime_order_count >= 3 then 'repeat_customer'
        else 'first_time_customer'
    end as customer_segment
from customer_history
