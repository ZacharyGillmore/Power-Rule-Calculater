eq = "11x^3 + 88x + 11y^2"
function isnumber(c)
	for i = 0,9,1
	do
		if c == tostring(i) then
			return true
		end
	end
	return false
end
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
eq = string.gsub(eq, " ", "")

terms = {}
ops = {}
term_si = 1
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
	print(v)
end

for k,v in pairs(ops)
do
	print(v)
end