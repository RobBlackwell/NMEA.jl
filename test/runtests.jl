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
