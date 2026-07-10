-- Staging model: one-to-one with the raw_orders seed. Renames/casts columns
-- and applies light filtering only - no joins, no business logic here.

with source as (

    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        order_date,
        region,
        product_category,
        quantity,
        unit_price,
        total_amount
    from source
    where order_id is not null
      and total_amount > 0

)

select * from renamed
