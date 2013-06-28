#!/usr/local/bin/lua
local m = require "AVLTreeModule"
avlTree = m.AVLTree:new()
--math.randomseed(os.time())
nodes = {}
for i = 1, 10 do
	nodes[i] = math.random(100)
	avlTree:insert(nodes[i])
end

io.write("插入以下值构建树:")
for i in pairs(nodes) do
	io.write(nodes[i].." ")
end
io.write("\n")

print("按顺序打印所有节点值")
avlTree:printKeyByOrder(avlTree.root)

print("按顺序打印所有节点")
avlTree:printByOrder(avlTree.root)

print("删除79，打印所有节点")
avlTree:delete(79)
avlTree:printByOrder(avlTree.root)
print("删除85，打印所有节点")
avlTree:delete(85)
avlTree:printByOrder(avlTree.root)
