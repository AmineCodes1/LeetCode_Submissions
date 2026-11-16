# Write your MySQL query statement below
SELECT *,
CASE WHEN LEFT(dna_sequence,3)='ATG' THEN 1 ELSE 0 END AS has_start,
CASE WHEN RIGHT(dna_sequence,3)in('TAA','TAG','TGA') THEN 1 ELSE 0 END AS has_stop,
CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END AS has_atat,
CASE WHEN dna_sequence REGEXP 'GGG+' THEN 1 ELSE 0 END AS has_ggg
FROM Samples
ORDER BY SAMPLE_ID;