using GUI: googlefont, googlefontlink

@testset "Google Fonts" begin
  googlefont("Roboto") === "Roboto"
  googlefont("IBM Flex Mono") === "IBM+Flex+Mono"
  googlefont(["Roboto", "IBM Flex Mono"]) === "Roboto|IBM+Flex+Mono"
  googlefont("Roboto", [400]) === "Roboto:400"
  googlefont("Roboto", [400,700]) === "Roboto:400,700"
  googlefont("Roboto", [400], ["","i"]) === "Roboto:400,400i"
  googlefont("Roboto", [400,700], ["","i"]) == "Roboto:400,400i,700,700i"
end

@testset "Google Font Links" begin
  googlefontlink("Roboto") === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto\", rel=\"stylesheet\">"
  googlefontlink("IBM Flex Mono") === "<link ref=\"https://fonts.googleapis.com/css?family=IBM+Flex+Mono\", rel=\"stylesheet\">"
  googlefontlink(["Roboto", "IBM Flex Mono"]) === ""<link ref=\"https://fonts.googleapis.com/css?family=Roboto|IBM+Flex+Mono\", rel=\"stylesheet\">"
  googlefontlink("Roboto", weight=[400]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400\", rel=\"stylesheet\">"
  googlefontlink("Roboto", weight=[400,700]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,700\", rel=\"stylesheet\">"
  googlefontlink("Roboto", weight=[400], style=["","i"]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,400i\", rel=\"stylesheet\">"
  googlefontlink("Roboto", weight=[400,700], style=["","i"]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,400i,700,700i\", rel=\"stylesheet\">"
end
