using GUI: googlefont, googlefontlink

@testset "Google Fonts" begin
  @test googlefont("Roboto") === "Roboto"
  @test googlefont("IBM Flex Mono") === "IBM+Flex+Mono"
  @test googlefont(["Roboto", "IBM Flex Mono"]) === "Roboto|IBM+Flex+Mono"
  @test googlefont("Roboto", [400]) === "Roboto:400"
  @test googlefont("Roboto", [400,700]) === "Roboto:400,700"
  @test googlefont("Roboto", [400], ["","i"]) === "Roboto:400,400i"
  @test googlefont("Roboto", [400,700], ["","i"]) == "Roboto:400,400i,700,700i"
end

@testset "Google Font Links" begin
  @test googlefontlink("Roboto") === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto\", rel=\"stylesheet\">"
  @test googlefontlink("IBM Flex Mono") === "<link ref=\"https://fonts.googleapis.com/css?family=IBM+Flex+Mono\", rel=\"stylesheet\">"
  @test googlefontlink(["Roboto", "IBM Flex Mono"]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto|IBM+Flex+Mono\", rel=\"stylesheet\">"
  @test googlefontlink("Roboto", weight=[400]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400\", rel=\"stylesheet\">"
  @test googlefontlink("Roboto", weight=[400,700]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,700\", rel=\"stylesheet\">"
  @test googlefontlink("Roboto", weight=[400], style=["","i"]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,400i\", rel=\"stylesheet\">"
  @test googlefontlink("Roboto", weight=[400,700], style=["","i"]) === "<link ref=\"https://fonts.googleapis.com/css?family=Roboto:400,400i,700,700i\", rel=\"stylesheet\">"
end
