WITH patients_having_pos_and_neg_tests AS(
    SELECT p.*,MIN(c.test_date) as first_p_test_date FROM patients p
    JOIN covid_tests c on c.patient_id=p.patient_id and result='Positive'
    WHERE p.patient_id IN(SELECT patient_id FROM covid_tests where result='Negative')
    GROUP BY p.patient_id,p.patient_name
)

SELECT pt.patient_id,pt.patient_name,pt.age,DATEDIFF(MIN(c.test_date), pt.first_p_test_date) as recovery_time
FROM patients_having_pos_and_neg_tests pt
JOIN covid_tests c on (c.patient_id=pt.patient_id and c.result='Negative' AND c.test_date>pt.first_p_test_date)
GROUP BY pt.patient_id, pt.patient_name, pt.age
ORDER BY recovery_time,pt.patient_name;


