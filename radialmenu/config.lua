Config = {}

Config.MenuItems = {
    [1] = {
        id = 'citizen',
        title = 'Interakce',
        icon = 'user',
        items = {
           {
                id = 'Spoutat',
                title = 'Spoutat (pouta)',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:handcuff',
                shouldClose = true
            }, 
            {
                id = 'Spoutat',
                title = 'Spoutat (zipties)',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:handcuffzipties',
                shouldClose = true
            }, {
                id = 'Odpoutat',
                title = 'Odpoutat',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:unhandcuff',
                shouldClose = true
            }, 
            {
                id = 'sOdpoutat',
                title = 'Dát do vozidla',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:PutCar',
                shouldClose = true
            },
            {
                id = 'dasdasOdpoutat',
                title = 'Vzít z vozidla',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:putout',
                shouldClose = true
            },
            {
                id = 'Oasdasddpoutat',
                title = 'Prohledat',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:search',
                shouldClose = true
            },
            {
                id = 'Vzít',
                title = 'Vzít',
                icon = 'user',
                type = 'client',
                event = 'radialmenu:grab',
                shouldClose = true
            }
        }
    },
    [2] = {
        id = 'general',
        title = 'Obecné',
        icon = 'list-alt',
        items = {
           {
                id = 'faktury',
                title = 'Faktury',
                icon = 'clipboard',
                type = 'client',
                event = 'okokBilling:radialmenu',
                shouldClose = true
            }, 
            {
                id = 'switjob',
                title = 'Prohodit zaměstnání',
                icon = 'clipboard',
                type = 'client',
                event = 'radial:switjob',
                shouldClose = true
            },
            {
                id = 'mireni',
                title = 'Animace míření',
                icon = 'crosshairs',
                items = {
                    {
                        id = 'zakladni',
                        title = 'Zakladní',
                        icon = 'male',
                        type = 'client',
                        event = 'radialmenu:mireni1',
                        shouldClose = true
                    }, {
                        id = 'gangster',
                        title = 'Gangster',
                        icon = 'glasses',
                        type = 'client',
                        event = 'radialmenu:mireni2',
                        shouldClose = true
                    }, {
                        id = 'kovboj',
                        title = 'Kovboj',
                        icon = 'hat-cowboy-side',
                        type = 'client',
                        event = 'radialmenu:mireni3',
                        shouldClose = true
                    }
                }
            },
            {
                id = 'cviceni',
                title = 'Cvičení',
                icon = 'running',
                type = 'client',
                event = 'radialmenu:client:skilmenu',
                shouldClose = true
            },
            {
                id = 'klice',
                title = 'Klíče',
                icon = 'key',
                type = 'client',
                event = 'gojan-vehiclelock:lock',
                shouldClose = true
            }
        }
    },

   --[[ [6] = {
        id = 'dogs',
        title = 'Pes',
        icon = 'dog',
        items = {
           {
                id = 'lehnout',
                title = 'Lehnout',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs1',
                shouldClose = true
            }, 
            {
                id = 'stekot',
                title = 'Štěkot',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs2',
                shouldClose = true
            },
            {
                id = 'sednout',
                title = 'Sednout',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs4',
                shouldClose = true
            },
            {
                id = 'podrbat',
                title = 'Podrbat se',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs5',
                shouldClose = true
            }, 
            {
                id = 'skakat',
                title = 'Skákat',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs6',
                shouldClose = true
            }, 
            {
                id = 'zautocit',
                title = 'Zaútočit',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs7',
                shouldClose = true
            },
            {
                id = 'plavat',
                title = 'Plavat',
                icon = 'dog',
                type = 'client',
                event = 'radialmenu:dogs8',
                shouldClose = true
            },
            {
                id = 'zrušit',
                title = 'Zrušit',
                icon = 'times',
                type = 'client',
                event = 'radialmenu:dogs3',
                shouldClose = true
            }
        }
    },]]

    [5] = {

                id = 'clothesmenu',
                title = 'Oblečení',
                icon = 'tshirt',
                items = {
                    {
                        id = 'Hair',
                        title = 'Vlasy',
                        icon = 'user',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Ear',
                        title = 'Ucho',
                        icon = 'deaf',
                        type = 'client',
                        event = 'radialmenu:ToggleProps',
                        shouldClose = true
                    }, {
                        id = 'Neck',
                        title = 'Krk',
                        icon = 'user-tie',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Top',
                        title = 'Vršek',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shirt',
                        title = 'Triko',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Pants',
                        title = 'Kalhoty',
                        icon = 'user',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shoes',
                        title = 'Boty',
                        icon = 'shoe-prints',
                        type = 'client',
                        event = 'radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'meer',
                        title = 'Doplňky',
                        icon = 'plus',
                        items = {
                            {
                                id = 'Hat',
                                title = 'Čepice',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Glasses',
                                title = 'Brýle',
                                icon = 'glasses',
                                type = 'client',
                                event = 'radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Visor',
                                title = 'Kšilt',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Mask',
                                title = 'Maska',
                                icon = 'theater-masks',
                                type = 'client',
                                event = 'radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Vest',
                                title = 'Vesta',
                                icon = 'vest',
                                type = 'client',
                                event = 'radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bag',
                                title = 'Taška',
                                icon = 'shopping-bag',
                                type = 'client',
                                event = 'radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bracelet',
                                title = 'Náramek',
                                icon = 'user',
                                type = 'client',
                                event = 'radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Watch',
                                title = 'Hodinky',
                                icon = 'stopwatch',
                                type = 'client',
                                event = 'radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Gloves',
                                title = 'Rukavice',
                                icon = 'mitten',
                                type = 'client',
                                event = 'radialmenu:ToggleClothing',
                                shouldClose = true
                            }
                        }
                    }
               
        }
    },


    [3] = {
        id = 'vehicle',
        title = 'Vozidlo',
        icon = 'car',
        items = {
            {
                id = 'vehicledoors',
                title = 'Dveře',
                icon = 'car-side',
                items = {
                    {
                        id = 'door0',
                        title = 'Dveře řidiče',
                        icon = 'car-side',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }, {
                        id = 'door4',
                        title = 'Kapota',
                        icon = 'car',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }, {
                        id = 'door1',
                        title = 'Dveře spolujezdce',
                        icon = 'car-side',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }, {
                        id = 'door3',
                        title = 'Pravé zadní',
                        icon = 'car-side',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }, {
                        id = 'door5',
                        title = 'Kufr',
                        icon = 'car',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }, {
                        id = 'door2',
                        title = 'Levé zadní',
                        icon = 'car-side',
                        type = 'client',
                        event = 'radialmenu:client:openDoor',
                        shouldClose = false
                    }
                }
            }, {
                id = 'vehicleextras',
                title = 'Extras',
                icon = 'plus',
                items = {
                    {
                        id = 'extra1',
                        title = 'Extra 1',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra2',
                        title = 'Extra 2',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra3',
                        title = 'Extra 3',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra4',
                        title = 'Extra 4',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra5',
                        title = 'Extra 5',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra6',
                        title = 'Extra 6',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra7',
                        title = 'Extra 7',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra8',
                        title = 'Extra 8',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra9',
                        title = 'Extra 9',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra10',
                        title = 'Extra 10',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra11',
                        title = 'Extra 11',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra12',
                        title = 'Extra 12',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra13',
                        title = 'Extra 13',
                        icon = 'box-open',
                        type = 'client',
                        event = 'radialmenu:client:setExtra',
                        shouldClose = false
                    }
                }
            }, 
            {
                id = 'obratit',
                title = 'Obrátit vozidlo',
                icon = 'user',
                type = 'client',
                event = 'FlipVehicle',
                shouldClose = true
            },

            {
                id = 'neony',
                title = 'Podsvícení',
                icon = 'car-side',
                type = 'client',
                event = 'radialmenu:neony',
                shouldClose = true
            },

            {
                id = 'motor',
                title = 'Motor',
                icon = 'car-side',
                type = 'client',
                event = 'radialmenu:motor',
                shouldClose = true
            },{
                id = 'vehicleseats',
                title = 'Sedadla',
                icon = 'chair',
                items = {
                    {
                        id = 'door0',
                        title = 'Řidič',
                        icon = 'chair',
                        type = 'client',
                        event = 'radialmenu:client:ChangeSeat',
                        shouldClose = false
                    }
                }
            }
        }
    },
    [4] = {
        id = 'jobinteractions',
        title = 'Zaměstnání',
        icon = 'briefcase',
        items = {}
    }
}

