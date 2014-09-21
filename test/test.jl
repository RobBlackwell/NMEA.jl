using NMEA

function main()
    nmeah = NMEASettings("nmeadata.txt")
    start!(nmeah)
end # function main()

main()
