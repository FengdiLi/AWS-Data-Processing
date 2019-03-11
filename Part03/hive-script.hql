create external table bigram 
(
gram STRING, 
year INT,
occur INT, 
book INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t' 
LOCATION  '/user/hadoop/bigrams/';

INSERT OVERWRITE DIRECTORY 'pig-results2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',' 

SELECT gram,
SUM(occur) AS total_cnt,
SUM(book) AS total_bk,
SUM(occur)*1.0/SUM(book) AS rate,
MIN(year) as first_yr,
MAX(year) as final_yr,
COUNT(year) as cnt
FROM bigram
GROUP BY gram
HAVING (first_yr = 1950 AND final_yr = 2009 AND cnt = 60)
ORDER BY rate DESC
LIMIT 10;
