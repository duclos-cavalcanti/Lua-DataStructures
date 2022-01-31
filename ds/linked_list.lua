local Node = {}
Node.__index = Node

function Node:new(key, data)
    data = data or {}

    return setmetatable({
            next = nil,
            prev = nil,
            key = key,
            data = data,
        }, self)
end

local LinkedList = {}
LinkedList.__index = LinkedList

function LinkedList:new(opts)
    opts = opts or {}

    return setmetatable({
        size = 0,
        head = nil,
        tail = nil,
        }, self)
end

function LinkedList:empty()
    if self.tail == nil and self.head == nil then
        return true
    else
        return false
    end
end

function LinkedList:find(key, dir)
    if self:empty() then; return nil,nil; end
    local dir = dir or 1
    if dir > 0 then
        node = self.head
        while(true) do
            if node.key == key then
                return true,node
            end
            node = node.next
        end
    else
        node = self.tail
        while(true) do
            if node.key == key then
                return true,node
            end
            node = node.prev
        end
    end
end

function LinkedList:erase(key, dir)
    local dir = dir or 1
    local repl, node = self:find(key, dir)

    if repl == nil then
        return nil
    elseif repl == true then
        if node == self.tail then
            self:popBack()
        elseif node == self.head then
            self:popFront()
        else
            local prev = node.prev
            local nxt = node.next
            prev.next = nxt
            nxt.prev = prev
            self.size = self.size - 1
        end
        return true
    else
        return false
    end
end

function LinkedList:pushFront(node)
    node.next = self.head
    self.head = node

    if not self.tail then
      self.tail = head
    end

    self.size = self.size + 1
end

function LinkedList:pushBack(node)
    if self:empty() then
        self.head = node
        self.tail = node
        node.prev = nil
    else
        self.tail.next = node
        node.prev = self.tail
        self.tail = node
    end

    self.size = self.size + 1
end

-- [a, b, c]
-- insert d after b
-- [a, b, d, c]
function LinkedList:addAfter(node, new_node)
    new_node.next = node.next
    new_node.prev = node
    node.next = new_node
    new_node.next.prev = new_node

    if not self.tail then
        self.tail = new_node
    end

    self.size = self.size + 1
end

function LinkedList:addBefore(node, new_node)
    new_node.next = node
    new_node.prev = node.prev
    node.prev.next = new_node
    node.prev = new_node

    if not self.head then
        self.head = new_node
    end

    self.size = self.size + 1
end

function LinkedList:popFront()
    if self:empty() then
        return nil
    end

    local copy = self.head

    self.head = self.head.next
    if not self.head then
        self.tail = nil
    end
    
    self.size = self.size - 1
    return copy
end

function LinkedList:topFront()
    local elem = self.head
    return elem
end

function LinkedList:popBack()
    if self:empty() then
        return nil
    end

    if self.head == self.tail then
        self.tail = nil
        self.head = nil
    else
        self.tail = self.tail.prev
        self.tail.next = nil
        self.size = self.size - 1
    end
end

function LinkedList:topBack()
    local elem = self.tail
    return elem
end

function LinkedList:getSize()
    local size = self.size
    return size
end

function LinkedList:iter()
    local current_node = self.head

    return function()
        local node = current_node
        if not node then
            return nil
        end

        current_node = current_node.next
        return node
    end
end

-- traverse the linked list
function LinkedList:ipairs()
    local index = 0
    local current_node = self.head

    return function()
        local node = current_node
        if not node then
            return nil
        end

        current_node = current_node.next
        index = index + 1
        return index, node
    end
end

function LinkedList:printLL()
    str = ""
    i = 1; total_size = self.size

    if self:empty() then 
        print("Linked List: Empty")
        return nil 
    end

    for node in self:iter() do
        if i == 1 and i == total_size then
            str = "[ " .. node.key .. " ] "
        elseif i == 1 then
            str = "[ " .. node.key .. ", "
        elseif i == total_size then
            str = str .. node.key .. " ]"
        else
            str = str .. node.key .. ", "
        end
        i = i + 1
    end
    print(str.format("Linked List: %s", str))
end

return {
    List = LinkedList,
    Node = Node
}
