CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `maidenoversview` AS
    SELECT 
        `d`.`match_id` AS `match_id`,
        `d`.`bowler` AS `bowler`,
        SUM(`d`.`maiden_over`) AS `n_of_maidens`
    FROM
        (SELECT 
            `odi_match_data`.`match_id` AS `match_id`,
                `odi_match_data`.`bowler` AS `bowler`,
                FLOOR(`odi_match_data`.`ball`) AS `over_number`,
                (CASE
                    WHEN
                        ((COUNT(DISTINCT `odi_match_data`.`ball`) = 6)
                            AND (SUM(`odi_match_data`.`runs_off_bat`) = 0)
                            AND (SUM(`odi_match_data`.`extras`) = 0))
                    THEN
                        1
                    ELSE 0
                END) AS `maiden_over`
        FROM
            `odi_match_data`
        GROUP BY `odi_match_data`.`match_id` , `odi_match_data`.`bowler` , `over_number`) `d`
    GROUP BY `d`.`match_id` , `d`.`bowler`