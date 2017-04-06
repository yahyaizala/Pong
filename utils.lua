M={}
function M.hasCollideCircle(obj1,obj2)
	if obj2==nil or obj1==nil then return false end
	local dx=obj1.x-obj2.x
	local dy=obj1.y-obj2.y
	local distance=math.sqrt(dx^2+dy^2)
	local objectSize=(obj2.contentWidth+obj2.contentWidth)/2
	if distance<objectSize then
		return true
	end
	return false
end
function M.hasCollideRect(obj1,obj2)
	if obj1==nil or obj2==nil then return false end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and(up or down)
end
return M