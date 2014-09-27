include("TryParse.jl")

type RMC
    time::Float64
    status::Char
    latitude::Float64
    longitude::Float64
    sog::Float64
    cog::Float64
    date::String
    magvar::Float64
    mode::Char

    function RMC()
        time = 0.0
        status = 'V'
        latitude = 0.0
        longitude = 0.0
        sog = 0.0
        cog = 0.0
        date = ""
        magvar = 0.0
        mode = 'N'
        new(time, status, latitude,
            longitude, sog, cog,
            date, magvar, mode)
    end # constructor RMC

end # type RMC

############################################################
# _parse_RMC
# ----------
# parse RMC messages and return populated type struct RMC
############################################################

function _parseRMC(items::Array{SubString{ASCIIString}})

end # function _parseRMC
