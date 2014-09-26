using NMEA

function main()
    nmea = NMEASettings()
    fh = open("nmeadata.txt", "r")
    for line = readlines(fh)
        mtype = parse_line!(nmea, line)
        println(mtype)
        if (mtype == "GGA")
            println(nmea.last_GGA)
        end
    end
end # function main()

main()
