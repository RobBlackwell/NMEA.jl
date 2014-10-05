using NMEA
using Base.Test

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
    else
        continue
    end
end
