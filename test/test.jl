using NMEA

function display_GGA(m::GGA)
    println("==================================================")
    println("=============== ESSENTIAL FIX DATA ===============")
    println("System: $(m.system)")
    println("Time Of Day (UTC): $(m.time) secs")
    println("Latitude: $(m.latitude)")
    println("Longitude: $(m.longitude)")
    println("Fix Quality: $(m.fix_quality)")
    println("Tracked Satellites: $(m.num_sats)")
    println("HDOP: $(m.HDOP)")
    println("Altitude (MSL): $(m.altitude) m")
    println("Geoidal Seperation: $(m.geoidal_seperation) m")
    println("==================================================\n")
end # function display_GGA

function display_GSV(m::GSV)
    if (m.msg_num == 1)
        println("==================================================")
        println("============== SATELLITES IN VIEW ================")
    end

    for sat = m.SV_data
        println("System: $(m.system)")
        println("PRN: $(sat.PRN)")
        println("Elevation: $(sat.elevation) degrees")
        println("Azimuth: $(sat.azimuth) degrees")
        println("Signal To Noise: $(sat.SNR)\n")
    end

    if (m.msg_num == m.msg_total)
        println("==================================================\n")
    end
end # function display GSV

function main()
    nmea = NMEASettings()
    fh = open("nmeadata2.txt", "r")
    for line = readlines(fh)
        mtype = parse_line!(nmea, line)
        if (mtype == "GGA")
            display_GGA(nmea.last_GGA)
        elseif (mtype == "GSV")
            display_GSV(nmea.last_GSV)
        else
            continue
        end
    end
end # function main()

main()
