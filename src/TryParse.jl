############################################################
# tryfloat
# --------
# return parsed float or 0
############################################################

function tryfloat(item::SubString{ASCIIString})
    try
        float(item)
    catch
        0
    end
end # function tryfloat

############################################################
# tryint
# ------
# return parsed int or 0
############################################################

function tryint(item::SubString{ASCIIString})
    try
        int(item)
    catch
        0
    end
end # function tryint
