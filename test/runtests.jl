using NMEA
using Base.Test

nmeas = NMEAData()
f = open("testdata.txt", "r")
for line = readlines(f)
    mtype = parse_msg!(nmeas, line)
    if (mtype == "GGA")
        @test get(nmeas.last_GGA.valid)
    elseif (mtype == "RMC")
        @test get(nmeas.last_RMC.valid)
    elseif (mtype == "GSA")
        @test get(nmeas.last_GSA.valid)
    elseif (mtype == "GSV")
        @test get(nmeas.last_GSV.valid)
    elseif (mtype == "GBS")
        @test get(nmeas.last_GBS.valid)
    elseif (mtype == "VTG") 
        @test get(nmeas.last_VTG.valid)
    elseif (mtype == "GLL")
        @test get(nmeas.last_GLL.valid)
    elseif (mtype == "ZDA")
        @test get(nmeas.last_ZDA.valid)
    elseif (mtype == "DTM")
        @test get(nmeas.last_DTM.valid)
    else
        continue
    end
end


example = NMEA.parse(raw"$GPGGA,134740.000,5540.3248,N,01231.2992,E,1,09,0.9,20.2,M,41.5,M,,0000*61")

@test(example.latitude.value == 55.67208)
