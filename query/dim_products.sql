SELECT 
* 
FROM dbo.products

-- query to categorize products based on their price
SELECT
	ProductID, -- unique identifier
	ProductName, -- name of each products
	Price, --price of each products

	CASE --categorizes the products into price categories
		WHEN Price < 50 THEN 'low'
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory

FROM
dbo.products;