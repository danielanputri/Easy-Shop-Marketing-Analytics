SELECT
* 
FROM dbo.customer_reviews

-- clean whitespace issues in the ReviewText column
SELECT
	ReviewID, --unique identifier for each review
	CustomerID, --unique identifier for each customer
	ProductID, -- unique identifier fr each product
	ReviewDate, -- date when the review was written
	Rating, --numerical rating
	-- Cleans up the reviewText by replacing double space with single space to ensure the text is more readable and standardize
	REPLACE(ReviewText,'  ',' ') AS ReviewText
FROM
	dbo.customer_reviews;