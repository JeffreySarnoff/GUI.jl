```
using WebIO, Interact, Blink and creating w = Window(); ui = <select dropdown>; body(w, ui);
When the user selects one of the drop-down options, how do I know which option has been selected from Julia? (edited) 

Travis DePrato 15:33
observe(ui) will return an observable whose value tracks the selection.
That happens implicitly if you do `on(map) do … end` or `onjs(map, js"""function (newValue) { … }"""`)
```
```
Jeffrey Sarnoff 09:50
(stepping out of slack attention sequence) I know there is a simple, transferrable-to-other widgets way to do this.
I don't know that way, though.  Would you shed some light on this:

using WebIO, Interact, Blink
w = Window(); 
sel = <select dropdown>, ui = vbox(sel); 
body!(w, ui);

When the user selects one of the drop-down options, how do I know which option has been selected
and if the user change that selection, how do I know that it has been updated (while running code in Julia)?
I can do it in HTML/CSS/JavaScript, but even then, the information stays within the web page processing
unless it is submitted or posted into local storage.
For our efforts, it is important that the same process that generates the nodes to be shown
on a web page/blink canvas can get updates on changes and data entered (e.g. parameter settings).
    
Julian Samaroo:science_parrot: 10:00
WebSocket or HTTP POST

WebSocket is best for interactive pages, HTTP POST is for form submission
WebIO uses WebSockets to do its magic
https://juliagizmos.github.io/WebIO.jl/latest/gettingstarted/#Sending-values-from-JavaScript-to-Julia-1
```



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

checkargs(::Type{Val{:HtmlSelect}}, options, values) =
    (length(options) === length(values) && !isempty(options)) ? nothing :
        throw(ArgumentError("improper lengths: $(length(options)), $(length(values))"))


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


blinkwin = Window();
select = Node(:select, Node(:option, value="first", "FirstValue"), Node(:option, value="second", "SecondValue"), 
               attributes=Dict(:style => "font-size: 32px; color: green; padding: 20px"));

ui = vbox( pad(6em, select) );
body!(blinkwin, ui);

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
