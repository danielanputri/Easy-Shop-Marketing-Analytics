SELECT
*
FROM dbo.engagement_data

-- query to clean and normalize the engagement_data table

SELECT
	EngagementID, --unique identifier for each record
	ContentID, --unique identifier for each piece of content
	CampaignID, --unique identifier for each marketing campaign
	ProductID, --unique identifier for eaxh product
	UPPER(REPLACE(ContentType,'Socialmedia','Social Media')) AS ContentType,
	LEFT(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined) - 1) AS Views, --Extracts the Views part from the ViewsClicksCombined
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, --extracts the clicks
	Likes, --number of likes the content received
	-- converts the engagmentDate to the dd.mm.yyyy format
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate 
FROM
	dbo.engagement_data
WHERE
	ContentType != 'Newsletter';