#!/opt/lua/bin/lua
function printarr(arr)
	for i in ipairs(arr) do
		io.write(arr[i].." ")
	end
	io.write("\n")
end

function QuickSort(arr, bIndex, eIndex)
	local mid = SortPartition(arr, bIndex, eIndex)
	if bIndex < mid then
		QuickSort(arr, bIndex, mid-1)
	end
	if mid < eIndex then
		QuickSort(arr, mid+1, eIndex) end
end

function SortPartition(arr, bIndex, eIndex)
	local rIndex = math.random(bIndex, eIndex)
	arr[rIndex], arr[eIndex] = arr[eIndex], arr[rIndex]
	local i, j = bIndex-1, bIndex
	while j < eIndex do
		if arr[j] < arr[eIndex] then
			i = i + 1
			a[i], a[j] = a[j], a[i]
		end
		j = j + 1
	end
	a[i+1], a[eIndex] = a[eIndex], a[i+1]
	return i+1
end

a = {}
n = 50
math.randomseed(os.time())
for i = 1, n do
	a[i] = math.random(1, 100)
end
printarr(a)

QuickSort(a, 1, n)
printarr(a)