Config.JobInteractions = {

    ["police"] = {
        {
            id = 'jail',
            title = 'Vězení',
            icon = 'bell',
            type = 'client',
            event = 'fivem_jail:openJailMenu',
            shouldClose = true
        }
    },
    ["sheriff"] = {
        {
            id = 'jail',
            title = 'Vězení',
            icon = 'bell',
            type = 'client',
            event = 'fivem_jail:openJailMenu',
            shouldClose = true
        }
    }
   
}

Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes  
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans  
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- SUVs  
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes  
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle  
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports Classics  
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports  
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Super  
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles  
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road  
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial  
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility  
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans  
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles  
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats  
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters  
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes  
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service  
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency  
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military  
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial  
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains  
}

Config.ExtrasEnabled = true

Config.Commands = {
    ["top"] = {
        Func = function() ToggleClothing("Top") end,
        Sprite = "top",
        Desc = "Take your shirt off/on",
        Button = 1,
        Name = "Torso"
    },
    ["gloves"] = {
        Func = function() ToggleClothing("Gloves") end,
        Sprite = "gloves",
        Desc = "Take your gloves off/on",
        Button = 2,
        Name = "Gloves"
    },
    ["visor"] = {
        Func = function() ToggleProps("Visor") end,
        Sprite = "visor",
        Desc = "Toggle hat variation",
        Button = 3,
        Name = "Visor"
    },
    ["bag"] = {
        Func = function() ToggleClothing("Bag") end,
        Sprite = "bag",
        Desc = "Opens or closes your bag",
        Button = 8,
        Name = "Bag"
    },
    ["shoes"] = {
        Func = function() ToggleClothing("Shoes") end,
        Sprite = "shoes",
        Desc = "Take your shoes off/on",
        Button = 5,
        Name = "Shoes"
    },
    ["vest"] = {
        Func = function() ToggleClothing("Vest") end,
        Sprite = "vest",
        Desc = "Take your vest off/on",
        Button = 14,
        Name = "Vest"
    },
    ["hair"] = {
        Func = function() ToggleClothing("Hair") end,
        Sprite = "hair",
        Desc = "Put your hair up/down/in a bun/ponytail.",
        Button = 7,
        Name = "Hair"
    },
    ["hat"] = {
        Func = function() ToggleProps("Hat") end,
        Sprite = "hat",
        Desc = "Take your hat off/on",
        Button = 4,
        Name = "Hat"
    },
    ["glasses"] = {
        Func = function() ToggleProps("Glasses") end,
        Sprite = "glasses",
        Desc = "Take your glasses off/on",
        Button = 9,
        Name = "Glasses"
    },
    ["ear"] = {
        Func = function() ToggleProps("Ear") end,
        Sprite = "ear",
        Desc = "Take your ear accessory off/on",
        Button = 10,
        Name = "Ear"
    },
    ["neck"] = {
        Func = function() ToggleClothing("Neck") end,
        Sprite = "neck",
        Desc = "Take your neck accessory off/on",
        Button = 11,
        Name = "Neck"
    },
    ["watch"] = {
        Func = function() ToggleProps("Watch") end,
        Sprite = "watch",
        Desc = "Take your watch off/on",
        Button = 12,
        Name = "Watch",
        Rotation = 5.0
    },
    ["bracelet"] = {
        Func = function() ToggleProps("Bracelet") end,
        Sprite = "bracelet",
        Desc = "Take your bracelet off/on",
        Button = 13,
        Name = "Bracelet"
    },
    ["mask"] = {
        Func = function() ToggleClothing("Mask") end,
        Sprite = "mask",
        Desc = "Take your mask off/on",
        Button = 6,
        Name = "Mask"
    }
}

