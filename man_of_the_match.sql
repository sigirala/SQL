select date,team1,team2,winner,player_of_match,COALESCE(bs.runs,0) as runs ,COALESCE(bo.no_of_wickets,0) as wickets from odi_match_info o
left join batting_stats bs on bs.match_id = o.id and player_of_match = striker
left join bowlingstats bo on bo.match_id = o.id and player_of_match = bowler
where winner = 'India' and (bs.runs is not null or bo.no_of_wickets is not null) 



