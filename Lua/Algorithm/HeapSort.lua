#!/opt/lua/bin/lua
function printarr(arr)
	for i in ipairs(arr) do
		io.write(arr[i].." ")
	end
	io.write("\n")
end

function HeapSort(arr, n)
	MakeSort(arr, n)
	for i = n, 3, -1 do
		a[1], a[i] = a[i], a[1]
		AdjustHeap(arr, 1, i-1)
	end
	if arr[1] > arr[2] then
		arr[1], arr[2] = arr[2], arr[1]
	end
end

function MakeSort(arr, n)
	for i = math.ceil(n/2), 1, -1 do
		AdjustHeap(arr, i, n)
	end
end

function AdjustHeap(arr, bIndex, eIndex)
	local tIndex, curIndex = 0, bIndex
	while curIndex*2 <= eIndex do
		if curIndex*2+1 > eIndex then
			tIndex = curIndex
		else
			tIndex = arr[curIndex*2] > arr[curIndex*2+1] and curIndex*2 or curIndex*2+1
		end
		if arr[tIndex] > arr[curIndex] then
			arr[tIndex], arr[curIndex] = arr[curIndex], arr[tIndex]
			curIndex = tIndex
		else
			break
		end
	end
end

a = {}
n = 50
math.randomseed(os.time())
for i = 1, n do
	a[i] = math.random(1, 100)
end
printarr(a)

HeapSort(a, n)
printarr(a)
