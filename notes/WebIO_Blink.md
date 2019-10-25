```
using WebIO, Interact, Blink # Mux

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
