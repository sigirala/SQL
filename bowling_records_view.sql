CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `bowling_records` AS
    SELECT 
        `b`.`bowling_team` AS `Country`,
        `b`.`bowler` AS `bowler`,
        COUNT(0) AS `matches`,
        ((SUM(FLOOR(`b`.`no_of_overs`)) + FLOOR((SUM(((`b`.`no_of_overs` - FLOOR(`b`.`no_of_overs`)) * 10)) / 6))) + (((SUM((`b`.`no_of_overs` - FLOOR(`b`.`no_of_overs`))) * 10) % 6) / 10)) AS `overs`,
        SUM(`mo`.`n_of_maidens`) AS `maidens`,
        SUM(`b`.`runs`) AS `runs`,
        ROUND((SUM(`b`.`runs`) / SUM(`b`.`no_of_overs`)),
                2) AS `eco`,
        SUM(`b`.`no_of_wickets`) AS `wickets`,
        SUM((CASE
            WHEN (`b`.`no_of_wickets` = 4) THEN 1
            ELSE 0
        END)) AS `4W`,
        SUM((CASE
            WHEN (`b`.`no_of_wickets` = 5) THEN 1
            ELSE 0
        END)) AS `5W`
    FROM
        (`bowlingstats` `b`
        LEFT JOIN `maidenoversview` `mo` ON (((`b`.`match_id` = `mo`.`match_id`)
            AND (`b`.`bowler` = `mo`.`bowler`))))
    GROUP BY `b`.`bowling_team` , `b`.`bowler`
    ORDER BY `wickets` DESC