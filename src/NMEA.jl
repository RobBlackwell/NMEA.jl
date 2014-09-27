module NMEA

# device/file handler code
export NMEASettings,
       parse_line!

# GGA messages
include("GGA.jl")
export GGA

############################################################
# NMEASettings
# ----------
# IO handler settings
############################################################

type NMEASettings
    last_GGA::GGA
    
    function NMEASettings()
        last_GGA = GGA()
        new(last_GGA)
    end # constructor NMEASettings

end # type NMEASettings

############################################################
# start!
# ------
# open serial port and start reading NMEA messages
############################################################

function parse_line!(s::NMEASettings, line::String)
    message, checksum = split(line, '*')
    items = split(message, ',')

    # get system name
    system = _get_system(items[1])

    mtype = ""
    if (ismatch(r"DTM$", items[1]))
        mtype = "DTM"
    elseif (ismatch(r"GBS$", items[1]))
        mtype = "GBS"
    elseif (ismatch(r"GGA$", items[1]))
        s.last_GGA = _parseGGA(items, system)
        mtype = "GGA"
    elseif (ismatch(r"GLL$", items[1]))
        mtype = "GLL"
    elseif (ismatch(r"GNS$", items[1]))
        mtype = "GNS"
    elseif (ismatch(r"GSA$", items[1]))
        mtype = "GSA"
    elseif (ismatch(r"GSV$", items[1]))
        mtype = "GSV"
    elseif (ismatch(r"RMC$", items[1]))
        mtype = "RMC"
    elseif (ismatch(r"VTG$", items[1]))
        mtype = "VTG"
    elseif (ismatch(r"ZDA$", items[1]))
        mtype = "ZDA"
    elseif (ismatch (r"Q$", items[1]))
        mtype = "Q"
    else
        mtype = "PROPRIETARY"
    end

    mtype
end # function start!

############################################################
################### PRIVATE METHODS ########################
############################################################

############################################################
# _get_system
# -----------
# determines system from message type string
############################################################

function _get_system(mtype::SubString{ASCIIString})
    system = ""

    # GPS
    if (ismatch(r"^\$GP", mtype))
        system = "GPS"

    # GLONASS
    elseif (ismatch(r"^\$GL", mtype))
        system = "GLONASS"

    # GALILEO
    elseif (ismatch(r"^\$GA", mtype))
        system = "GALILEO"

    # Combined
    elseif (ismatch(r"^\$GN", mtype))
        system = "COMBINED"

    # Proprietary (non-NMEA standard) message
    else
        system = "UNKNOWN"
    end

    system
end # function _get_system

end # module
