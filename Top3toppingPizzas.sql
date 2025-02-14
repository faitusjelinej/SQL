/* Given a list of pizza toppings, consider all the possible 3-topping pizzas.
   Print out the total cost of top 3 topping Pizzas.
   Sort the results with the highest total cost on the top followed by pizza toppings in ascending order. 
 
 Note:
 Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Mushrooms’.
 Ingredients must be listed in alphabetical order.
 */

create table pizza_toppings (topping_name varchar(100),ingredient_cost decimal(10,2));

insert into pizza_toppings values('Pepperoni',0.50);
insert into pizza_toppings values('Sausage',0.70);
insert into pizza_toppings values('Chicken',0.55);
insert into pizza_toppings values('Extra Cheese',0.40);
insert into pizza_toppings values('Mushrooms',0.25);
insert into pizza_toppings values('Green Peppers',0.20);

select concat(t1.topping_name,',' ,t2.topping_name, ',',t3.topping_name) Pizza,
t1.ingredient_cost + t2.ingredient_cost + t3.ingredient_cost as cost
from pizza_toppings t1
join  pizza_toppings t2
on t1.topping_name < t2.topping_name
join  pizza_toppings t3
on t2.topping_name < t3.topping_name
order by cost desc,Pizza
;
