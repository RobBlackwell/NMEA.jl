using NMEA

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

nmeas = NMEAData()
f = open("testdata.txt", "r")
for line = readlines(f)
    mtype = parse_msg!(nmeas, line)
    if (mtype == "GGA")
        @test nmeas.last_GGA.valid
    elseif (mtype == "RMC")
        @test nmeas.last_RMC.valid
    elseif (mtype == "GSA")
        @test nmeas.last_GSA.valid
    elseif (mtype == "GSV")
        @test nmeas.last_GSV.valid
    elseif (mtype == "GBS")
        @test nmeas.last_GBS.valid
    elseif (mtype == "VTG")
        @test nmeas.last_VTG.valid
    elseif (mtype == "GLL")
        @test nmeas.last_GLL.valid
    elseif (mtype == "ZDA")
        @test nmeas.last_ZDA.valid
    elseif (mtype == "DTM")
        @test nmeas.last_DTM.valid
    elseif (mtype == "PASHR")
        @test nmeas.last_PASHR.valid
    else
        continue
    end
end


example = NMEA.parse(raw"$GPGGA,134740.000,5540.3248,N,01231.2992,E,1,09,0.9,20.2,M,41.5,M,,0000*61")
@test(example.latitude == 55.67208)

example = NMEA.parse("\$GNGGA,033158.447,4532.5164,N,12258.1463,W,1,9,1.25,161.5,M,-19.6,M,,*7E")
@test(example.longitude == -122.969105)
