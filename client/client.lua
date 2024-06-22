local RSGCore = exports['rsg-core']:GetCoreObject()
local totalcost = 0

-----------------------------------------------------------------
-- postal blips
-----------------------------------------------------------------
CreateThread(function()
    for _,v in pairs(Config.PostalLocations) do
        if v.showblip == true then
            local PostalBlip = BlipAddForCoords(1664425300, v.blipCoords)
            SetBlipSprite(PostalBlip, joaat(v.blipSprite), true)
            SetBlipScale(PostalBlip, v.blipScale)
            SetBlipName(PostalBlip, v.blipName)
        end
    end
end)

---------------------------------------------
-- postal main menu
---------------------------------------------
RegisterNetEvent('rex-postal:client:openpostal', function(location, coords)
    lib.registerContext({
        id = 'postal_menu',
        title = 'Postal Service',
        options = {
            {
                title = 'Send a Package',
                icon = 'fa-solid fa-box',
                event = 'rex-postal:client:sendpackage',
                args = {
                    location = location,
                    coords = coords
                },
                arrow = true
            },
            {
                title = 'Check Sent Packages',
                icon = 'fa-solid fa-box',
                event = 'rex-postal:client:checksentpackages',
                args = {
                    location = location
                },
                arrow = true
            },
            {
                title = 'Check Received Packages',
                icon = 'fa-solid fa-box',
                event = 'rex-postal:client:checkreceivedpackages',
                args = {
                    location = location
                },
                arrow = true
            }
        }
    })
    lib.showContext('postal_menu')
end)

-------------------------------------------------------------------
-- sort table function
-------------------------------------------------------------------
local function compareNames(a, b)
    return a.value < b.value
end

