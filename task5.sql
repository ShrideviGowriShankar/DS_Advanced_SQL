  
Question 5
Max Score: 5 | Difficulty: hard
Identify employees who have processed sales exceeding $100,000 in total sales. For each employee, show their total sales, rank them based on sales, and calculate their average order size (using quantityOrdered and priceEach).


with totlasalesvalue as 
(
 select ordernumber,quantityordered,priceeach,
        sum(quantityordered*priceeach)as sumofsales
  from orderdetails 
  group by ordernumber,quantityordered,priceeach
),

employee_with_more_total_Sales as
(
  select e.employeenumber,
         e.firstname,
         e.lastname,
         o.ordernumber
  from employees e 
  inner join customers c on e.employeenumber=c.salesrepemployeenumber
  inner join orders o on o.customernumber=c.customernumber
)

select distinct(ewmts.employeenumber),
       ewmts.firstname,
       ewmts.lastname,
       sum(tsv.sumofsales) as totalsales,
       avg(tsv.quantityordered*tsv.priceeach)as avgordersize,
       rank() over(order by sum(tsv.sumofsales) desc)as salesrank
 from totlasalesvalue tsv
 inner join employee_with_more_total_Sales  ewmts on tsv.ordernumber=ewmts.ordernumber
 group by ewmts.employeenumber,
       ewmts.firstname,
       ewmts.lastname
     having totalsales>100000;
     
     /*
     select distinct(e.employeenumber),
            e.firstname,
            e.lastname,
           sum(quantityordered*priceeach)as  totalsales,
           avg(quantityordered*priceeach)as avgordersize,
           rank() over(order by sum(quantityordered*priceeach) desc)as salesrank
  from employees e 
  inner join customers c on e.employeenumber=c.salesrepemployeenumber
  inner join orders o on o.customernumber=c.customernumber
  inner join orderdetails od on od.ordernumber=o.ordernumber
  group by e.employeenumber,
        e.firstname,
        e.lastname
  having totalsales>100000;
     */
 