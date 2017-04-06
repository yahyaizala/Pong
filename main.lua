local collision=require "utils"
local width=display.contentWidth
local height=display.contentHeight
local player1=display.newRect(0,0,6,100)
local move={x=2,y=.3}
local player1Score=0
local player2Score=0
local mt
local match=true
local sensor1=display.newRect(0,0,width*0.5,height)
sensor1.x=0
sensor1.y=height*0.5
sensor1:setFillColor(0,0,0)
sensor1:toBack()
sensor1.id="p1"
local sensor2=display.newRect(0,0,width*0.5,height)
sensor2.id="p2"
sensor2.x=width
sensor2.y=height*0.5
sensor2:setFillColor(0,0,0)
sensor2:toBack()
local player1Text=display.newText("Oyuncu Skor :"..player1Score,100,200,native.systemFont,16)
player1Text.x=40
player1Text.y=20
local player2Text=display.newText("Rakip Skor :"..player1Score,100,200,native.systemFont,16)
player2Text.x=width-40
player2Text.y=20
display.setStatusBar(display.HiddenStatusBar)
player1.x=0
player1.y=display.contentCenterY
local player2=display.newRect(0,0,6,100)
player2.x=width-player2.width*0.5
player2.y=display.contentCenterY

movePlayer=function(e)	
	if e.target.id=="p1" then
		player1.y=e.y
	elseif e.target.id=="p2" then
		player2.y=e.y
	end
	return true
end
local playerLoose=display.newRect(0,0,1,height)
playerLoose.x=-20
playerLoose.y=height/2
local player2Loose=display.newRect(0,0,1,height)
player2Loose.x=width+10
player2Loose.y=height*0.5
local ball=display.newCircle(5,5,10)
ball.x=display.contentCenterX
ball.y=display.contentCenterY
rePlay=function()
	ball.x=display.contentCenterX
	ball.y=display.contentCenterY
	move={x=2,y=3}
	mt=timer.performWithDelay(10,updateBall,-1)

end
updateBall=function(e)	
	if collision.hasCollideRect(player1,ball) then
		
		if math.random(1,5)>2 then
			move.y=move.y*0.5
			move.x=-1.5*move.x
		else 
			move.y=move.y*-0.5
			move.x=-1*move.x
		end


	end
	if collision.hasCollideRect(player2,ball) then
		
		if math.random(1,5)>2 then
			move.y=move.y*0.5
			move.x=-1.5*move.x
		else 
			move.y=move.y*-0.5
			move.x =move.x*-1
		end
	end
	if ball.y>height-5 then 
		move.y=move.y*-1
	end
	if ball.y<-5 then 
		move.y=move.y*-1
	end
	if ball.x<-ball.width*0.5 then 
		print("oyuncu 2 puan aldi")
		player2Score=player2Score+1
		player2Text.text="Rakip Skor :"..player2Score
		timer.pause(mt)
		rePlay()
		
	end
	if ball.x>width then
		print("oyuncu 1 puan aldi")
		player1Score=player1Score+1
		player1Text.text="Oyuncu Skor :"..player1Score
		timer.cancel(mt)
		rePlay()

	end
	ball.x=ball.x+move.x
	ball.y=ball.y+move.y
	if move.x<-10 then move.x=-10 end
	if move.x>10 then move.y=10 end

end

sensor1:addEventListener("touch",movePlayer)
sensor2:addEventListener("touch",movePlayer)
mt=timer.performWithDelay(10,updateBall,-1)