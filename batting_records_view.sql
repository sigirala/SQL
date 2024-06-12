CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `batting_records` AS
    SELECT 
        `batting_stats`.`batting_team` AS `country`,
        `batting_stats`.`striker` AS `player`,
        COUNT(0) AS `no_of_matches`,
        SUM(`batting_stats`.`runs`) AS `runs`,
        SUM(`batting_stats`.`balls`) AS `balls`,
        MAX(`batting_stats`.`runs`) AS `highest`,
        SUM(`batting_stats`.`notout`) AS `notout`,
        SUM((CASE
            WHEN
                ((`batting_stats`.`runs` >= 50)
                    AND (`batting_stats`.`runs` < 100))
            THEN
                1
            ELSE 0
        END)) AS `fifties`,
        SUM((CASE
            WHEN
                ((`batting_stats`.`runs` >= 100)
                    AND (`batting_stats`.`runs` < 200))
            THEN
                1
            ELSE 0
        END)) AS `hundereds`,
        SUM((CASE
            WHEN
                ((`batting_stats`.`runs` >= 200)
                    AND (`batting_stats`.`runs` < 300))
            THEN
                1
            ELSE 0
        END)) AS `two_hundereds`,
        SUM(`batting_stats`.`n_of_fours`) AS `fours`,
        SUM(`batting_stats`.`n_of_sixes`) AS `sixes`,
        SUM((CASE
            WHEN
                ((`batting_stats`.`runs` = 0)
                    AND (`batting_stats`.`notout` = 0))
            THEN
                1
            ELSE 0
        END)) AS `duckout`,
        ROUND(((SUM(`batting_stats`.`runs`) / NULLIF(SUM(`batting_stats`.`balls`), 0)) * 100),
                2) AS `strike_rate`
    FROM
        `batting_stats`
    GROUP BY `batting_stats`.`batting_team` , `batting_stats`.`striker`
    ORDER BY `runs` DESC