############################################################
# GLL
# ---
# GLL message type - Geographic Position –
# Latitude/Longitude
############################################################

type GLL
    system::String
    latitude::Float64
    longitude::Float64
    time::Float64
    status::Bool
    mode::Char

    function GLL(sys::String)
        system = sys
        latitude = 0.0
        longitude = 0.0
        time = 0.0
        status = false
        mode = 'N'
        new(system, latitude, longitude,
            time, status, mode)
    end # constructor GLL

end # type GLL

############################################################
# parse_GLL
# ---------
# parse GLL message
############################################################

function parse_GLL(items::Array{SubString{ASCIIString}}, system::String)
    GLL_data = GLL(system)
    GLL_data.latitude = dms_to_dd(items[2], items[3])
    GLL_data.longitude = dms_to_dd(items[4], items[5])
    GLL_data.time = hms_to_secs(items[6])
    
    if (items[7] == "A")
        GLL_data.status = true
    else
        GLL_data.status = false
    end

    if (items[8] != "")
        GLL_data.mode = items[8][1]
    end

    GLL_data
end # function parse_GLL
