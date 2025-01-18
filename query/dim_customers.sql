SELECT
*
FROM dbo.customers

SELECT
* 
FROM dbo.geography

-- join dim_customers with dim_geography to enrich customers data with geographic information
SELECT
	c.CustomerID, -- unique identifier for each customer
	c.CustomerName, --selects the name of each customer
	c.Email, --email of each customer
	c.Gender, --gender of each customer
	c.Age, --age of each customer
	g.Country, --country from geography table
	g.City -- city from geography table
FROM
	dbo.customers as c
	LEFT JOIN
	dbo.geography g
ON
	c.GeographyID = g.GeographyID; --Joins the two tables to match customers with their geographic information