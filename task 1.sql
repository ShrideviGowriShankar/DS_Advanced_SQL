
Question 1
Max Score: 5 | Difficulty: medium
Categorize customers into three categories based on their creditLimit:

* "Low" if the credit limit is less than $5,000
*  "Medium" if the credit limit is between $5,000 and $20,000
*  "High" if the credit limit is greater than $20,000.

select customernumber,
       customername,
       creditlimit,
  case
    when creditlimit<5000 then "Low"
    when creditlimit between 5000 and 20000 then"Medium"
    else "High"
  end as creditcategory
from customers;