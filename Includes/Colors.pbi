;{- Code Header
; ==- Basic Info -================================
;         Name: Colors.pbi
;      Version: 1.0.0
;       Author: Herwin Bozet
;  Create date: 24 February 2018, 23:36:09
; 
;  Description: Collection of 24bit colors constants and color related macros.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.70 (x86/x64)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/Documentation/Colors
;  License: WTFPL
; 
;}


;- Notes
;{

; Procedures:
; > RGBToRGBA(Color.i)

;}


;- Macros
;{

; Might get changed to _RGBHex if a helper procedure is introduced later.
Macro RGBHex(Color)
	(Color >> 16) + ((Color >> 8) & 255) * 256 + (Color & 255) * 65536
EndMacro

; Might get changed to _RGBAHex if a helper procedure is introduced later.
Macro RGBAHex(Color)
	(Color >> 24) + ((Color >> 16) & 255) * 256 + ((Color >> 8) & 255) * 65536 + (Color & 255) * 16777216
EndMacro

;}


;- Colors - CSS3
;{

; The following colors are based on CSS3's 140 colors.
; https://www.w3schools.com/colors/colors_names.asp

#COLOR_AliceBlue = RGBHex($F0F8FF)
#COLOR_AntiqueWhite = RGBHex($FAEBD7)
#COLOR_Aqua = RGBHex($00FFFF)
#COLOR_Aquamarine = RGBHex($7FFFD4)
#COLOR_Azure = RGBHex($F0FFFF)

#COLOR_Beige = RGBHex($F5F5DC)
#COLOR_Bisque = RGBHex($FFE4C4)
#COLOR_Black = RGBHex($000000)
#COLOR_BlanchedAlmond = RGBHex($FFEBCD)
#COLOR_Blue = RGBHex($0000FF)
#COLOR_BlueViolet = RGBHex($8A2BE2)
#COLOR_Brown = RGBHex($A52A2A)
#COLOR_BurlyWood = RGBHex($DEB887)

#COLOR_CadetBlue = RGBHex($5F9EA0)
#COLOR_Chartreuse = RGBHex($7FFF00)
#COLOR_Chocolate = RGBHex($D2691E)
#COLOR_Coral = RGBHex($FF7F50)
#COLOR_CornflowerBlue = RGBHex($6495ED)
#COLOR_Cornsilk = RGBHex($FFF8DC)
#COLOR_Crimson = RGBHex($DC143C)
#COLOR_Cyan = RGBHex($00FFFF)

#COLOR_DarkBlue = RGBHex($00008B)
#COLOR_DarkCyan = RGBHex($008B8B)
#COLOR_DarkGoldenRod = RGBHex($B8860B)
#COLOR_DarkGray = RGBHex($A9A9A9)
#COLOR_DarkGrey = RGBHex($A9A9A9)
#COLOR_DarkGreen = RGBHex($006400)
#COLOR_DarkKhaki = RGBHex($BDB76B)
#COLOR_DarkMagenta = RGBHex($8B008B)
#COLOR_DarkOliveGreen = RGBHex($556B2F)
#COLOR_DarkOrange = RGBHex($FF8C00)
#COLOR_DarkOrchid = RGBHex($9932CC)
#COLOR_DarkRed = RGBHex($8B0000)
#COLOR_DarkSalmon = RGBHex($E9967A)
#COLOR_DarkSeaGreen = RGBHex($8FBC8F)
#COLOR_DarkSlateBlue = RGBHex($483D8B)
#COLOR_DarkSlateGray = RGBHex($2F4F4F)
#COLOR_DarkSlateGrey = RGBHex($2F4F4F)
#COLOR_DarkTurquoise = RGBHex($00CED1)
#COLOR_DarkViolet = RGBHex($9400D3)
#COLOR_DeepPink = RGBHex($FF1493)
#COLOR_DeepSkyBlue = RGBHex($00BFFF)
#COLOR_DimGray = RGBHex($696969)
#COLOR_DimGrey = RGBHex($696969)
#COLOR_DodgerBlue = RGBHex($1E90FF)

#COLOR_FireBrick = RGBHex($B22222)
#COLOR_FloralWhite = RGBHex($FFFAF0)
#COLOR_ForestGreen = RGBHex($228B22)
#COLOR_Fuchsia = RGBHex($FF00FF)

#COLOR_Gainsboro = RGBHex($DCDCDC)
#COLOR_GhostWhite = RGBHex($F8F8FF)
#COLOR_Gold = RGBHex($FFD700)
#COLOR_GoldenRod = RGBHex($DAA520)
#COLOR_Gray = RGBHex($808080)
#COLOR_Grey = RGBHex($808080)
#COLOR_Green = RGBHex($008000)
#COLOR_GreenYellow = RGBHex($ADFF2F)

#COLOR_HoneyDew = RGBHex($F0FFF0)
#COLOR_HotPink = RGBHex($FF69B4)

#COLOR_IndianRed = RGBHex($CD5C5C)
#COLOR_Indigo = RGBHex($4B0082)
#COLOR_Ivory = RGBHex($FFFFF0)

#COLOR_Khaki = RGBHex($F0E68C)

#COLOR_Lavender = RGBHex($E6E6FA)
#COLOR_LavenderBlush = RGBHex($FFF0F5)
#COLOR_LawnGreen = RGBHex($7CFC00)
#COLOR_LemonChiffon = RGBHex($FFFACD)
#COLOR_LightBlue = RGBHex($ADD8E6)
#COLOR_LightCoral = RGBHex($F08080)
#COLOR_LightCyan = RGBHex($E0FFFF)
#COLOR_LightGoldenRodYellow = RGBHex($FAFAD2)
#COLOR_LightGray = RGBHex($D3D3D3)
#COLOR_LightGrey = RGBHex($D3D3D3)
#COLOR_LightGreen = RGBHex($90EE90)
#COLOR_LightPink = RGBHex($FFB6C1)
#COLOR_LightSalmon = RGBHex($FFA07A)
#COLOR_LightSeaGreen = RGBHex($20B2AA)
#COLOR_LightSkyBlue = RGBHex($87CEFA)
#COLOR_LightSlateGray = RGBHex($778899)
#COLOR_LightSlateGrey = RGBHex($778899)
#COLOR_LightSteelBlue = RGBHex($B0C4DE)
#COLOR_LightYellow = RGBHex($FFFFE0)
#COLOR_Lime = RGBHex($00FF00)
#COLOR_LimeGreen = RGBHex($32CD32)
#COLOR_Linen = RGBHex($FAF0E6)

#COLOR_Magenta = RGBHex($FF00FF)
#COLOR_Maroon = RGBHex($800000)
#COLOR_MediumAquaMarine = RGBHex($66CDAA)
#COLOR_MediumBlue = RGBHex($0000CD)
#COLOR_MediumOrchid = RGBHex($BA55D3)
#COLOR_MediumPurple = RGBHex($9370DB)
#COLOR_MediumSeaGreen = RGBHex($3CB371)
#COLOR_MediumSlateBlue = RGBHex($7B68EE)
#COLOR_MediumSpringGreen = RGBHex($00FA9A)
#COLOR_MediumTurquoise = RGBHex($48D1CC)
#COLOR_MediumVioletRed = RGBHex($C71585)
#COLOR_MidnightBlue = RGBHex($191970)
#COLOR_MintCream = RGBHex($F5FFFA)
#COLOR_MistyRose = RGBHex($FFE4E1)
#COLOR_Moccasin = RGBHex($FFE4B5)

#COLOR_NavajoWhite = RGBHex($FFDEAD)
#COLOR_Navy = RGBHex($000080)

#COLOR_OldLace = RGBHex($FDF5E6)
#COLOR_Olive = RGBHex($808000)
#COLOR_OliveDrab = RGBHex($6B8E23)
#COLOR_Orange = RGBHex($FFA500)
#COLOR_OrangeRed = RGBHex($FF4500)
#COLOR_Orchid = RGBHex($DA70D6)

#COLOR_PaleGoldenRod = RGBHex($EEE8AA)
#COLOR_PaleGreen = RGBHex($98FB98)
#COLOR_PaleTurquoise = RGBHex($AFEEEE)
#COLOR_PaleVioletRed = RGBHex($DB7093)
#COLOR_PapayaWhip = RGBHex($FFEFD5)
#COLOR_PeachPuff = RGBHex($FFDAB9)
#COLOR_Peru = RGBHex($CD853F)
#COLOR_Pink = RGBHex($FFC0CB)
#COLOR_Plum = RGBHex($DDA0DD)
#COLOR_PowderBlue = RGBHex($B0E0E6)
#COLOR_Purple = RGBHex($800080)

#COLOR_RebeccaPurple = RGBHex($663399)
#COLOR_Red = RGBHex($FF0000)
#COLOR_RosyBrown = RGBHex($BC8F8F)
#COLOR_RoyalBlue = RGBHex($4169E1)

#COLOR_SaddleBrown = RGBHex($8B4513)
#COLOR_Salmon = RGBHex($FA8072)
#COLOR_SandyBrown = RGBHex($F4A460)
#COLOR_SeaGreen = RGBHex($2E8B57)
#COLOR_SeaShell = RGBHex($FFF5EE)
#COLOR_Sienna = RGBHex($A0522D)
#COLOR_Silver = RGBHex($C0C0C0)
#COLOR_SkyBlue = RGBHex($87CEEB)
#COLOR_SlateBlue = RGBHex($6A5ACD)
#COLOR_SlateGray = RGBHex($708090)
#COLOR_SlateGrey = RGBHex($708090)
#COLOR_Snow = RGBHex($FFFAFA)
#COLOR_SpringGreen = RGBHex($00FF7F)
#COLOR_SteelBlue = RGBHex($4682B4)

#COLOR_Tan = RGBHex($D2B48C)
#COLOR_Teal = RGBHex($008080)
#COLOR_Thistle = RGBHex($D8BFD8)
#COLOR_Tomato = RGBHex($FF6347)
#COLOR_Turquoise = RGBHex($40E0D0)

#COLOR_Violet = RGBHex($EE82EE)

#COLOR_Wheat = RGBHex($F5DEB3)
#COLOR_White = RGBHex($FFFFFF)
#COLOR_WhiteSmoke = RGBHex($F5F5F5)

#COLOR_Yellow = RGBHex($FFFF00)
#COLOR_YellowGreen = RGBHex($9ACD32)

;}


