package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.net.FileFilter;
import openfl.net.FileReference;
import openfl.utils.ByteArray;

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

	var PNGButton:FlxButtonPlus;
	var XMLButton:FlxButtonPlus;

	var pngUploader:FileReference;
	var xmlUploader:FileReference;

	var pngFile:BitmapData;
	var xmlFile:String;

	var pngImported:Bool = false;
	var xmlImported:Bool = false;

	var stampingGuy:Bool = true;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.GRAY;
		pngUploader = new FileReference();
		pngUploader.addEventListener(Event.SELECT, selectPNG);
		pngUploader.addEventListener(Event.COMPLETE, loadPNG);
		xmlUploader = new FileReference();
		xmlUploader.addEventListener(Event.SELECT, selectXML);
		xmlUploader.addEventListener(Event.COMPLETE, loadXML);

		PNGButton = new FlxButtonPlus(200, 200, importPNG, "upload png", 500, 50);
		add(PNGButton);
		XMLButton = new FlxButtonPlus(800, 200, importXML, "upload xml", 500, 50);
		add(XMLButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		// cameraControl();
		var currentAnim = currentState[selectedState];

		if (!stampingGuy && pngImported && xmlImported)
		{
			animOffsetter(currentAnim);
		}
		else if (pngImported && xmlImported)
		{
			baseOffsetter();
		}
		super.update(elapsed);
	}

	function createAfterUploads()
	{
		PNGButton.destroy();
		XMLButton.destroy();
		bf = new Boyfriend(1070, 450);
		dad = new Dad(400, 100);
		referenceDude = new Character(400, 100, pngFile, AssetPaths.brandon__xml);
		add(bf);
		add(dad);
		add(referenceDude);
		gameOffsetDisplay = new FlxText(100, 50, 0,
			"Move your character with the \narrow keys \n Match up the bottom of your char \n with the bottom of the Dad.", 20);
		add(gameOffsetDisplay);
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
			dude = new Character(400 - gameOffsetX, 100 - gameOffsetY, pngFile, AssetPaths.brandon__xml);
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

	function animOffsetter(currentAnim:String)
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

	function importPNG():Void
	{
		trace("import png");
		pngUploader.browse([new FileFilter("", ".png", "")]);
	}

	function selectPNG(e:Event):Void
	{
		trace("select png");
		pngUploader.load();
	}

	function loadPNG(e:Event):Void
	{
		trace("load png");
		BitmapData.loadFromBytes(pngUploader.data).onComplete(function(bdata)
		{
			pngFile = bdata;
		});
		pngImported = true;
		if (xmlImported)
		{
			createAfterUploads();
		}
	}

	function importXML():Void
	{
		trace("import xml");
		xmlUploader.browse([new FileFilter("", ".xml", "")]);
	}

	function selectXML(e:Event):Void
	{
		trace("select xml");
		xmlUploader.load();
	}

	function loadXML(e:Event):Void
	{
		trace("load xml");

		xmlImported = true;
		if (pngImported)
		{
			createAfterUploads();
		}
	}
	/*function cameraControl()
		{
			if (FlxG.keys.pressed.W)
			{
				camera.scroll.y++;
			}
			if (FlxG.keys.pressed.A)
			{
				camera.scroll.x--;
			}
			if (FlxG.keys.pressed.S)
			{
				camera.scroll.y--;
			}
			if (FlxG.keys.pressed.D)
			{
				camera.scroll.x++;
			}
			if (FlxG.keys.pressed.Z)
			{
				camera.zoom--;
			}
			if (FlxG.keys.pressed.X)
			{
				camera.zoom++;
			}
	}*/
}
