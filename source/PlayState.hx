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

	// add any extra animations to this array
	var currentState:Array<String> = ['idle', 'singUP', 'singLEFT', 'singRIGHT', 'singDOWN'];

	var selectedState:Int = 0;
	var stateDisplay:FlxText;

	var offsetX:Int = 0;
	var offsetY:Int = 0;

	var xDisplay:FlxText;
	var yDisplay:FlxText;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.GRAY;
		bf = new Boyfriend(1070, 450);
		dude = new Character(400, 100);
		referenceDude = new Character(400, 100);
		add(bf);
		add(referenceDude);
		add(dude);
		stateDisplay = new FlxText(100, 20, 0, 'Current Anim: ', 20);
		xDisplay = new FlxText(600, 20, 0, 'X: 0', 20);
		yDisplay = new FlxText(700, 20, 0, 'Y: 0', 20);
		add(stateDisplay);
		add(xDisplay);
		add(yDisplay);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		var currentAnim = currentState[selectedState];

		stateDisplay.text = "Current Anim: " + currentAnim;
		xDisplay.text = "X: " + offsetX;
		yDisplay.text = "Y: " + offsetY;

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
		super.update(elapsed);
	}
}
