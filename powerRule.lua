equation = "11x^3 + 88x^3 + 11a^2 - 66b^1"
equation = string.gsub(equation, " ", "")

local PR = {}

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

function one_var(term)
    abc = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
    vars = 0
    for i = 1,#term do
        for j = 1,#abc do
            if string.sub(term,i,i) == abc[j] then
                vars = vars + 1
            end
        end
    end
    return vars
end

function PR.power_rule(eq)
    --performs the power rule on string
    local terms = {}
    local ops = {}
    local term_si = 1
    --loop seperates equation into terms
    for i = 1,#eq,1
    do
        if(is_term_sep(string.sub(eq,i,i))) then
            local tmp = string.sub(eq,term_si,i-1)
            if one_var(string.sub(eq,i-1,i-1)) == 1 then
                tmp = tmp .. "^" .. "1"
            end
            table.insert(terms, string.sub(eq,term_si,i-1))
            term_si = i + 1
            table.insert(ops, string.sub(eq,i,i))
        end
    end
    local tmp = string.sub(eq,term_si,#eq)
    table.insert(terms, tmp)
    --loop performs power rule own each term
    for k,v in pairs(terms)
    do
        for i = 1,#v
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
        out = out .. terms[k] .. ops[k]
        counter = counter + 1
    end
    out = out .. terms[counter]
    return out
end

return PR