---------------------------------------------
-- send a package
---------------------------------------------
RegisterNetEvent('rex-postal:client:sendpackage', function(data)

    RSGCore.Functions.TriggerCallback('rex-postal:server:getaddressbook', function(addressbook)

        if addressbook == nil then
            lib.notify({ title = 'No one in your address book', type = 'error', duration = 7000 })
            return
        end

        local items = {}
        local address = {}
        local destination = {}

        -- get items to send
        for k,v in pairs(RSGCore.Functions.GetPlayerData().items) do
            local content = { value = v.name, label = v.label..' ('..v.amount..')' }
            items[#items + 1] = content
        end

        -- get address to send to
        for i = 1, #addressbook do
            local citizenid = addressbook[i].citizenid
            local fullname = addressbook[i].name
            local content = {value = citizenid, label = fullname..' ('..citizenid..')'}
            address[#address + 1] = content
        end

        -- get detstination
        for k,v in pairs(Config.PostalDestinations) do
            local content = { value = v.destination, label = v.label }
            destination[#destination + 1] = content
        end

        table.sort(items, compareNames)
        table.sort(address, compareNames)
        table.sort(destination, compareNames)

        local item = lib.inputDialog('Send Package', {
            { 
                type = 'select',
                options = items,
                label = 'Item to Send',
                required = true
            },
            { 
                type = 'select',
                options = address,
                label = 'Sent To',
                required = true
            },
            { 
                type = 'select',
                options = destination,
                label = 'Destination',
                required = true
            },
            { 
                type = 'input',
                label = 'Amount to Send',
                placeholder = '0',
                icon = 'fa-solid fa-hashtag',
                required = true
            },
            { 
                type = 'input',
                label = 'Payment on Delivery',
                placeholder = '0.00',
                icon = 'fa-solid fa-dollar-sign',
                required = true
            },
            { 
                type = 'textarea', 
                label = 'Add a note', 
                required = true, 
                autosize = true 
            },
        })

        if not item then 
            return 
        end

        local hasItem = RSGCore.Functions.HasItem(item[1], item[2])
        local itemweight = RSGCore.Shared.Items[item[1]].weight
        local totalweight = (RSGCore.Shared.Items[item[1]].weight * item[4])

        if totalweight > Config.MaxSendWeight then
            lib.notify({ title = 'Weight Exceeded!', description = 'this package is too heavy to send', type = 'error', duration = 7000 })
            return
        end

        if hasItem then
            
            if data.location == item[3] then
                lib.notify({ title = 'Same Location!', description = 'you can\'t send to this location', type = 'error', duration = 7000 })
                return
            end
            
            if item[3] == 'valpostal' then
                local distance = #(data.coords - Config.ValentineCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Valentine'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end
            
            if item[3] == 'rhopostal' then
                local distance = #(data.coords - Config.RhodesCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Rhodes'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end
            
            if item[3] == 'armpostal' then
                local distance = #(data.coords - Config.ArmadilloCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Armadillo'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'annpostal' then
                local distance = #(data.coords - Config.AnnesburgCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Annesburg'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'emepostal' then
                local distance = #(data.coords - Config.EmeraldCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Emerald Ranch'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'walpostal' then
                local distance = #(data.coords - Config.WallaceCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Wallace'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'strpostal' then
                local distance = #(data.coords - Config.StrawberryCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Strawberry'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'blkpostal' then
                local distance = #(data.coords - Config.BlackwaterCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Blackwater'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'benpostal' then
                local distance = #(data.coords - Config.BenedictCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Benedict'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'rigpostal' then
                local distance = #(data.coords - Config.RiggsCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Riggs'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end

            if item[3] == 'denpostal' then
                local distance = #(data.coords - Config.SaintDenisCoords)
                local totalcost = math.floor((distance + totalweight) / 1000)
                local postalname = 'Saint Denis'
                TriggerEvent('rex-postal:client:checksendpackage', data.location, postalname, item[1], item[2], item[3], item[4], item[5], item[6], totalcost)
            end
        
        else
            lib.notify({ title = 'You don\'t have that many items', type = 'error', duration = 7000 })
        end
        
    end)
end)

---------------------------------------------
-- check with player before sending
---------------------------------------------
RegisterNetEvent('rex-postal:client:checksendpackage', function(depart, postalname, item, sentto, arrive, amount, payment, note, totalcost)

    -- confirm send package
    local input = lib.inputDialog('Package Trasit Cost', {
        {
            label = 'Package transit cost : $'..totalcost,
            description = 'are you sure you want to send this?',
            type = 'select',
            options = {
                { value = 'yes', label = 'Yes' },
                { value = 'no',  label = 'No' }
            },
            required = true
        },
    })
        
    if not input then
        return
    end
    
    if input[1] == 'no' then
        return
    end

    -- progress bar
    LocalPlayer.state:set("inv_busy", true, true)
    lib.progressBar({
        duration = (Config.HandoverTime),
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disableControl = true,
        disable = {
            move = true,
            mouse = true,
        },
        label = 'Handing over package..',
    })
    LocalPlayer.state:set("inv_busy", false, true)

    TriggerServerEvent('rex-postal:server:sendpackage', depart, postalname, item, sentto, arrive, amount, payment, note, totalcost)
end)

---------------------------------------------
-- check sent packages
---------------------------------------------
RegisterNetEvent('rex-postal:client:checksentpackages', function(data)

    RSGCore.Functions.TriggerCallback('rex-postal:server:checksentpackage', function(result)

        if result == nil then
            lib.notify({ title = 'No Shipments Found!', type = 'error', duration = 7000 })
            return
        end

        local paymentmade = result[1].paymentmade
        
        if paymentmade == 0 then
            lib.registerContext({
                id = 'postal_no_sent_package',
                title = 'Sent Packages',
                menu = 'postal_menu',
                options = {
                    {
                        title = 'no actions available at this time',
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('postal_no_sent_package')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = 'Tracking ID:'..result[k].id,
                    description = result[k].amount..' '..RSGCore.Shared.Items[result[k].item].label..' to '..result[k].sentto..' ('..result[k].status..')',
                    icon = 'fa-solid fa-file-invoice-dollar',
                    iconColor = '#20C997',
                    event = 'rex-postal:client:collectpayment',
                    args = {
                        id = result[k].id,
                        payment = result[k].payment
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'postal_sent_package',
                title = 'Sent Packages',
                menu = 'postal_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('postal_sent_package')
        end
    end, data.location)

end)

---------------------------------------------
-- check received packages
---------------------------------------------
RegisterNetEvent('rex-postal:client:checkreceivedpackages', function(data)

    RSGCore.Functions.TriggerCallback('rex-postal:server:checkreceivedpackage', function(result)
    
        if result == nil then
            lib.notify({ title = 'No Parcels Found', type = 'error', duration = 7000 })
            return
        end
        
        local paymentmade = result[1].paymentmade
        local status = result[1].status

        if status == 'pending' then SetIconColor = '#FF6B6B' end
        if status == 'Shipped' then SetIconColor = '#FCC419' end
        if status == 'Delivered' then SetIconColor = '#51CF66' end
        if status == 'Payment Made' then SetIconColor = '#20C997' end
        
        if paymentmade == 1 then 
            lib.registerContext({
                id = 'postal_no_rec_package',
                title = 'Your Packages',
                menu = 'postal_menu',
                options = {
                    {
                        title = 'no packages found',
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('postal_no_rec_package')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = 'Tracking ID:'..result[k].id,
                    description = result[k].amount..' '..RSGCore.Shared.Items[result[k].item].label..' from '..result[k].sentfrom..' arrives in '..result[k].deliverytime..' mins',
                    icon = 'fa-solid fa-box',
                    iconColor = SetIconColor,
                    event = 'rex-postal:client:collectpackage',
                    args = {
                        id = result[k].id,
                        status = result[k].status,
                        sentfrom = result[k].sentfrom,
                        item = result[k].item,
                        amount = result[k].amount,
                        note = result[k].note,
                        payment = result[k].payment
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'postal_rec_package',
                title = 'Your Packages',
                menu = 'postal_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('postal_rec_package')
        end
    end, data.location)

end)

---------------------------------------------
-- collect package
---------------------------------------------
RegisterNetEvent('rex-postal:client:collectpackage', function(data)
 
    if data.status ~= 'Delivered' then
        lib.notify({ title = 'Parcel Not Ready', description = 'you parcel is not ready for collection', type = 'error', duration = 7000 })
    end

    lib.registerContext(
        {
            id = 'collection_menu',
            title = 'Parcel Collection',
            position = 'top-right',
            menu = 'postal_rec_package',
            options = {
                {
                    title = 'Tracking ID: '..data.id,
                },
                {
                    title = 'Item: '..data.item,
                },
                {
                    title = 'Amount: '..data.amount,
                },
                {
                    title = 'From: '..data.sentfrom,
                },
                {
                    title = 'Note: '..data.note,
                },
                {
                    title = 'Make Payemnt of $'..data.payment,
                    icon = 'fa-solid fa-file-invoice-dollar',
                    serverEvent = 'rex-postal:server:makepayment',
                    args = {
                        id = data.id
                    },
                    arrow = true
                },
            }
        }
    )
    lib.showContext('collection_menu')

end)

---------------------------------------------
-- sender collect payment
---------------------------------------------
RegisterNetEvent('rex-postal:client:collectpayment', function(data)
    -- progress bar
    LocalPlayer.state:set("inv_busy", true, true)
    lib.progressBar({
        duration = (Config.HandoverTime),
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disableControl = true,
        disable = {
            move = true,
            mouse = true,
        },
        label = 'Collecting Payment..',
    })
    LocalPlayer.state:set("inv_busy", false, true)

    TriggerServerEvent('rex-postal:server:collectpayment', data.id, data.payment)
end)
