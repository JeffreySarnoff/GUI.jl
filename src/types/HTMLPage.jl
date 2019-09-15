
import Base: string
using URIParser
using LinkedLists

struct HtmlHead
    charset::String
    title::String
    base::String
end

function HtmlHead(; charset::String="UTF-8", title::String="", base::String="")
    return HtmlHead(charset, title, base)
end

struct HtmlBody
  elements::LinkedList{HtmlElement}
end



struct HtmlPage
    doctype::String
    lang::String
    head::HtmlHead
    body::HtmlBody
    
    function HtmlPage(; doctype::String="html", lang::String="en", head::HtmlHead=HtmlHead(), body::HtmlBody=HtmlBody())
       return new(doctype, lang, head, body)
    end
end

function string(html::HtmlPage)
    io = IOBuffer()
    write(io, string("<!DOCTYPE ", html.doctype,">\n"))
    write(io, string("<html lang=\"", html.lang, "\">\n"))
    write(io, string(html.head))
    write(io, string(html.body))
    write(io, "<\\html>\n")
    return String(take!(io))
end

function string(head::HtmlHead)
    io = IOBuffer()
    write(io, "<head>\n")
    write(io, string("  <meta charset=\"", head.charset, "\">\n"))
    write(io, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n")
    if !isempty(head.base)
        write(io, string("  <base href=\"", head.base,">\n"))
    end
    if !isempty(head.title)
        write(io, string("  <title>", head.title,"</title>\n"))
    end
    write(io, "<\\head>\n")
    return String(take!(io))
end
 
function string(body::HtmlBody)
    io = IOBuffer()
    write(io, "<body>\n")
    write(io, "<\\body>\n")
    return String(take!(io))
end
