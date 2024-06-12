CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `batting_stats` AS
    SELECT 
        `subquery`.`match_id` AS `match_id`,
        `subquery`.`striker` AS `striker`,
        `subquery`.`batting_team` AS `batting_team`,
        `subquery`.`bowling_team` AS `bowling_team`,
        `subquery`.`venue` AS `venue`,
        `subquery`.`innings` AS `innings`,
        SUM(`subquery`.`runs_off_bat`) AS `runs`,
        COUNT(0) AS `balls`,
        (CASE
            WHEN (SUM(`subquery`.`out`) = 1) THEN 0
            ELSE 1
        END) AS `notout`,
        SUM((CASE
            WHEN (`subquery`.`runs_off_bat` = 4) THEN 1
            ELSE 0
        END)) AS `n_of_fours`,
        SUM((CASE
            WHEN (`subquery`.`runs_off_bat` = 6) THEN 1
            ELSE 0
        END)) AS `n_of_sixes`
    FROM
        (SELECT 
            `odi_match_data`.`match_id` AS `match_id`,
                `odi_match_data`.`striker` AS `striker`,
                `odi_match_data`.`batting_team` AS `batting_team`,
                `odi_match_data`.`bowling_team` AS `bowling_team`,
                `odi_match_data`.`venue` AS `venue`,
                `odi_match_data`.`innings` AS `innings`,
                `odi_match_data`.`runs_off_bat` AS `runs_off_bat`,
                (CASE
                    WHEN (`odi_match_data`.`player_dismissed` = `odi_match_data`.`striker`) THEN 1
                    ELSE 0
                END) AS `out`
        FROM
            `odi_match_data`) `subquery`
    GROUP BY `subquery`.`match_id` , `subquery`.`striker` , `subquery`.`batting_team` , `subquery`.`bowling_team` , `subquery`.`venue` , `subquery`.`innings`
    ORDER BY `subquery`.`match_id`