include("TryParse.jl")

############################################################
# RMC
# ---
# RMC message type - Recommended Minimum Specific GNSS Data
############################################################

type RMC
    system::String
    time::Float64
    status::Bool
    latitude::Float64
    longitude::Float64
    sog::Float64
    cog::Float64
    date::String
    magvar::Float64
    mode::Char

    function RMC(sys::String)
        system = sys
        time = 0.0
        status = 'V'
        latitude = 0.0
        longitude = 0.0
        sog = 0.0
        cog = 0.0
        date = ""
        magvar = 0.0
        mode = 'N'
        new(system, time, status,
            latitude, longitude, sog,
            cog, date, magvar,
            mode)
    end # constructor RMC

end # type RMC

############################################################
# _parse_RMC
# ----------
# parse RMC messages and return populated type struct RMC
############################################################

function parse_RMC(items::Array{SubString{ASCIIString}}, system::String)
    rmc_data = RMC(system)
    rmc_data.time = _hms_to_secs(items[2])

    if (items[3] == "A")
        rmc_data.status = true
    else
        rmc_data.status = false
    end

    rmc_data.latitude = _dms_to_dd(items[4], items[5])
    rmc_data.longitude = _dms_to_dd(items[6], items[7])
    rmc_data.sog = tryfloat(items[8])
    rmc_data.cog = tryfloat(items[9])
    rmc_data.date = string(items[10][3:4], '/', items[10][1:2], '/', items[10][5:6])

    if (items[12] == "W" || items[12] == "S")
        println(items[11])
        rmc_data.magvar = tryfloat(items[11]) * -1
    else
        rmc_data.magvar = tryfloat(items[11])
    end

    rmc_data.mode = items[13][1]

    rmc_data
end # function parse_RMC
