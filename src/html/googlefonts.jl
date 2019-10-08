const googlefontstart = "<link ref=\"https://fonts.googleapis.com/css?family="
const googlefontend   = " rel=\"stylesheet\">"

function googlefontlink(family::String; sizes::Vector{Int}=Int[], styles::Vector{String} = [""], display::String="")
    str = googlefont(family, sizes=sizes, styles=styles, display=display)
    return string(googlefontstart, str, "\",", googlefontend)
end

function googlefont(family::String; sizes::Vector{Int}=Int[], styles::Vector{String} = [""], display::String="")
    xs = googlefont_family(family)
    str = join(xs, "+")
    sizes_styles = googlefont_sizes_styles(sizes, styles)
    if !isempty(sizes_styles)
        sizes_styles = string(":", sizes_styles)
    end
    if !isempty(display)
        display = string("&display=", display)
    end
    return string(str, sizes_styles, display)
end

function googlefont_family(family::String)
    return uppercasefirst.(splitstring(family, " "))
end    

function googlefont_sizes_styles(sizes::Vector{Int}, styles::Vector{String})
    strs = String[]
    for sz in sizes
        push!(strs, googlefont_size_styles(sz, styles))
    end
    return join(strs, ",")
end

function googlefont_size_styles(size::Int, styles::Vector{String})
    nstyles = length(styles)
    sizestr = string(size)
    strs = String[]
    for s in styles
        push!(strs, string(sizestr, s))
    end
    return join(strs, ",")
end

function googlefontlink(families::Vector{String};
                        sizes::Vector{Vector{Int}}=fill(Int[], length(families)), 
                        styles::Vector{Vector{String}}=fill([""], length(families)), display::String="")
    str = googlefont(families, sizes=sizes, styles=styles, display=display)
    return string(googlefontstart, str, googlefontend)
end
       
function googlefont(families::Vector{String}; sizes, styles, display)
   (length(families) == length(sizes) == length(styles)) ||
       throw(ErrorException("inputs ($(length(families)) $(length(sizes)) $(length(styles))) must be of the same length"))
   fonts = Vector{Vector{String}}[]
   for (family,size,style) in zip(families, sizes, styles)
        push!(fonts, googlefont(family, size, style))
   end
   return join(fonts, "|")
end
