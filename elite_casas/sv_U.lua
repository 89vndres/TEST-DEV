gid = function(cant)
	
	local str = ""
	for i = 1,cant do
		local actu = math.random(1,35)
		if actu > 26 then
			str = str..actu-26
		else
			str = str..string.char(64+actu)
		end
	end

	return str
end