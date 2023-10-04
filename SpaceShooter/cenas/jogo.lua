
local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local cenaJogo = self.view

	local x = display.contentWidth
	local y = display.contentHeight
	local t = (x + y) / 2


	-- DECLARACAO DOS GRUPOS DA CENA
	local grupoFundo = display.newGroup()
	local grupoJogo = display.newGroup()
	local GUI = display.newGroup()

	cenaJogo:insert( grupoFundo )
	cenaJogo:insert( grupoJogo )
	cenaJogo:insert( GUI )


	-- DECLARACAO DAS VARIAVEIS

	local vida = 3
	local municao = 3
	local pente = 3
	local moedas = 0
	local vivo = true
	local pause = false
	local moverCima = false
	local moverBaixo = false
	local velocidadeAviao = 5
	local velocidadeReload = 2000
	local danoAviao = 1
	local kill = 0

	-- DECLARAÇÃO DE FISICA

	local physics = require('physics')
	physics.start()
	physics.setGravity(0, 0)
	physics.setDrawMode( 'hybrid' )


	-- DELCARACAO DOS OBJETOS DE EXIBIÇAO

	local fundo = display.newImageRect( grupoFundo, 'recursos/imagens/BG/sky_background_mountains.png', x, y)
	fundo.x = x*0.5
	fundo.y = y*0.5

		local fundo2 = display.newImageRect( grupoFundo, 'recursos/imagens/BG/sky_background_mountains.png', x, y)
	fundo2.x = x*1.5
	fundo2.y = y*0.5

	-- function gerarFundo( )
	-- 	fundo.x = fundo.x - 5
	-- 	fundo2.x = fundo2.x - 5

	-- 	if (fundo.x <= -x*0.5) then
	-- 		fundo.x = x*1.5

	-- 	elseif (fundo2.x <= -x*0.5) then
	-- 		fundo2.x = x*1.5
	-- 	end
	-- end
	-- Runtime:addEventListener('enterFrame', gerarFundo)



	local aviao = display.newImageRect( grupoJogo, 'recursos/imagens/planes/plane_1/plane_1_red.png', x*0.13, y*0.13 )
	aviao.x = x*0.23
	aviao.y = y*0.5
	physics.addBody( aviao, 'static' )
	aviao.id = 'aviaoID'

	-- INIMIGO
	function criaInimigo()
		if (vivo == true) then

			local inimigo = display.newImageRect(grupoJogo, 'recursos/imagens/planes/inimigos/ovni.png', x*0.13, y*0.13)
				inimigo.x = x*0.9
				inimigo.y = math.random(y*0.17, y*0.93 )
				physics.addBody(inimigo, 'dynamic')
				inimigo.id = 'inimigoID'
				inimigo.vida = 3

				transition.to( inimigo, {
					time = 9000, x = -x*0.5
					})
			end
			
			
		end
		local timerInimigo = timer.performWithDelay(4000, criaInimigo, 0)
		
		


	local botaoCima = display.newImageRect(GUI, 'recursos/imagens/UI/botao_cima.png', t*0.08, t*0.08)
	botaoCima.x = x*0.12
	botaoCima.y = y*0.7