;- Colors - Windows
;{

#COLOR_W98_Background = RGBHex($008080)

; The following colors are based on Windows's Metro colors.
; https://colorlib.com/etc/metro-colors/
#COLOR_Metro_LightGreen = RGBHex($99B433)
#COLOR_Metro_Green = RGBHex($00A300)
#COLOR_Metro_DarkGreen = RGBHex($1E7145)
#COLOR_Metro_Magenta = RGBHex($FF0097)
#COLOR_Metro_LightPurple = RGBHex($9F00A7)
#COLOR_Metro_Purple = RGBHex($7E3878)
#COLOR_Metro_DarkPurple = RGBHex($603CBA)
#COLOR_Metro_Darken = RGBHex($1D1D1D)
#COLOR_Metro_Teal = RGBHex($00ABA9)
#COLOR_Metro_LigthBlue = RGBHex($EFF4FF)
#COLOR_Metro_Blue = RGBHex($2D89EF)
#COLOR_Metro_DarkBlue = RGBHex($2B5797)
#COLOR_Metro_Yellow = RGBHex($FFC40D)
#COLOR_Metro_Orange = RGBHex($E3A21A) ; Looks more like a pissy brown than orange
#COLOR_Metro_DarkOrange = RGBHex($DA532C)
#COLOR_Metro_Red = RGBHex($EE1111)
#COLOR_Metro_DarkRed = RGBHex($B91D47)
#COLOR_Metro_White = RGBHex($FFFFFF)

;}


