# NMEA
NMEA.jl is a package for parsing NMEA GPS protocol sentences

##Synopsis

###Types

####NMEAData
stores data for last parsed sentence of all NMEA message types

####GGA
Global Positioning System Fix Data

####GSA
GNSS DOP and Active Satellites

####ZDA
Time and Date

####GBS
RAIM GNSS Satellite Fault Detection

####GLL
Geographic Position - Latitude/Longitude

####GSV
GNSS Satellites in View

####RMC
Recommended Minimum Specific GNSS Data

####VTG
Course over Ground and Ground Speed

####DTM
Datum

###Methods

####parse_msg!
parses NMEA line/sentence and stores data in NMEAData; returns message type

###Example

The following example reads and parses a file of NMEA data line by line and
displays GGA and GSV data
```julia
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

# initialize/construct
nmea = NMEAData()

# read file line by line
fh = open("testdata.txt", "r")
for line = readlines(fh)
    # parse each line (sentence) in NMEA file and return message type
    mtype = parse_msg!(nmea, line)
    
    # display GGA and GSV data
    if (mtype == "GGA")
        display_GGA(nmea.last_GGA)
    elseif (mtype == "GSV")
        display_GSV(nmea.last_GSV)
    else
        continue
    end
end
```

Output
```
==================================================
=============== ESSENTIAL FIX DATA ===============
System: GPS
Time Of Day (UTC): 50632.0 secs
Latitude: 55.675155555555556
Longitude: 12.519430555555557
Fix Quality: GPS (SPS)
Tracked Satellites: 9
HDOP: 0.9
Altitude (MSL): 5.6 m
Geoidal Seperation: 41.5 m
==================================================

==================================================
============== SATELLITES IN VIEW ================
System: GPS
PRN: 11
Elevation: 60 degrees
Azimuth: 271 degrees
Signal To Noise: 27

System: GPS
PRN: 19
Elevation: 58 degrees
Azimuth: 179 degrees
Signal To Noise: 25

System: GPS
PRN: 22
Elevation: 45 degrees
Azimuth: 68 degrees
Signal To Noise: 30

...
```
