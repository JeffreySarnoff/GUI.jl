using Documenter

makedocs(
    # modules = [GUI],
    sitename = "GUI",
    pages  = Any[
        "Overview" => "index.md"
        "HTML" => "html.md"
        ]
    )

deploydocs(
    repo = "github.com/JeffreySarnoff/GUI.jl.git",
    target = "build"
)
