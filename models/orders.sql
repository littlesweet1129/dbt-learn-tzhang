with 
orders as (
    select * from {{ ref('stg_orders') }}
),
order_payment as (
    select order_id, sum(amount) as amount 
    from {{ ref('stg_payments') }}
    group by order_id
),
final as (
    select orders.order_id, orders.customer_id, order_payment.amount, order_date
    from orders
    left join order_payment on orders.order_id=order_payment.order_id
)

select * from final