using Heine
using Documenter

DocMeta.setdocmeta!(Heine, :DocTestSetup, :(using Heine); recursive=true)

makedocs(;
    modules=[Heine],
    authors="Heine Rugland",
    repo="https://github.com/HeineRugland/Heine.jl/blob/{commit}{path}#{line}",
    sitename="Heine.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://HeineRugland.github.io/Heine.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/HeineRugland/Heine.jl",
    devbranch="main",
)
