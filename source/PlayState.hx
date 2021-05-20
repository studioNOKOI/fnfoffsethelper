package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;

class PlayState extends FlxState
{
	var referenceDude:Character;
	var dude:Character;
	var bf:Boyfriend; // he's just here for reference
	var dad:Dad; // also here for reference

	// add any extra animations to this array
	var currentState:Array<String> = ['idle', 'singUP', 'singLEFT', 'singRIGHT', 'singDOWN'];

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
		
		// compile le offsets into a text file like week7 accepts and shit.

		if (FlxG.keys.justPressed.E)
		{
			var data = "";
			for (anim => offsets in referenceDude.animOffsets)
				data += '${anim} ${offsets[0]} ${offsets[1]}\n';
			if ((data != null) && (data.length > 0))
			{
				_file = new FileReference();
				_file.addEventListener(Event.COMPLETE, onSaveComplete);
				_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
				_file.save(data, "offsets.txt");
			}
		}
	}
	
	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	}

	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
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
