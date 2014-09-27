using NMEA

function main()
    nmea = NMEASettings()
    fh = open("nmeadata.txt", "r")
    for line = readlines(fh)
        mtype = parse_line!(nmea, line)
        if (mtype == "GGA")
            println(nmea.last_GGA)
        elseif (mtype == "RMC")
            println(nmea.last_RMC)
        else
            continue
        end
    end
end # function main()

main()
