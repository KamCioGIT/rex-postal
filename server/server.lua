local RSGCore = exports['rsg-core']:GetCoreObject()

---------------------------------------------
-- get all data
---------------------------------------------
RSGCore.Functions.CreateCallback('rex-postal:server:alldata', function(source, cb, id)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    MySQL.query('SELECT * FROM rex_postal_service WHERE id = ?', { id }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- get players address book
---------------------------------------------
RSGCore.Functions.CreateCallback('rex-postal:server:getaddressbook', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    MySQL.query('SELECT * FROM address_book WHERE owner = ? ORDER BY name ASC', { Player.PlayerData.citizenid }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- get sent packages
---------------------------------------------
RSGCore.Functions.CreateCallback('rex-postal:server:checksentpackage', function(source, cb, location)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    MySQL.query('SELECT * FROM rex_postal_service WHERE sentfrom = ? AND depart = ?', { Player.PlayerData.citizenid, location }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- get received packages
---------------------------------------------
RSGCore.Functions.CreateCallback('rex-postal:server:checkreceivedpackage', function(source, cb, location)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    MySQL.query('SELECT * FROM rex_postal_service WHERE sentto = ? AND arrive = ?', { Player.PlayerData.citizenid, location }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- send package
---------------------------------------------
RegisterNetEvent('rex-postal:server:sendpackage', function(depart, arrive_label, item, sentto, arrive, amount, payment, note, totalcost)

    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    MySQL.Async.execute('INSERT INTO rex_postal_service (depart, arrive, arrive_label, sentfrom, sentto, item, amount, payment, note, deliverytime, status) VALUES (@depart, @arrive, @arrive_label, @sentfrom, @sentto, @item, @amount, @payment, @note, @deliverytime, @status)',
    {
        ['@depart'] = depart,
        ['@arrive'] = arrive,
        ['@arrive_label'] = arrive_label,
        ['@sentfrom'] = citizenid,
        ['@sentto'] = sentto,
        ['@item'] = item,
        ['@amount'] = amount,
        ['@payment'] = payment,
        ['@note'] = note,
        ['@deliverytime'] = Config.DeliveryTime,
        ['@status'] = 'pending'
    })

    Player.Functions.RemoveMoney(Config.Money, totalcost)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove')
    TriggerClientEvent('ox_lib:notify', src, {title = 'Thank you', description = 'your package is on its way', type = 'inform', duration = 5000 })

end)

---------------------------------------------
-- collect package and make payment
---------------------------------------------
RegisterNetEvent('rex-postal:server:makepayment', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local money = Player.PlayerData.money['cash']

    MySQL.query('SELECT * FROM rex_postal_service WHERE id = ?', { data.id }, function(data)
        local id = data[1].id
        local item = data[1].item
        local amount = data[1].amount
        local payment = data[1].payment
        local paymentmade = data[1].paymentmade

        -- check if player has already collected
        if paymentmade == 1 then
            TriggerClientEvent('ox_lib:notify', src, {title = 'Already Collected!', type = 'inform', duration = 5000 })
            return
        end

        -- check player has enough cash
        if money < payment then
            TriggerClientEvent('ox_lib:notify', src, {title = 'Cash Required $'..payment, type = 'inform', duration = 5000 })
            return
        end
        
        Player.Functions.RemoveMoney('cash', payment)
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
        MySQL.update('UPDATE rex_postal_service SET paymentmade = ? WHERE id = ?',{ 1, id })
    end)

end)

---------------------------------------------
-- collect payment
---------------------------------------------
RegisterNetEvent('rex-postal:server:collectpayment', function(id, payment)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', payment)
    MySQL.Async.execute('DELETE FROM rex_postal_service WHERE id = ?', { id })
end)

---------------------------------------------
-- delivery system
---------------------------------------------
lib.cron.new('*/1 * * * *', function ()

    local result = MySQL.query.await('SELECT * FROM rex_postal_service')

    if not result then goto continue end
    
    for i = 1, #result do

        local id = result[i].id
        local deliverytime = result[i].deliverytime
        local paymentmade = result[i].paymentmade
        local sentto = result[i].sentto
        local sentfrom = result[i].sentfrom
        local note = result[i].note
        local arrivemsgsent = result[i].arrivemsgsent
        local paymentmsgsent = result[i].paymentmsgsent
        local arrive_label = result[i].arrive_label

        -- delivery counter and status change
        if deliverytime > 0 then
            MySQL.update('UPDATE rex_postal_service SET deliverytime = ? WHERE id = ?', { deliverytime-1, id })
            MySQL.update('UPDATE rex_postal_service SET status = ? WHERE id = ?', { 'Shipped', id })
        end
        -- when delivery time is zero set to delivered and send message
        if deliverytime == 0 and arrivemsgsent == 0 then
            MySQL.update('UPDATE rex_postal_service SET status = ? WHERE id = ?', { 'Delivered', id })
            MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                sentto,
                sentto,
                'NO-REPLY',
                arrive_label..' Postal Service',
                'You have a parcel ready for collection!',
                os.date("%x"),
                'Parcel received from '..sentfrom..' with the following message : '..note,
            })
            MySQL.update('UPDATE rex_postal_service SET arrivemsgsent = ? WHERE id = ?', { 1, id })
        end
        -- when delivery has been paid for then
        if paymentmade == 1 and paymentmsgsent == 0 then
            MySQL.update('UPDATE rex_postal_service SET status = ? WHERE id = ?', { 'Payment Made', id })
            MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                sentfrom,
                sentfrom,
                'NO-REPLY',
                'Postal Service',
                'A payment for a parcel has been made!',
                os.date("%x"),
                'Payment received from '..sentto..' for the parcel with the following tracking ID : '..id,
            })
            MySQL.update('UPDATE rex_postal_service SET paymentmsgsent = ? WHERE id = ?', { 1, id })
        end

    end

    ::continue::

    if Config.EnableServerNotify then
        print('postal delivery system updated')
    end

end)