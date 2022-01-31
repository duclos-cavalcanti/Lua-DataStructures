local Node = {}
Node.__index = Node

function Node:new(key, data)
    data = data or {}

    return setmetatable({
            left = nil,
            right = nil,
            key = key,
            data = data,
        }, self)
end

local BinaryTree = {}
BinaryTree.__index = BinaryTree

function BinaryTree:new()
    return setmetatable({
        size = 0,
        root = nil,
        }, self)
end

function BinaryTree:empty()
    return self.root == nil
end

function BinaryTree:insert(node)
    assert(type(node.key) == "number", "Wrong key type for Binary Tree")

    local function _insert(root)
        if node.key <= root.key then
            if root.left == nil then
                root.left = node
                return
            else
                root = root.left
                _insert(root)
            end
        else
            if root.right == nil then
                root.right = node
                return
            else
                root = root.right
                _insert(root)
            end
        end
    end

    if self.root == nil then
        self.root = node
    else
        root = self.root
        _insert(root)
    end
    self.size = self.size + 1
end

function BinaryTree:height()
    local function _max(a, b)
        if a > b then
            return a
        else
            return b
        end
    end

    local function _height(root)
        if root == nil then
            return 0
        end

        return 1 + _max(_height(root.left), _height(root.right))
    end

    return _height(self.root)
end

-- DFS
function BinaryTree:inOrderTraversal()
    local function _inOrderTraversal(root)
        if root == nil then
            return 0
        end
        _inOrderTraversal(root.left)
        print(root.key)
        _inOrderTraversal(root.right)
    end
    _inOrderTraversal(self.root)
end

-- DFS
function BinaryTree:preOrderTraversal()
    local function _preOrderTraversal(root)
        if root == nil then
            return 0
        end
        print(root.key)
        _preOrderTraversal(root.left)
        _preOrderTraversal(root.right)
    end
    _preOrderTraversal(self.root)
end

-- DFS
function BinaryTree:postOrderTraversal()
    local function _postOrderTraversal(root)
        if root == nil then
            return 0
        end
        _postOrderTraversal(root.left)
        _postOrderTraversal(root.right)
        print(root.key)
    end
    _postOrderTraversal(self.root)
end

-- BFS
function BinaryTree:levelTraversal()
    local Queue = require("ds.queue")
    q = Queue:new()

    if self.root == nil then
        return
    end

    q:enqueue(self.root.key, self.root)
    while(not q:empty()) do
        node = q:dequeue().data
        print(node.key)
        if node.left ~= nil then
            q:enqueue(node.left.key, node.left)
        end
        if node.right ~= nil then
            q:enqueue(node.right.key, node.right)
        end
    end
    
end

function BinaryTree:printState()
    if self:empty() then 
        print("Tree: Empty")
        return nil 
    end

    local function _printState(padding, edge, node, hasLeft)
        if node ~= nil then
            io.write("\n", padding, edge, node.key)
            if node.left == nil and node.right == nil then
                io.write("\n", padding)
                if hasLeft then; io.write("|"); end
            else
                if hasLeft then
                    padding = padding .. "|    "
                else
                    padding = padding .. "     "
                end
                _printState(padding, "|----", node.right, node.left ~= nil)
                _printState(padding, "|____", node.left, false)
            end
        end
    end

    print("STATE:")
    io.write(self.root.key)
    _printState("", "|----", self.root.right, self.root.left ~= nil)
    _printState("", "|____", self.root.left, false)
    io.flush()
    io.write("\n")
end


return {
    Tree = BinaryTree,
    Node = Node
}

