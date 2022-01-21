equation = "11x^3 + 88x^3 + 11y^2 - 66y^1"

--TODO list
	--Format input string to remove fractions and divisions by variable
	--Return error or reject input if problem cannot be solved with power rule
	--Add GUI

function is_term_sep(c)
	local ops = {"+","-"}
	for k,v in pairs(ops)
	do
		if c == v then
			return true
		end
	end
	return false
end
equation = string.gsub(equation, " ", "")

function power_rule(eq)
	local terms = {}
	local ops = {}
	local term_si = 1
	for i = 1,string.len(eq),1
	do
		if(is_term_sep(string.sub(eq,i,i))) then
			table.insert(terms, string.sub(eq,term_si,i-1))
			table.insert(ops, string.sub(eq,i,i))
			term_si = i + 1 
		end
	end

	table.insert(terms, string.sub(eq,term_si,string.len(eq)))
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
	for k,v in pairs(ops)
	do
		out = out .. terms[k] .. " " .. ops[k] .. " "
		counter = counter + 1
	end
	out = out .. terms[counter]
	return out
end
print(power_rule(equation))