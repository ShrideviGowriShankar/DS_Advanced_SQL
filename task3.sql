Question 3
Max Score: 5 | Difficulty: medium
Identify customers whose total payments exceed $10,000. Return customerName, creditLimit, and total payment amount.

select c.customername,
       c.creditlimit,
       sum(p.amount)as totalpayments
  from customers c 
  inner join payments p on c.customernumber=p.customernumber
  group by c.customername,
           c.creditlimit
    having totalpayments>10000;