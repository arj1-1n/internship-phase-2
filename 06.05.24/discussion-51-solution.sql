--Task 1.1: Wildcard Searches for Product Names
select productname from products where productname like 'Classic%Car';

--Task 1.2: Flexible Search for Customer Addresses
select customername, addressline1 from customers where addressline1 like '%Street%' or addressline1 like '%Avenue%';

--Task 2.1: Orders within a Price Range
select ordernumber, sum(quantityordered * priceeach) as totalamount from orderdetails group by ordernumber having sum(quantityordered * priceeach) between 1000 and 5000;

--Task 2.2: Payments within a Date Range
select * from payments where paymentdate between '2004-01-01' and '2004-12-31';

--Task 3.1: Orders Exceeding Average Sale Amount
select ordernumber, sum(quantityordered * priceeach) as totalamount from orderdetails group by ordernumber having sum(quantityordered * priceeach) > (select avg(sum(quantityordered * priceeach)) from orderdetails group by ordernumber);

--Task 3.2: Products with Maximum Order Quantity
select productname from products where quantityordered = (select max(quantityordered) from orderdetails);

--Task 4.1: High-Value Customers in Specific Regions
select customername, country, city, amount from (select customernumber, sum(amount) as amount from payments group by customernumber having sum(amount) > (select percentile_cont(0.9) within group (order by amount) as top10percent from payments)) as highvaluecustomers join customers using (customernumber) where country like 'USA%' or country like 'Canada%';

--Task 4.2: Seasonal Sales Analysis
select productcode, avg(quantityordered) as seasonalavgquantity, avg((quantityordered - annualavg.quantityordered) / annualavg.quantityordered) as seasonalvsannualavg from orderdetails join (select productcode, avg(quantityordered) as quantityordered from orderdetails group by productcode) as annualavg using (productcode) where orderdate between '2003-12-01' and '2004-02-29' group by productcode;