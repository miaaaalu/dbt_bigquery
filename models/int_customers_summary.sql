 
select 
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date']) }} as generate_surrogate_key,
    customer_id,
    order_date,
    count(*) as cnt 
from {{ ref('stg_jaffle_shop_orders') }}
group by 1, 2, 3