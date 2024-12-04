/* 
The sql raw dataset is too big to submit in Github, this is why the file folder 01-raw_data is empty, 
but i provide the link that you can download the raw sql dataset "https://jacobfilipp.com/hammer/".
After successfully download, you can use this code to filter data, and then use the rcode one by one.
If you doesn't want to download this huge dataset, you can just skip 02-download_data.sql, 
i prepare the clean_data.csv in file folder 02-analysis_data, you can directly use 03-clean_data.R.
*/
CREATE TABLE clean_data AS
SELECT 
	nowtime,
    product_id,
    current_price,
    price_per_unit,
	other
FROM raw
WHERE product_id IN (4068860, 3677991, 1704900, 2892726, 712154, 919285, 2321339, 3358207, 
712206, 1688551, 2332786, 2881295, 3357385, 3998031, 3677154, 920226, 
1698576, 2875605, 2320771, 3678071, 4068282, 710822, 3358119, 917069, 
1695676, 2328223, 2886297, 3360423, 4073728, 3677566, 711970, 917272);