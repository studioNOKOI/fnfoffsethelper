package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var referenceDude:Character;
	var dude:Character;
	var bf:Boyfriend; // he's just here for reference
	var dad:Dad; // also here for reference

	// add any extra animations to this array
	var currentState:Array<String> = ['idle', 'singUP', 'singLEFT', 'singRIGHT', 'singDOWN'];
	var offsetX:Array<Int> = [0, 0, 0, 0, 0];
	var offsetY:Array<Int> = [0, 0, 0, 0, 0];

	var selectedState:Int = 0;
	var stateDisplay:FlxText;

	var gameOffsetX:Int = 0;
	var gameOffsetY:Int = 0;

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
			"Move your character with the \narrow keys \n Match up the bottom of your char \n with the bottom of the Dad.", 20);
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
	}

	public function animOffsetter(currentAnim:String)
	{
		stateDisplay.text = "Current Anim: " + currentAnim;
		spriteXDisplay.text = "X: " + offsetX[selectedState];
		spriteYDisplay.text = "Y: " + offsetY[selectedState];
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
			dude.addOffset(currentAnim, offsetX[selectedState], offsetY[selectedState]);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.LEFT)
		{
			offsetX[selectedState]++;
			dude.addOffset(currentAnim, offsetX[selectedState], offsetY[selectedState]);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			offsetX[selectedState]--;
			dude.addOffset(currentAnim, offsetX[selectedState], offsetY[selectedState]);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.UP)
		{
			offsetY[selectedState]++;
			dude.addOffset(currentAnim, offsetX[selectedState], offsetY[selectedState]);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.pressed.DOWN)
		{
			offsetY[selectedState]--;
			add(stateDisplay);
			dude.addOffset(currentAnim, offsetX[selectedState], offsetY[selectedState]);
			dude.playAnim(currentAnim);
		}
		if (FlxG.keys.justPressed.H)
		{
			bf.active = !bf.active;
		}
	}
}