local Bags = {[40] = true, [41] = true, [44] = true, [45] = true}

Config.ExtraCommands = {
    ["pants"] = {
        Func = function() ToggleClothing("Pants", true) end,
        Sprite = "pants",
        Desc = "Take your pants off/on",
        Name = "Pants",
        OffsetX = -0.04,
        OffsetY = 0.0
    },
    ["shirt"] = {
        Func = function() ToggleClothing("Shirt", true) end,
        Sprite = "shirt",
        Desc = "Take your shirt off/on",
        Name = "shirt",
        OffsetX = 0.04,
        OffsetY = 0.0
    },
    ["reset"] = {
        Func = function()
            if not ResetClothing(true) then
                Notify('Nothing To Reset', 'error')
            end
        end,
        Sprite = "reset",
        Desc = "Revert everything back to normal",
        Name = "reset",
        OffsetX = 0.12,
        OffsetY = 0.2,
        Rotate = true
    },
    ["bagoff"] = {
        Func = function() ToggleClothing("Bagoff", true) end,
        Sprite = "bagoff",
        SpriteFunc = function()
            local Bag = GetPedDrawableVariation(PlayerPedId(), 5)
            local BagOff = LastEquipped["Bagoff"]
            if LastEquipped["Bagoff"] then
                if Bags[BagOff.Drawable] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            end
            if Bag ~= 0 then
                if Bags[Bag] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            else
                return false
            end
        end,
        Desc = "Take your bag off/on",
        Name = "bagoff",
        OffsetX = -0.12,
        OffsetY = 0.2
    }
}