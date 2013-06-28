#!/opt/lua/bin/lua
local m = require "BinTreeModule"
binTree = m.BinTree:new()
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
