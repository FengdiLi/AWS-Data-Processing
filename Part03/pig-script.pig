bigram = LOAD 's3://bigdatateaching/bigrams/googlebooks-eng-us-all-2gram-20120701-i*' AS (gram:chararray, year:int, occur:int, book:int);

X = GROUP bigram BY gram;

sub_gram = FOREACH X GENERATE 
	
	group AS gram,

	SUM(bigram.occur) AS total_cnt,

	SUM(bigram.book) AS total_bk,

	(double)SUM(bigram.occur)/SUM(bigram.book) AS rate,

	MIN(bigram.year) AS first_yr,
	
	MAX(bigram.year) AS final_yr,

	COUNT(bigram.year) AS cnt;

Y = FILTER sub_gram BY first_yr == 1950 AND final_yr == 2009 AND cnt == 60;

gram_od = ORDER Y BY rate DESC,gram;

Z = LIMIT gram_od 10;

STORE Z INTO 'pig-results' USING PigStorage(',');
