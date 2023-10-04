
local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local cenaIniciar = self.view

	local x = display.contentWidth
	local y = display.contentHeight
	local t = (x + y) / 2

	local fundo = display.newImageRect( cenaIniciar, 'recursos/imagens/BG/sky_background_mountains.png', x, y)
	fundo.x = x*0.5
	fundo.y = y*0.5

	local sombra = display.newRect( cenaIniciar, x*0.5, y*0.5, x, y )
	sombra:setFillColor( 0, 0, 0)
	sombra.alpha = 0.6

	local icone = display.newImageRect(cenaIniciar, 'recursos/imagens/UI/touch.png', t*0.08, t*0.08)
	icone.x = x*0.5
	icone.y = y*0.5

	local texto = display.newText(cenaIniciar, 'Toque na tela para começar!', x*0.5, y*0.3, nil, t*0.05)


	function verificaToque( event )
		if (event.phase == 'began') then
			composer.gotoScene('cenas.jogo', {
				time = 300, effect = 'fade'
				})
		end
	end
Runtime:addEventListener( 'touch', verificaToque )

end
cena:addEventListener( 'create', cena )
return cena