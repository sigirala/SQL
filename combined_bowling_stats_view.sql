CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `combined_bowling_stats` AS
    SELECT 
        `m`.`match_id` AS `match_id`,
        `m`.`bowler` AS `bowler`,
        `m`.`batting_team` AS `batting_team`,
        `m`.`bowling_team` AS `bowling_team`,
        `m`.`venue` AS `venue`,
        `m`.`innings` AS `innings`,
        `m`.`no_of_overs` AS `no_of_overs`,
        COALESCE(`n`.`n_of_maidens`, 0) AS `n_of_maidens`,
        `m`.`runs` AS `runs`,
        `m`.`extras` AS `extras`,
        `m`.`no_of_wickets` AS `no_of_wickets`
    FROM
        (`bowlingstats` `m`
        LEFT JOIN `maidenoversview` `n` ON (((`m`.`match_id` = `n`.`match_id`)
            AND (`m`.`bowler` = `n`.`bowler`))))
    ORDER BY `m`.`match_id`