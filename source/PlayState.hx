package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	var referenceDude:Character;
	var dude:Character;
	var bf:Boyfriend; // he's just here for reference
	var dad:Dad; // also here for reference

	// add any extra animations to this array
	var currentState:Array<String> = ['idle', 'singUP', 'singUPMISS', 'singLEFT', 'singLEFTMISS', 'singRIGHT', 'singRIGHTMISS', 'singDOWN', 'singDOWNMISS', 'HEY', 'SCARED', 'DEATH', 'DieLOOP', 'Retry'];

	var selectedState:Int = 0;
	var stateDisplay:FlxText;

	var gameOffsetX:Int = 0;
	var gameOffsetY:Int = 0;
	var offsetX:Int = 0;
	var offsetY:Int = 0;

	var spriteXDisplay:FlxText;
	var spriteYDisplay:FlxText;
	var gameOffsetDisplay:FlxText;

	var stampingGuy:Bool = true;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.GRAY;
		bf = new Boyfriend(1070, 450);
		dad = new Dad(400, 100);
		referenceDude = new Character(400, 100);
		add(bf);
		add(dad);
		add(referenceDude);
		gameOffsetDisplay = new FlxText(100, 50, 0,
			"CONTROLS: \n Arrow Keys: Move the Character. Enter to stamp the character. \n  C to stop the stamp. \n Z to zoom in and X to zoom out", 20);
		add(gameOffsetDisplay);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		var currentAnim = currentState[selectedState];



		if (!stampingGuy)
		{
			animOffsetter(currentAnim);
		}
		else
		{
			baseOffsetter();
		}
		
		super.update(elapsed);
		
		if(FlxG.keys.justReleased.Z)
			camera.zoom += 0.1;
		if(FlxG.keys.justReleased.X)
			camera.zoom -= 0.1;
		
			
			
		
	}

	function baseOffsetter()
	{
		if (FlxG.keys.pressed.LEFT)
		{
			gameOffsetDisplay.text = "Game Offset: " + gameOffsetX + ", " + gameOffsetY;
			gameOffsetX++;
			referenceDude.addOffset(currentState[0], gameOffsetX, gameOffsetY);
			referenceDude.playAnim(currentState[0]);
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			gameOffsetDisplay.text = "Game Offset: " + gameOffsetX + ", " + gameOffsetY;
			gameOffsetX--;
			referenceDude.addOffset(currentState[0], gameOffsetX, gameOffsetY);
			referenceDude.playAnim(currentState[0]);
		}
		if (FlxG.keys.pressed.UP)
		{
			gameOffsetDisplay.text = "Game Offset: " + gameOffsetX + ", " + gameOffsetY;
			gameOffsetY++;
			referenceDude.addOffset(currentState[0], gameOffsetX, gameOffsetY);
			referenceDude.playAnim(currentState[0]);
		}
		if (FlxG.keys.pressed.DOWN)
		{
			gameOffsetDisplay.text = "Game Offset: " + gameOffsetX + ", " + gameOffsetY;
			gameOffsetY--;
			referenceDude.addOffset(currentState[0], gameOffsetX, gameOffsetY);
			referenceDude.playAnim(currentState[0]);
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			dude = new Character(400 - gameOffsetX, 100 - gameOffsetY);
			add(dude);
			stateDisplay = new FlxText(100, 20, 0, 'Current Anim: ', 20);
			add(stateDisplay);
			spriteXDisplay = new FlxText(500, 20, 0, 'X: 0', 20);
			add(spriteXDisplay);
			spriteYDisplay = new FlxText(600, 20, 0, 'Y: 0', 20);
			add(spriteYDisplay);
			stampingGuy = false;
		}
		if (FlxG.keys.justPressed.C)
		{
			remove(stateDisplay);
			remove(spriteXDisplay);
		    remove(spriteYDisplay);
			stampingGuy = true;
		}
		
		
	}

	public function animOffsetter(currentAnim:String)
	{
		stateDisplay.text = "Current Anim: " + currentAnim;
		spriteXDisplay.text = "X: " + offsetX;
		spriteYDisplay.text = "Y: " + offsetY;
		if (FlxG.keys.justPressed.SPACE)
		{
			if (selectedState + 1 < currentState.length)
			{
				selectedState++;
			}
			else
			{
				selectedState = 0;
			}
			currentAnim = currentState[selectedState];
			dude.addOffset(currentAnim, offsetX, offsetY);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.LEFT)
		{
			offsetX++;
			dude.addOffset(currentAnim, offsetX, offsetY);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			offsetX--;
			dude.addOffset(currentAnim, offsetX, offsetY);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.UP)
		{
			offsetY++;
			dude.addOffset(currentAnim, offsetX, offsetY);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.DOWN)
		{
			offsetY--;
			add(stateDisplay);
			dude.addOffset(currentAnim, offsetX, offsetY);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.justPressed.H)
		{
			bf.active = !bf.active;
		}
	}
}
