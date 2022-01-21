equation = "11x^3 + 88x^3 + 11a^2 - 66b^1"
equation = string.gsub(equation, " ", "")

function is_term_sep(c)
	--checks if character is '+' or '-'
	local ops = {"+","-"}
	for k,v in pairs(ops)
	do
		if c == v then
			return true
		end
	end
	return false
end

function power_rule(eq)
	--performs the power rule on string
	local terms = {}
	local ops = {}
	local term_si = 1
	--loop seperates equation into terms
	for i = 1,string.len(eq),1
	do
		if(is_term_sep(string.sub(eq,i,i))) then
			table.insert(terms, string.sub(eq,term_si,i-1))
			table.insert(ops, string.sub(eq,i,i))
			term_si = i + 1 
		end
	end
	table.insert(terms, string.sub(eq,term_si,string.len(eq)))

	--loop performs power rule own each term
	for k,v in pairs(terms)
	do
		for i = 1,string.len(v)
		do
			if string.sub(v,i,i) == "^" then
				local num = tonumber(string.sub(v,i+1,-1))*tonumber(string.sub(v,1,i-2))
				if tonumber(string.sub(v,i+1,-1))-1 == 0 then
					v = tostring(num)
				elseif tonumber(string.sub(v,i+1,-1))-1 == 1 then
					v = tostring(num) .. string.sub(v,i-1,i-1)
				else
					v = tostring(num) .. string.sub(v,i-1,i-1) .. "^" ..tostring(tonumber(string.sub(v,i+1,-1))-1)
				end
				terms[k] = v
				break
			end
		end
	end
	local out = ""
	local counter = 1
	--Puts terms back into an equation string
	for k,v in pairs(ops)
	do
		out = out .. terms[k] .. " " .. ops[k] .. " "
		counter = counter + 1
	end
	out = out .. terms[counter]
	return out
end

print(power_rule(equation))
