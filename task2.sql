
Question 2
Max Score: 5 | Difficulty: medium
Use a CTE to calculate the total sales made by each employee.

with TotalSalesByEmployee as
(
  select e.firstname,
         e.lastname,
         sum(quantityordered*priceeach)as totalsales 
  from employees e 
  inner join customers c on c.salesrepemployeenumber=e.employeenumber 
  inner join orders o on o.customernumber=c.customernumber 
  inner join orderdetails od on od.ordernumber=o.ordernumber 
  group by e.firstname,
           e.lastname 
  order by totalsales desc
)

select*from TotalSalesByEmployee;