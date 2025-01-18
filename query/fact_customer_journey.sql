
-- Common table expression (CTE) to identify and tag duplicate records
WITH DuplicateRecords AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		-- user ROW_NUMBER() to assign a unique row number to each record within the partition defined below
		 ROW_NUMBER() OVER (
            -- PARTITION BY groups the rows based on the specified columns that should be unique
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  
            -- ORDER BY defines how to order the rows within each partition (usually by a unique identifier like JourneyID)
            ORDER BY JourneyID  
        ) AS row_num  -- This creates a new column 'row_num' that numbers each row within its partition
    FROM 
        dbo.customer_journey  -- Specifies the source table from which to select the data
)

-- Select all records from the CTE where row_num > 1, which indicates duplicate entries
SELECT *
FROM DuplicateRecords
WHERE row_num > 1 -- filters out the first occurence (row_num = 1) and only shows the duplicates (row_num > 1)
ORDER BY JourneyID

SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) AS Duration -- replaces missing durations with the average duration for the corresponding
FROM
	(
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage,
			Action,
			Duration,
			AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,
			ROW_NUMBER() OVER (
				PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action
				ORDER BY JourneyID
			) AS row_num
		FROM
			dbo.customer_journey
	) AS subquery
WHERE
	row_num = 1;

