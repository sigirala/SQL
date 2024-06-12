CREATE DEFINER=`root`@`localhost` PROCEDURE `battingrecords_by_country`(IN p_batting_team VARCHAR(255))
BEGIN
    SELECT
        batting_team,
        striker,
        count(*) as no_of_matches,
        SUM(runs) AS runs,
        SUM(balls) AS balls,
        SUM(n_of_fours) AS fours,
        SUM(n_of_sixes) AS sixes,
        ROUND((SUM(runs) / NULLIF(SUM(balls), 0) * 100), 2) AS strike_rate
    FROM
        batting_stats
    WHERE
        batting_team = p_batting_team
    GROUP BY
        batting_team, striker
    ORDER BY
        runs DESC;
END