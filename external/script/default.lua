if gamemode('bonus') or gamemode('freebattle') or gamemode('netplayversus') or gamemode('scorechallenge') or gamemode('timechallenge') or gamemode('training') or gamemode('versus') or gamemode('versuscoop') or gamemode('watch') then
	LaunchFight{}
	setMatchNo(-1)
	return
end

if main.storyboard.intro and matchno() == 1 and not continue() then
	LaunchStoryboard(start.f_getCharData(start.p[1].t_selected[1].ref).intro)
end

for i = matchno(), #start.t_roster do
	if start.t_roster[i][1] == -1 then --infinite matches flag detected
		return --restart lua script after appending new entries
	end
	local t_p2char = {}
	for _, v in ipairs(start.t_roster[i]) do
		table.insert(t_p2char, start.f_getCharData(v).char)
	end
	main.f_tableShuffle(t_p2char)
	if not LaunchFight{p2char = t_p2char, p2numchars = #t_p2char} then return end
end

if main.storyboard.ending then
	if not LaunchStoryboard(start.f_getCharData(start.p[1].t_selected[1].ref).ending) and motif.default_ending.enabled == 1 then
		LaunchStoryboard(motif.default_ending.storyboard)
	end
end

setMatchNo(-1)