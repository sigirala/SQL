CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStats`(IN p_country VARCHAR(255), IN p_year INT)
BEGIN
  SELECT 
    YEAR(date) AS year,
    CASE WHEN team1 = p_country THEN team1 ELSE team2 END AS country,
    CASE WHEN team1 != p_country THEN team1 ELSE team2 END AS opposition,
    COUNT(*) AS matches_count,
    SUM(CASE WHEN winner = p_country THEN 1 ELSE 0 END) AS no_of_matches_won,
    SUM(CASE WHEN winner != p_country THEN 1 ELSE 0 END) AS no_of_matches_loss,
	round(IFNULL((SUM(CASE WHEN winner = p_country THEN 1 ELSE 0 END) /
    NULLIF(COUNT(*), 0) * 100), 0),2) AS percentage_of_win
  FROM 
    odi_match_info
  WHERE 
    p_country IN (team1, team2) AND (p_year IS NULL OR YEAR(date) = p_year)
  GROUP BY 
    year, country, opposition WITH ROLLUP
  HAVING 
    (year IS NOT NULL AND country IS NOT NULL) 
  ORDER BY 
    year DESC, matches_count DESC, no_of_matches_won DESC, opposition;
END