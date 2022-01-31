local Node = {}
Node.__index = Node

function Node:new(key, data)
    data = data or {}

    return setmetatable({
            next = nil,
            key = key,
            data = data,
        }, self)
end

local Queue = {}
Queue.__index = Queue

function Queue:new(opts)
    return setmetatable({
        size = 0,
        tail = nil,
        }, self)
end

function Queue:empty()
    return self.tail == nil
end

function Queue:enqueue(key, data)
    local node = Node:new(key, data)

    if not self.tail then
        self.tail = node
    else
        local elem = self.tail
        while(true) do 
            if elem.next == nil then
                break
            end
            elem = elem.next
        end
        elem.next = node
    end

    self.size = self.size + 1
end

function Queue:dequeue()
    if self:empty() then
        return nil
    end
    
    local elem = self.tail
    self.tail = self.tail.next

    self.size = self.size - 1
    return elem
end

function Queue:getSize()
    local size = self.size
    return size
end

function Queue:iter()
    local current_node = self.tail

    return function()
        local node = current_node
        if not node then
            return nil
        end

        current_node = current_node.next
        return node
    end
end

function Queue:printQueue()
    str = ""
    i = 1; total_size = self.size

    if self:empty() then 
        print("Queue: Empty")
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
    print(str.format("Queue: %s", str))
end

return Queue
