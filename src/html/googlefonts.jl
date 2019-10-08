const googlefontstart = "<link ref=\"https://fonts.googleapis.com/css?family="
const googlefontend   = " rel=\"stylesheet\">"

function googlefontlink(family::String, weight::Vector{Int}=Int[], style::Vector{String} = [""], display::String="")
    str = googlefont(family, weight, style, display)
    return string(googlefontstart, str, "\",", googlefontend)
end

function googlefont(family::String, weight::Vector{Int}=Int[], style::Vector{String} = [""], display::String="")
    str = join(googlefont_family(family), "+")
    if isempty(weight) && !isempty(style) && !all(isempty.(style))
        weight = [400]
    end
    if isempty(weight)
        weight_style = ""
    else
        weight_style = string(":", googlefont_weight_style(weight, style))
    end
    if !isempty(display)
        display = string("&display=", display)
    end
    return string(str, weight_style, display)
end

function googlefont_family(family::String)
    return uppercasefirst.(splitstring(family, " "))
end    

function googlefont_weight_style(weight::Vector{Int}, style::Vector{String})
    strs = String[]
    for w in weight
        push!(strs, googlefont_weight_style(w, style))
    end
    return join(strs, ",")
end

function googlefont_weight_style(weight::Int, style::Vector{String})
    nstyles = length(style)
    weightstr = string(weight)
    strs = String[]
    for s in style
        push!(strs, string(weightstr, s))
    end
    return join(strs, ",")
end

function googlefontlink(families::Vector{String},
                        weights::Vector{Vector{Int}}=fill(Int[], length(families)), 
                        styles::Vector{Vector{String}}=fill([""], length(families)), display::String="")
    str = googlefont(families, weights, styles, display)
    return string(googlefontstart, str, googlefontend)
end
       
function googlefont(families::Vector{String},
                    weights::Vector{Vector{Int}}=fill(Int[], length(families)), 
                    styles::Vector{Vector{String}}=fill([""], length(families)), display::String="")
   (length(families) == length(weights) == length(styles)) ||
       throw(ErrorException("inputs ($(length(families)) $(length(weights)) $(length(styles))) must be of the same length"))
   fonts = []
   for (family,weight,style) in zip(families, weights, styles)
        push!(fonts, googlefont(family, weight, style))
   end
   return join(fonts, "|")
end
