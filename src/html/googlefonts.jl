const googlefontstart = "<link ref=\"https://fonts.googleapis.com/css?family="
const googlefontend   = " rel=\"stylesheet\">"

function googlefontlink(family::String; sizes::Vector{Int}=[400,], styles::Vector{String} = [""], display="fallback")
    str = googlefont(family, sizes=sizes, styles=styles, display=display)
    return string(googlefontstart, str, "\",", googlefontend)
end

function googlefont(family::String; sizes::Vector{Int}=[400,], styles::Vector{String} = [""], display="fallback")
    xs = googlefont_family(family)
    str = join(xs, "+")
    return string(str, ":", googlefont_sizes_styles(sizes, styles), "&display=", display)
end

function googlefont_family(family::String)
    return uppercasefirst.(splitstring(family, " "))
end    
    
function googlefont_sizes_styles(sizes, styles)
    nsizes  = length(sizes)
    nstyles = length(styles)
    strs = repeat(string.(sizes), nstyles)
    for sz in 1:nsizes
      szidx = 1+(sz-1)*nstyles
      for sty in 0:nstyles-1
          strs[szidx+sty] = string(strs[szidx+sty], styles[sty+1])
      end
   end
   return join(strs, ",")
end

function googlefontlink(families::Vector{String}; sizes::Vector{Vector{Int}}, styles::Vector{Vector{String}}, display="fallback")
    str = googlefont(families, sizes=sizes, styles=styles, display=display)
    return string(googlefontstart, str, googlefontend)
end
       
function googlefont(families::Vector{String}; 
                     sizes::Vector{Vector{Int}}=fill([400,], length(families)), 
                     styles::Vector{Vector{String}}=fill(["",], length(families)), display="fallback")
   (length(families) == length(sizes) == length(styles)) ||
       throw(ErrorException("inputs ($(length(families)) $(length(sizes)) $(length(styles))) must be of the same length"))
   fonts = Vector{Vector{String}}[]
   for (family,size,style) in zip(families, sizes, styles)
        push!(fonts, googlefont(family, size, style))
   end
   return join(fonts, "|")
end