;- Colors - Shades of black (unused)
;{

; #COLOR_Grey_5  = RGBHex($0D0D0D) ; Rounded up from #C.C (12.75)
; #COLOR_Grey_10 = RGBHex($1A1A1A) ; Rounded up from #19.8 (25.5)
; #COLOR_Grey_15 = RGBHex($262626) ; Rounded down from #26.4 (38.25)
; #COLOR_Grey_20 = RGBHex($) ; 
; #COLOR_Grey_25 = RGBHex($) ; 
; #COLOR_Grey_30 = RGBHex($) ; 
; #COLOR_Grey_35 = RGBHex($) ; 
; #COLOR_Grey_40 = RGBHex($) ; 
; #COLOR_Grey_45 = RGBHex($) ; 
; #COLOR_Grey_50 = RGBHex($7F7F7F)
; #COLOR_Grey_55 = RGBHex($) ; 
; #COLOR_Grey_60 = RGBHex($) ; 
; #COLOR_Grey_65 = RGBHex($) ; 
; #COLOR_Grey_70 = RGBHex($) ; 
; #COLOR_Grey_75 = RGBHex($) ; 
; #COLOR_Grey_80 = RGBHex($) ; 
; #COLOR_Grey_85 = RGBHex($) ; 
; #COLOR_Grey_90 = RGBHex($) ; 
; #COLOR_Grey_95 = RGBHex($) ; 

;}


;- Colors - Misc
;{

; Fun fact of the day: On twitter, the genocidal fondation that is PETA used the color #BEEEEEF on their 
;  twitter banner for quite some time, how ironic.
#COLOR_MSC_PETA = RGBHex($BEEEEF)

;}

; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 41
; FirstLine = 36
; Folding = --
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 29
; EnableBuildCount = 0