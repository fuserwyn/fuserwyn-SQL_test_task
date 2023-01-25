CREATE TABLE IF NOT EXISTS public.initial 
(
	id integer PRIMARY KEY,
 	company text
);

INSERT INTO initial VALUES
	(1,	'yandex'),
	(2,	'yandex'),
	(3,	'facebook'),
	(4,	'прямой вход'),
	(5,	'yandex'),
	(6,	'google'),
	(7,	'google'),
	(8,	'google'),
	(9,	'прямой вход'),
	(10,'прямой вход');

SELECT company, COUNT(1) AS chain_count
FROM (
	SELECT
		id,
		company,
		(	
			ROW_NUMBER() OVER (ORDER BY id) -
			ROW_NUMBER() OVER (PARTITION BY company ORDER BY id)
		) AS id_occurrence_difference
	FROM initial
	ORDER BY id
) AS difference_table
GROUP BY company, id_occurrence_difference
ORDER BY MIN(id);
