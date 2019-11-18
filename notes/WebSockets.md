(stepping out of slack attention sequence) I know there is a simple, transferrable-to-other widgets way to do this.
I don't know that way, though.  Would you shed some light on this:


`using WebIO, Interact, Blink and creating w = Window(); sel = <select dropdown>, ui = vbox(sel); body!(w, ui);`

When the user selects one of the drop-down options, how do I know which option has been selected and if the user change that selection, how do I know that it has been updated (while running code in Julia)?  I can do it in HTML/CSS/JavaScript, but even then, the information stays within the web page processing unless it is submitted or posted into local storage.  

For our efforts, it is important that the same process that generates the nodes to be shown on a web page/blink canvas can get updates on changes and data entered (e.g. parameter settings).

Julian Samaroo:science_parrot: 10:00
WebSocket or HTTP POST

WebSocket is best for interactive pages, HTTP POST is for form submission

WebIO uses WebSockets to do its magic
https://juliagizmos.github.io/WebIO.jl/latest/gettingstarted/#Sending-values-from-JavaScript-to-Julia-1
