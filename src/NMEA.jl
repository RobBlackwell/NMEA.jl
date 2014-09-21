using Arduino

module NMEA

export NMEASettings,
       start!

############################################################
# NMEASettings
# ----------
# file handler settings
############################################################

type NMEASettings
    _fh::IO

    function NMEASettings(filename::ASCIIString)
        _fh = open(filename, "r")
        new(_fh)
    end # constructor NMEASettings
end # type NMEASettings

############################################################
# start!
# ------
# open serial port and start reading NMEA messages
############################################################

function start!(s::NMEASettings)
    for line = readlines(s._fh)
        println(rstrip(line))
    end
end # function start!

end # module
