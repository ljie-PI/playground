module (..., package.seeall)

Node = {key = 0, left = nil, right = nil, parent = nil}
function Node:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Node:printNode()
	local locleft = self.left and self.left.key or "nil"
	local locright = self.right and self.right.key or "nil"
	local locparent = self.parent and self.parent.key or "nil"
	io.write("{key="..self.key.." left="..locleft.." right="..locright.." parent="..locparent.."}\n")
end

BinTree = {root = nil, keysByOrder = {}}
function BinTree:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function BinTree:getKeyByOrder(root)
	if root ~= nil then
		self:getKeyByOrder(root.left)
		table.insert(self.keysByOrder, root.key.." ")
		self:getKeyByOrder(root.right)
	end
end

function BinTree:printKeyByOrder(root)
	self:getKeyByOrder(root)
	for i in pairs(self.keysByOrder) do
		io.write(self.keysByOrder[i].." ")
	end
	io.write("\n")
end

function BinTree:printByOrder(root)
	if root ~= nil then
		self:printByOrder(root.left)
		root:printNode()
		self:printByOrder(root.right)
	end
end

function BinTree:insert(key)
	if self.root == nil then
		self.root = Node:new({key = key})
		return
	end
	local curNode, lastNode = self.root, nil
	while curNode ~= nil do
		lastNode = curNode
		if key < curNode.key then
			curNode = curNode.left
		else
			curNode = curNode.right
		end
	end
	node = Node:new({key = key, parent = lastNode})
	if key < lastNode.key then
		lastNode.left = node
	else
		lastNode.right = node
	end
end

function BinTree:search(key)
	local curNode, lastNode = self.root, nil
	while curNode ~= nil do
		lastNode = curNode
		if key == curNode.key then
			return curNode
		elseif key < curNode.key then
			curNode = curNode.left
		else
			curNode = curNode.right
		end
	end
	return false
end

function BinTree:nextNode(node)
	if node.right == nil then
		while node.parent.key <= node.key and node ~= nil do
			node = node.parent
		end
		return node.parent
	else
		local tmpNode, lastNode = node.right, nil
		while tmpNode ~= nil do
			lastNode = tmpNode
			tmpNode = tmpNode.left
		end
		return lastNode
	end
end

function BinTree:delete(key)
	local delNode, altNode, repNode
	delNode = self:search(key)
	if not delNode then
		return false
	end
	if delNode.left == nil or delNode.left == nil then
		altNode = delNode
	else
		altNode = self:nextNode(delNode)
	end
	if altNode.left ~= nil then
		repNode = altNode.left
	else
		repNode = altNode.right
	end
	if repNode ~= nil then
		repNode.parent = altNode.parent
	end
	if altNode.parent == nil then
		slef.root = repNode
	else
		if altNode == altNode.parent.left then
			altNode.parent.left = repNode
		else
			altNode.parent.right = repNode
		end
	end
	if altNode ~= delNode then
		delNode.key = altNode.key
	end
	return altNode
end

function haha()
	print("haha")
end

--[[
binTree = BinTree:new()
--math.randomseed(os.time())
nodes = {}
for i = 1, 10 do
	nodes[i] = math.random(100)
	binTree:insert(nodes[i])
end
io.write("插入以下值构建树:")
for i in pairs(nodes) do
	io.write(nodes[i].." ")
end
io.write("\n")

print("按顺序打印所有节点值")
binTree:printKeyByOrder(binTree.root)

print("按顺序打印所有节点")
binTree:printByOrder(binTree.root)

print("值为40的后继节点")
node = binTree:search(40)
binTree:nextNode(node):printNode()

print("删除56，打印所有节点")
binTree:delete(56)
binTree:printByOrder(binTree.root)
print("插入78，打印所有节点")
binTree:insert(78)
binTree:printByOrder(binTree.root)
print("删除40，打印所有节点")
binTree:delete(40)
binTree:printByOrder(binTree.root)
print("删除79，打印所有节点")
binTree:delete(79)
binTree:printByOrder(binTree.root)
print("删除92，打印所有节点")
binTree:delete(92)
binTree:printByOrder(binTree.root)
]]--
