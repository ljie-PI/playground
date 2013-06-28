module (..., package.seeall)

Node = {key = 0, left = nil, right = nil, parent = nil, height = 0}
function Node:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Node:getHeight()
	if self == nil then
		return -1
	else
		return self.height
	end
end

function Node:setHeight()
	if self.left == nil then
		lHeight = -1
	else
		lHeight = self.left:getHeight()
	end
	if self.right == nil then
		rHeight = -1
	else
		rHeight = self.right:getHeight()
	end
	if lHeight > rHeight then
		self.height = lHeight + 1
	else
		self.height = rHeight + 1
	end
end

function Node:printNode()
	local locleft = self.left and self.left.key or "nil"
	local locright = self.right and self.right.key or "nil"
	local locparent = self.parent and self.parent.key or "nil"
	io.write("{key="..self.key.." left="..locleft.." right="..locright.." parent="..locparent.." height="..self.height.."}\n")
end

AVLTree = {root = nil, keysByOrder = {}}
function AVLTree:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function AVLTree:getKeyByOrder(root)
	if root ~= nil then
		self:getKeyByOrder(root.left)
		table.insert(self.keysByOrder, root.key.." ")
		self:getKeyByOrder(root.right)
	end
end

function AVLTree:printKeyByOrder(root)
	self:getKeyByOrder(root)
	for i in pairs(self.keysByOrder) do
		io.write(self.keysByOrder[i].." ")
	end
	io.write("\n")
end

function AVLTree:printByOrder(root)
	if root ~= nil then
		self:printByOrder(root.left)
		root:printNode()
		self:printByOrder(root.right)
	end
end

function AVLTree:adjustHeight(node)
	while node.parent ~= nil do
		node.parent:setHeight()
		node = node.parent
	end
end

function AVLTree:adjust(tmpRoot)
	while tmpRoot ~= nil do
		local mainDelta, mainLHeight, mainRHeight
		if tmpRoot.left == nil then
			mainLHeight = -1
		else
			mainLHeight = tmpRoot.left:getHeight()
		end
		if tmpRoot.right == nil then
			mainRHeight = -1
		else
			mainRHeight = tmpRoot.right:getHeight()
		end
		mainDelta = mainLHeight - mainRHeight
		if mainDelta == -2 then
			local subDelta, subLHeight, subRHeight
			if tmpRoot.right.left == nil then
				subLHeight = -1
			else
				subLHeight = tmpRoot.right.left:getHeight()
			end
			if tmpRoot.right.right == nil then
				subRHeight = -1
			else
				subRHeight = tmpRoot.right.right:getHeight()
			end
			subDelta = subLHeight - subRHeight
			if subDelta == -1 then
				self:singleRL(tmpRoot)
			else
				self:doubleRL(tmpRoot)
			end
			self:adjustHeight(tmpRoot.parent)
		elseif mainDelta == 2 then
			local subDelta, subLHeight, subRHeight
			if tmpRoot.left.left == nil then
				subLHeight = -1
			else
				subLHeight = tmpRoot.left.left:getHeight()
			end
			if tmpRoot.left.right == nil then
				subRHeight = -1
			else
				subRHeight = tmpRoot.left.right:getHeight()
			end
			subDelta = subLHeight - subRHeight
			if subDelta == 1 then
				self:singleRR(tmpRoot)
			else
				self:doubleRR(tmpRoot)
			end
			self:adjustHeight(tmpRoot.parent)
		else
			if tmpRoot.parent ~= nil then
				tmpRoot = tmpRoot.parent
			else
				break
			end
		end
	end
end

function AVLTree:singleRL(node)
	local preParent, preRight = node, node.right
	if preRight == nil then
		return false
	end
	preParent.right = preRight.left
	if preRight.left ~= nil then
		preRight.left.parent = preParent
	end
	if preParent ~= self.root then
		if preParent == preParent.parent.left then
			preParent.parent.left = preRight
		else
			preParent.parent.right = preRight
		end
		preRight.parent = preParent.parent
	else
		self.root = preRight
		preRight.parent = nil
	end
	preParent.parent = preRight
	preRight.left = preParent
	preParent:setHeight()
	preRight:setHeight()
	return true
end

function AVLTree:singleRR(node)
	local preParent, preLeft = node, node.left
	if preLeft == nil then
		return false
	end
	preParent.left = preLeft.right
	if preLeft.right ~= nil then
		preLeft.right.parent = preParent
	end
	if preParent ~= self.root then
		if preParent == preParent.parent.left then
			preParent.parent.left = preLeft
		else
			preParent.parent.right = preLeft
		end
		preLeft.parent = preParent.parent
	else
		self.root = preLeft
		preLeft.parent = nil
	end
	preParent.parent = preLeft
	preLeft.right = preParent
	preParent:setHeight()
	preLeft:setHeight()
	return true
end

function AVLTree:doubleRL(node)
	local preRight = node.right
	if preRight == nil then
		return false
	end
	self:singleRR(preRight)
	self:singleRL(node)
end

function AVLTree:doubleRR(node)
	local preLeft = node.left
	if preLeft == nil then
		return false
	end
	self:singleRL(preLeft)
	self:singleRR(node)
end

function AVLTree:insert(key)
	if self.root == nil then
		self.root = Node:new({key = key, height = 0})
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
	local node = Node:new({key = key, parent = lastNode, height = 0})
	if key < lastNode.key then
		lastNode.left = node
	else
		lastNode.right = node
	end
	self:adjustHeight(node)
	self:adjust(node.parent.parent)
end

function AVLTree:search(key)
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

function AVLTree:nextNode(node)
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

function AVLTree:delete(key)
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
	self:adjust(altNode.parent)
	return altNode
end

function haha()
	print("haha")
end