local botaoBaixo = display.newImageRect(GUI, 'recursos/imagens/UI/botao_cima.png', t*0.08, t*0.08)
	botaoBaixo.x = x*0.12
	botaoBaixo.y = y*0.9
	botaoBaixo.rotation = -180


	local botao1 = display.newImageRect( GUI, 'recursos/imagens/UI/Button - PS Triangle 2.png', t*0.12, t*0.12)
	botao1.x = x*0.8
	botao1.y = y*0.7
	botao1.alpha = 0.7


	local botao2 = display.newImageRect( GUI, 'recursos/imagens/UI/Button - PS Square 2.png', t*0.12, t*0.12)
	botao2.x = x*0.73
	botao2.y = y*0.8
	botao2.alpha = 0.7


	local botao3 = display.newImageRect( GUI, 'recursos/imagens/UI/Button - PS Circle 2.png', t*0.12, t*0.12)
	botao3.x = x*0.87
	botao3.y = y*0.8
	botao3.alpha = 0.7


	local botao4 = display.newImageRect( GUI, 'recursos/imagens/UI/Button - PS Cross 2.png', t*0.12, t*0.12)
	botao4.x = x*0.8
	botao4.y = y*0.9
	botao4.alpha = 0.7

	local iconeVida1 = display.newImageRect(GUI, 'recursos/imagens/UI/life.png', t*0.06, t*0.06)
	iconeVida1.x = x*0.07
	iconeVida1.y = y*0.1

	local iconeVida2 = display.newImageRect(GUI, 'recursos/imagens/UI/life.png', t*0.06, t*0.06)
	iconeVida2.x = x*0.12
	iconeVida2.y = y*0.1

	local iconeVida3 = display.newImageRect(GUI, 'recursos/imagens/UI/life.png', t*0.06, t*0.06)
	iconeVida3.x = x*0.17
	iconeVida3.y = y*0.1


	local iconeMunicao1 = display.newImageRect(GUI, 'recursos/imagens/UI/municao.png', t*0.06, t*0.06)
	iconeMunicao1.x = x*0.07
	iconeMunicao1.y = y*0.22


	local iconeMunicao2 = display.newImageRect(GUI, 'recursos/imagens/UI/municao.png', t*0.06, t*0.06)
	iconeMunicao2.x = x*0.12
	iconeMunicao2.y = y*0.22

	local iconeMunicao3 = display.newImageRect(GUI, 'recursos/imagens/UI/municao.png', t*0.06, t*0.06)
	iconeMunicao3.x = x*0.17
	iconeMunicao3.y = y*0.22

	local iconeMoeda = display.newImageRect(GUI, 'recursos/imagens/icones/gold_coin.png', t*0.06, t*0.06)
	iconeMoeda.x = x*0.45
	iconeMoeda.y = y*0.1

	local textoMoeda = display.newText(GUI, moedas, x*0.5, y*0.1, nil, t*0.065)
	textoMoeda:setFillColor(0, 0, 0)

	-- FUNÇÕES DE MOVIMENTO

	function cima( )
		if (moverCima == true) then
			if (aviao.y > y*0.17) then
				aviao.y = aviao.y - velocidadeAviao
				
			end
		end
	end
	Runtime:addEventListener( 'enterFrame', cima )

	function verificaCima( event )
		if (event.phase == 'began') then
			moverCima = true

		elseif (event.phase == 'ended') then
			moverCima = false

		end
	end
	botaoCima:addEventListener( 'touch', verificaCima )

	function baixo( )
		if (moverBaixo == true) then
			if (aviao.y < y*0.93) then
				aviao.y = aviao.y + velocidadeAviao
			end
		end
	end
	Runtime:addEventListener( 'enterFrame', baixo )

	function verificaBaixo( event )
		if (event.phase == 'began') then
			moverBaixo = true

		elseif (event.phase == 'ended') then
			moverBaixo = false

		end
	end
	botaoBaixo:addEventListener( 'touch', verificaBaixo )

	-- function inimigoAvanca( event )
	-- 	if (event.phase == 'began') then
	-- 		inimigo.x  = math.random(x*0.25, x*0.9 )
	-- 		inimigo.y  = math.random(y*0.17, y*0.93)
	-- 		transition.to( inimigo, {
	-- 			time = 5000,
	-- 			} )
	-- 		print( 'moveu' ) 
	-- 	end
	-- end
	-- botao1:addEventListener( 'touch', inimigoAvanca )


	-- FUNÇÕES DE AÇÃO

	function atirar( event )
		if (event.phase == 'began') then
			if (municao > 0) then

				local tiro = display.newImageRect(grupoJogo, 'recursos/imagens/planes/tiros/torpedo_flame.png', t*0.07, t*0.025 )
				tiro.x = aviao.x + aviao.x*0.38
				tiro.y = aviao.y

				physics.addBody(tiro, 'dynamic')
				tiro.id = 'tiroID'

				transition.to(tiro, {
					time = 2500, x = x*1.5
					})

				municao = municao - 1
			end
		end
	end
	botao4:addEventListener( 'touch', atirar )

	function reload( event )
		if (event.phase == 'began') then
			if (municao < pente) then
				municao = pente
			
			end
		end
	end
	botao3:addEventListener( 'touch', reload )

	

	function verificaMunicao()
		if (municao == 0) then
			iconeMunicao1.alpha = 0
			iconeMunicao2.alpha = 0
			iconeMunicao3.alpha = 0

		elseif (municao == 1) then
			iconeMunicao1.alpha = 1
			iconeMunicao2.alpha = 0
			iconeMunicao3.alpha = 0

		elseif (municao == 2) then
			iconeMunicao1.alpha = 1
			iconeMunicao2.alpha = 1
			iconeMunicao3.alpha = 0

		elseif (municao == 3) then
			iconeMunicao1.alpha = 1
			iconeMunicao2.alpha = 1
			iconeMunicao3.alpha = 1
		end
	end
	Runtime:addEventListener('enterFrame', verificaMunicao)


	function verificaVida()
		if (vida == 0) then
			iconeVida1.alpha = 0
			iconeVida2.alpha = 0
			iconeVida3.alpha = 0
			-- vivo = false

			-- display.remove( aviao )

			-- telaMorte = display.newRect( GUI, x*0.5, y*0.5, x, y)
			-- telaMorte:setFillColor( 0, 0, 0 )
			-- telaMorte.alpha = 0.1
			-- display.newText( GUI, 'VOCE PERDEU!', x*0.5, y*0.5, nil, t*0.1 )

			-- function reiniciar()
			-- 	composer.removeScene( 'cenas.jogo')
			-- end

			-- function proximaCena()
			-- 	reiniciar()
			-- 	display.remove( aviao )
			-- 	display.remove( inimigo )
			-- 	composer.gotoScene( 'cenas.iniciar' )
			-- end

			-- timer.performWithDelay( 3000, proximaCena, 1)


		elseif (vida == 1) then
			iconeVida1.alpha = 1
			iconeVida2.alpha = 0
			iconeVida3.alpha = 0

		elseif (vida == 2) then
			iconeVida1.alpha = 1
			iconeVida2.alpha = 1
			iconeVida3.alpha = 0

		elseif (vida == 3) then
			iconeVida1.alpha = 1
			iconeVida2.alpha = 1
			iconeVida3.alpha = 1
		end
	end
	Runtime:addEventListener('enterFrame', verificaVida)


	


	-- FISICAS

	function verificaColisao( event )
		if (event.phase == 'began') then
			
			local obj1 = event.object1
			local obj2 = event.object2

			-- TIRO E INIMIGO

			if (obj1.id == 'inimigoID' and obj2.id == 'tiroID' or obj2.id == 'inimigoID' and obj1.id == 'tiroID')  then

				local tiro
				if (obj1.id == 'tiroID') then
					tiro = obj1

				else
					tiro = obj2
					
				end
				display.remove( tiro )
				
				local inimigo
				if (obj1.id == 'inimigoID') then
					inimigo = obj1
				else
					inimigo = obj2
				end

				inimigo.vida = inimigo.vida - danoAviao

				local hit = transition.blink( inimigo, {time = 300})
				timer.performWithDelay( 500, function()
					transition.cancel( hit )
					inimigo.alpha = 1

				end, 1 )

				
				if (inimigo.vida == 0) then
						transition.blink( inimigo, {time = 300})
						timer.performWithDelay( 500, function()
							display.remove( inimigo )
						end, 1)
						moedas = moedas + 1
						textoMoeda.text = moedas
						kill = kill + 1
					
				end
			end

			-- AVIAO E INIMIGO

			if (obj1.id == 'aviaoID' and obj2.id == 'inimigoID' or obj1.id == 'inimigoID' and obj2.id == 'aviaoID') then

				local inimigo
				if (obj1.id == 'inimigoID') then
					inimigo = obj1
				else
					inimigo = obj2
				end

				display.remove( inimigo )

				local aviao
				if (obj1.id == 'aviaoID') then
					aviao = obj1
				else
					aviao = obj2
				end

				transition.blink(aviao, {time = 300})
				timer.performWithDelay( 500, function()
					transition.cancel( aviao )
					aviao.alpha = 1
				end, 1)

				vida = vida - 1


				-- BOSS E TIRO

				if (obj1.id == 'tiroID' and obj2.id == 'bossID' or obj1.id == 'bossID' and obj2.id == 'tiroID') then

					local tiro
					if (obj1.id == 'tiroID') then
						tiro = obj1
					else
						tiro = obj2
						display.remove( tiro )
					end

					local boss
					if (obj1.id == 'bossID') then
						boss = obj1
					else
						boss = obj2
					end
						
						transition.blink(boss, {time = 300})
				timer.performWithDelay( 500, function()
					transition.cancel( boss )
					boss.alpha = 1
				end, 1)

				boss.vida = boss.vida - 1

					
					
				end




			end


		end
	end
	Runtime:addEventListener('collision', verificaColisao)






-- BOSS

	kill = 15
	function criaBoss()
		if (kill == 15) then

			timer.cancel( timerInimigo )
			
			local boss = display.newImageRect( grupoJogo, 'recursos/imagens/planes/inimigos/boss.png', x*0.43, y*0.47 )
			boss.x = x*0.7
			boss.y = y*0.5
			boss.vida = 30
			physics.addBody(boss, 'dynamic')
			boss.id = 'bossID'


			function moveBoss()
				transition.to(boss, {time = 1000, y = math.random(y*0.17, y*0.93)
					})
			end
			timer.performWithDelay( 3000, moveBoss, 0)


		end
	end
	criaBoss()









end
cena:addEventListener( 'create', cena )
return cena