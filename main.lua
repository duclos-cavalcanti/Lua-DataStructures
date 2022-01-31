#!/usr/bin/lua

-- local dbg = require("debugger")
-- dbg()

local LinkedListLib = require("ds.linked_list")
local LinkedList = LinkedListLib.List
local Node = LinkedListLib.Node

local BinaryTreeLib = require("ds.tree")
local Tree = BinaryTreeLib.Tree
local TreeNode = BinaryTreeLib.Node

local Queue = require("ds.queue")
local Stack = require("ds.stack")

function treeExample()
    print("\n--- TREE")
    t = Tree:new()

    t:insert(TreeNode:new(10))
    t:insert(TreeNode:new(12))
    t:insert(TreeNode:new(5))
    t:insert(TreeNode:new(3))
    t:insert(TreeNode:new(8))
    t:insert(TreeNode:new(7))
    t:insert(TreeNode:new(6))

    t:printState()
    print(string.format("Height: %s", t:height()))

    print("inOrder")
    t:inOrderTraversal()
    print("preOrder")
    t:preOrderTraversal()
    print("postOrder")
    t:postOrderTraversal()
    print("postOrder")
    t:postOrderTraversal()
    print("level")
    t:levelTraversal()
end

function stackExample()
    print("\n--- STACK")
    s = Stack:new()

    s:push("apple")
    s:push("orange")
    s:push("bananas")

    s:printStack()

    pop = s:pop()
    s:printStack()
    print(pop.key)

    pop = s:pop()
    s:printStack()
    print(pop.key)

    pop = s:pop()
    s:printStack()
    print(pop.key)

    pop = s:pop()
    s:printStack()
    if pop ~= nil then
        print(pop.key)
    end
end

function queueExample()
    print("\n--- QUEUE")
    q = Queue:new()

    q:enqueue("apple")
    q:enqueue("orange")
    q:enqueue("bananas")

    q:printQueue()

    pop = q:dequeue()
    q:printQueue()
    print(pop.key)

    pop = q:dequeue()
    q:printQueue()
    print(pop.key)

    pop = q:dequeue()
    q:printQueue()
    print(pop.key)

    pop = q:dequeue()
    q:printQueue()
    if pop ~= nil then
        print(pop.key)
    end
end

function linkedListExample()
    print("\n--- DOUBLY LINKED LIST")
    l = LinkedList:new()

    og = Node:new("orange")
    ap = Node:new("apple")
    pi = Node:new("pineapple")
    ba = Node:new("bananas")
    ki = Node:new("ki")

    l:pushBack(og)
    l:pushBack(ap)
    l:pushBack(pi)

    l:printLL()

    l:addAfter(ap, ba)
    l:printLL()

    l:pushFront(ki)
    l:printLL()

    l:popBack()
    l:printLL()

    l:popFront()
    l:printLL()

    repl, n = l:find(ap.key)
    l:addBefore(n, ki)
    l:printLL()

    l:erase(ki.key)
    l:printLL()

    l:popBack()
    l:printLL()

    l:popBack()
    l:printLL()

    l:popBack()
    l:printLL()
end

function main()
    linkedListExample()
    queueExample()
    stackExample()
    treeExample()
end

main()
