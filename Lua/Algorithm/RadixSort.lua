#!/opt/lua/bin/lua
function printarr(arr)
	for i in ipairs(arr) do
		io.write(arr[i].value.." ")
	end
	io.write("\n")
end

function RadixSort(arr)
	local times = CountSortTimes(arr)
	local offset = times
	while offset > 0 do
		arr = CountSort(arr, times-offset)
		offset = offset - 1
	end
	return arr
end

function CountSortTimes(arr)
	local maxNum = 0
	for i = 1, n do
		maxNum = maxNum > arr[i].value and maxNum or arr[i].value
	end
	local pow = 0
	while maxNum > 0 do
		pow = pow + 1
		maxNum = math.floor(maxNum/10)
	end
	return pow
end

function CountSort(arr, pos)
	for i, v in ipairs(arr) do
		arr[i].key = ExtractKey(arr[i].value, pos)
	end
	local tmp, ret = {}, {}
	for i = 1, 10 do
		tmp[i] = 0
	end
	for i = 1, n do
		tmp[arr[i].key+1] = tmp[arr[i].key+1] + 1
	end
	for i = 1, 9 do
		tmp[i+1] = tmp[i] + tmp[i+1]
	end
	for i = n, 1, -1 do
		ret[tmp[arr[i].key+1]] = arr[i]
		tmp[arr[i].key+1] = tmp[arr[i].key+1] - 1
	end
	return ret
end

function ExtractKey(value, pos)
	value = math.floor(value/math.pow(10, pos))
	value = value - math.floor(value/10) * 10
	return value
end

a = {}
n = 50
math.randomseed(os.time())
for i = 1, n do
	a[i] = {key = 0, value = math.random(1, 1000)}
end
printarr(a)

a = RadixSort(a)
printarr(a)
