############################################################
# VTG
# ---
# VTG message type - Course over Ground & Ground Speed
############################################################

type VTG
    CoG_true::Float64
    CoG_mag::Float64
    SoG_knots::Float64
    SoG_kmhr::Float64
    mode::Char

    function VTG(sys::String)
        CoG_true = 0.0
        CoG_mag = 0.0
        SoG_knots = 0.0
        SoG_kmhr = 0.0
        mode = 'N'
        new(CoG_true, CoG_mag, SoG_knots,
            SoG_kmhr, mode)
    end # constructor VTG

end # type VTG

############################################################
# parse_VTG
# ---------
# parses VTG messages
############################################################

function parse_VTG(items::Array{SubString{ASCIIString}}, system::String)
    VTG_data = VTG(system)
    VTG_data.CoG_true = tryfloat(items[2])
    VTG_data.CoG_mag = tryfloat(items[4])
    VTG_data.SoG_knots = tryfloat(items[6])
    VTG_data.SoG_kmhr = tryfloat(items[8])
    VTG_data.mode = items[10][1]
    VTG_data
end # function parse_VTG
