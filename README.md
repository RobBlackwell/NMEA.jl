##NMEA [![Build Status](https://travis-ci.org/r2dbg/NMEA.jl.svg?branch=master)](https://travis-ci.org/r2dbg/NMEA.jl)

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
NMEA

function display_GGA(m::GGA)
    println("==================================================")
    println("=============== ESSENTIAL FIX DATA ===============")
    println("System: $(get(m.system))")
    println("Time Of Day (UTC): $(get(m.time)) secs")
    println("Latitude: $(get(m.latitude))")
    println("Longitude: $(get(m.longitude))")
    println("Fix Quality: $(get(m.fix_quality))")
    println("Tracked Satellites: $(get(m.num_sats))")
    println("HDOP: $(get(m.HDOP))")
    println("Altitude (MSL): $(get(m.altitude)) m")
    println("Geoidal Seperation: $(get(m.geoidal_seperation)) m")
    println("==================================================\n")
end # function display_GGA

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
...
```
