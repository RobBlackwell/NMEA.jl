using NMEA

function main()
    nmea = NMEASettings()
    fh = open("nmeadata2.txt", "r")
    for line = readlines(fh)
        mtype = parse_line!(nmea, line)
        if (mtype == "GGA")
            println(nmea.last_GGA)
        elseif (mtype == "RMC")
            println(nmea.last_RMC)
        elseif (mtype == "GSA")
            println(nmea.last_GSA)
        elseif (mtype == "GSV")
            println(nmea.last_GSV)
        elseif (mtype == "GBS")
            println(nmea.last_GBS)
        elseif (mtype == "VTG")
            println(nmea.last_VTG)
        elseif (mtype == "GLL")
            println(nmea.last_GLL)
        elseif (mtype == "ZDA")
            println(nmea.last_ZDA)
        else
            continue
        end
    end
end # function main()

main()
