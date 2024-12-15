Create a view that tracks total sales per product (using quantityOrdered * priceEach) for each month. The view should also rank products by sales volume each month.

drop view if exists vw_Total_Sales_By_Product;

 create view vw_Total_Sales_By_Product as
 with totalsalesvalue as
    ( 
     select od.productcode,
            date_format(o.orderdate, "%Y-%m")as month,
            sum(quantityordered*priceeach) as totalsales
      from orderdetails od 
      inner join orders o on o.ordernumber=od.ordernumber
       group by od.productcode,
                date_format(o.orderdate, "%Y-%m")
    )
 
select p.productCode,
       p.productName,
       tsv.month,
       sum(tsv.totalsales)as totalsalevalue,
       rank() over(partition by tsv.month order by tsv.month asc, sum(tsv.totalsales) desc)as salesRank
    from products p
    inner join totalsalesvalue tsv on p.productcode=tsv.productcode
    group by  p.productCode,
              p.productName,
              tsv.month;
 
 select distinct(productCode),
        productName,
        month,
        totalsalevalue as totalSales,
        salesRank
  from vw_Total_Sales_By_Product;
  
  
  
  /*create view vw_Total_Sales_By_Product as
 
     select p.productcode,
             p.productName,
            date_format(o.orderdate, "%Y-%m")as month,
            sum(quantityordered*priceeach) as totalsales,
            rank() over(partition by date_format(o.orderdate, "%Y-%m") order by sum(quantityordered*priceeach) desc)as salesRank
      from orderdetails od 
      inner join orders o on o.ordernumber=od.ordernumber
      inner join  products p on p.productcode=od.productCode
           group by  p.productCode,
              p.productName,
			  date_format(o.orderdate, "%Y-%m");
	
     
 select distinct(productCode),
        productName,
        month,
        totalSales,
        salesRank
  from vw_Total_Sales_By_Product;*/
    