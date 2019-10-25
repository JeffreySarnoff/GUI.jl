```
using DataStructures, WebIO, Blink, Interact, JSExpr

abstract type HtmlItem end

abstract type HtmlElement <: HtmlItem end
abstract type HtmlInput   <: HtmlElement end
abstract type HtmlChoice  <: HtmlInput end

mutable struct HtmlSelect <: HtmlChoice
    dict::OrderedDict{String, String}
    widget::Widget{:dropdown,Any}
end

function HtmlSelect(options, values)
    checkargs(Val{:HtmlSelect}, options, values)
    dict = OrderedDict(zip(options, values))
    widget = dropdown(dict)
    return HtmlSelect(dict, widget)
end


options=["image", "help", "menu"]; values=["img", "help", "navbar"];

select = HtmlSelect(options, values);

blinkwin = Window();

winhorizpixels, winvertpixels = Blink.size(blinkwin)
aspectratio = round(winhorizpixels/winvertpixels, sigdigits=5)
winhorizcenter, winvertcenter = div(winhorizpixels, 2), div(winvertpixels, 2)
winhorizpadding = round(winhorizpixels * 0.003 * aspectratio)*1em
winvertpadding = round(winvertpixels * 0.003)*1em
uipadded = vbox(pad(winvertpadding, pad(winhorizpadding,select.widget)));

body!(blinkwin,uipadded);


#ui = vbox( pad(6em, select.widget) );
#body!(blinkwin, ui);


checkargs(::Type{Val{:HtmlSelect}}, options, values) =
    (length(options) === length(values) && !isempty(options)) ? nothing :
        throw(ArgumentError("improper lengths: $(length(options)), $(length(values))"))

=#



#=
w = Window()

s1a = dropdown(OrderedDict("picture" => "img", "menu" => "navbar", "help" => "button"));
s2a = dropdown(OrderedDict("input values" => "form", "show plot" => "plot", "animate" => "svg"));
s3a = dropdown(OrderedDict("select" => "select", "checkboxes" => "checkbox", "input values" => "form"));

s1b = dropdown(OrderedDict("picture" => "img", "menu" => "navbar", "help" => "button"));
s2b = dropdown(OrderedDict("input values" => "form", "show plot" => "plot", "animate" => "svg"));
s3b = dropdown(OrderedDict("select" => "select", "checkboxes" => "checkbox", "input values" => "form"));

s1c = dropdown(OrderedDict("picture" => "img", "menu" => "navbar", "help" => "button"));
s2c = dropdown(OrderedDict("input values" => "form", "show plot" => "plot", "animate" => "svg"));
s3c = dropdown(OrderedDict("select" => "select", "checkboxes" => "checkbox", "input values" => "form"));

s1d = dropdown(OrderedDict("picture" => "img", "menu" => "navbar", "help" => "button"));
s2cd = dropdown(OrderedDict("input values" => "form", "show plot" => "plot", "animate" => "svg"));
s3d = dropdown(OrderedDict("select" => "select", "checkboxes" => "checkbox", "input values" => "form"));

ui = vbox( hbox(pad(2em, s1a), pad(2em, s2a), pad(2em, s3a)), 
           hbox(pad(2em,s1b),pad(2em,s2b), pad(2em,s3b)), 
           hbox(pad(2em,s1c), pad(2em,s2c), pad(2em, s3c)) );

body!(w, ui);

```
