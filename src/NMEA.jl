module NMEA

# for common conversion functions
include("Conversions.jl")

# for parsing data
include("TryParse.jl")

# main types and functions
export NMEASettings,
       parse_line!

# GGA messages
include("GGA.jl")
export GGA

# RMC messages
include("RMC.jl")
export RMC

# GSA messages
include("GSA.jl")
export GSA

# GSV messages
include("GSV.jl")
export GSV,
       SVData

# GBS messages
include("GBS.jl")
export GBS

# VTG messages
include("VTG.jl")
export VTG

# GLL messages
include("GLL.jl")
export GLL

# ZDA messages
include("ZDA.jl")
export ZDA

############################################################
# NMEASettings
# ------------
# IO handler settings
############################################################

type NMEASettings
    last_GGA::GGA
    last_RMC::RMC
    last_GSA::GSA
    last_GSV::GSV
    last_GBS::GBS
    last_VTG::VTG
    last_GLL::GLL
    last_ZDA::ZDA

    function NMEASettings()
        last_GGA = GGA("UNKNOWN")
        last_RMC = RMC("UNKNOWN")
        last_GSA = GSA("UNKNOWN")
        last_GSV = GSV("UNKNOWN")
        last_GBS = GBS("UNKNOWN")
        last_VTG = VTG("UNKNOWN")
        last_GLL = GLL("UNKNOWN")
        last_ZDA = ZDA("UNKNOWN")
        new(last_GGA, last_RMC, last_GSA,
            last_GSV, last_GBS, last_VTG,
            last_GLL, last_ZDA)
    end # constructor NMEASettings

end # type NMEASettings

############################################################
# start!
# ------
# open serial port and start reading NMEASettings messages
############################################################

function parse_line!(s::NMEASettings, line::String)
    message = split(line, '*')[1]
    items = split(message, ',')

    # get system name
    system = get_system(items[1])

    mtype = ""
    if (ismatch(r"DTM$", items[1]))
        mtype = "DTM"
   
    elseif (ismatch(r"GBS$", items[1]))
        s.last_GBS = parse_GBS(items, system)
        mtype = "GBS"
    
    elseif (ismatch(r"GGA$", items[1]))
        s.last_GGA = parse_GGA(items, system)
        mtype = "GGA"
    
    elseif (ismatch(r"GLL$", items[1]))
        s.last_GLL = parse_GLL(items, system)
        mtype = "GLL"
    
    elseif (ismatch(r"GNS$", items[1]))
        mtype = "GNS"
    
    elseif (ismatch(r"GSA$", items[1]))
        s.last_GSA = parse_GSA(items, system)
        mtype = "GSA"
    
    elseif (ismatch(r"GSV$", items[1]))
        s.last_GSV = parse_GSV(items, system)
        mtype = "GSV"
    
    elseif (ismatch(r"RMC$", items[1]))
        s.last_RMC = parse_RMC(items, system)
        mtype = "RMC"
    
    elseif (ismatch(r"VTG$", items[1]))
        s.last_VTG = parse_VTG(items, system)
        mtype = "VTG"
    
    elseif (ismatch(r"ZDA$", items[1]))
        s.last_ZDA = parse_ZDA(items, system)
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
# get_system
# -----------
# determines system from message type string
############################################################

function get_system(mtype::SubString{ASCIIString})
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
end # function get_system

end # module NMEA
