Config = {}

---------------------------------
-- general settings
---------------------------------
Config.HandoverTime       = 10000
Config.Money              = 'cash' -- 'cash' or 'bloodmoney'
Config.EnableServerNotify = true
Config.DeliveryTime       = 60 -- in mins
Config.MaxSendWeight      = 10000

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn = true

---------------------------------
-- postal settings
---------------------------------
Config.PostalLocations = {

    {
        name = 'Valentine Postal',
        location = 'valpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-177.93, 646.70, 113.58, 61.61),
        coords = vector3(-177.93, 646.70, 113.58),
        blipCoords = vector3(-177.93, 646.70, 113.58),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Rhodes Postal',
        location = 'rhopostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(1229.63, -1279.09, 76.02, 329.83),
        coords = vector3(1229.63, -1279.09, 76.02),
        blipCoords = vector3(1229.63, -1279.09, 76.02),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Armadillo Postal',
        location = 'armpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-3729.33, -2614.54, -13.28, 185.05),
        coords = vector3(-3729.33, -2614.54, -13.28),
        blipCoords = vector3(-3729.33, -2614.54, -13.28),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Annesburg Postal',
        location = 'annpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(2934.38, 1301.49, 44.48, 82.31),
        coords = vector3(2934.38, 1301.49, 44.48),
        blipCoords = vector3(2934.38, 1301.49, 44.48),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Emerald Postal',
        location = 'emepostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(1523.22, 449.70, 90.36, 9.58),
        coords = vector3(1523.22, 449.70, 90.36),
        blipCoords = vector3(1523.22, 449.70, 90.36),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Wallace Postal',
        location = 'walpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-1297.68, 390.69, 95.58, 242.60),
        coords = vector3(-1297.68, 390.69, 95.58),
        blipCoords = vector3(-1297.68, 390.69, 95.58),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Strawberry Postal',
        location = 'strpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-1766.25, -380.29, 157.73, 149.28),
        coords = vector3(-1766.25, -380.29, 157.73),
        blipCoords = vector3(-1766.25, -380.29, 157.73),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Blackwater Postal',
        location = 'blkpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-876.99, -1341.78, 43.29, 171.80),
        coords = vector3(-876.99, -1341.78, 43.29),
        blipCoords = vector3(-876.99, -1341.78, 43.29),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Benedict Postal',
        location = 'denpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-5221.41, -3462.04, -21.28, 4.64),
        coords = vector3(-5221.41, -3462.04, -21.28),
        blipCoords = vector3(-5221.41, -3462.04, -21.28),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Riggs Postal',
        location = 'rigpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(-1093.77, -571.06, 82.40, 64.19),
        coords = vector3(-1093.77, -571.06, 82.40),
        blipCoords = vector3(-1093.77, -571.06, 82.40),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },
    {
        name = 'Saint Denis Postal',
        location = 'denpostal',
        npcmodel = `s_m_m_trainstationworker_01`,
        npccoords = vector4(2751.82, -1395.99, 46.20, 306.94),
        coords = vector3(2751.82, -1395.99, 46.20),
        blipCoords = vector3(2751.82, -1395.99, 46.20),
        blipSprite = 'blip_ambient_delivery',
        blipScale = 0.2,
        blipName = 'Postal Service',
        showblip = true
    },

}

---------------------------------
-- postal settings
---------------------------------
Config.PostalDestinations = {
    {
        label = 'Valentine Postal',
        destination = 'valpostal',
    },
    {
        label = 'Rhodes Postal',
        destination = 'rhopostal',
    },
    {
        label = 'Armadillo Postal',
        destination = 'armpostal',
    },
    {
        label = 'Annesburg Postal',
        destination = 'annpostal',
    },
    {
        label = 'Emerald Postal',
        destination = 'emepostal',
    },
    {
        label = 'Wallace Postal',
        destination = 'walpostal',
    },
    {
        label = 'Strawberry Postal',
        destination = 'strpostal',
    },
    {
        label = 'Blackwater Postal',
        destination = 'blkpostal',
    },
    {
        label = 'Benedict Postal',
        destination = 'benpostal',
    },
    {
        label = 'Riggs Postal',
        destination = 'rigpostal',
    },
    {
        label = 'Saint Denis Postal',
        destination = 'denpostal',
    },
}

---------------------------------
-- coords for distance
---------------------------------
Config.ValentineCoords = vector3(-177.93, 646.70, 113.58)
Config.RhodesCoords    = vector3(1229.63, -1279.09, 76.02)
Config.ArmadilloCoords = vector3(-3729.33, -2614.54, -13.28)
Config.AnnesburgCoords = vector3(2934.38, 1301.49, 44.48)
Config.EmeraldCoords = vector3(2934.38, 1301.49, 44.48)
Config.WallaceCoords = vector3(-1297.68, 390.69, 95.58)
Config.StrawberryCoords = vector3(-1766.25, -380.29, 157.73)
Config.BlackwaterCoords = vector3(-876.99, -1341.78, 43.29)
Config.BenedictCoords = vector3(-5221.41, -3462.04, -21.28)
Config.RiggsCoords = vector3(-1093.77, -571.06, 82.40)
Config.SaintDenisCoords = vector3(2751.82, -1395.99, 46.20)
