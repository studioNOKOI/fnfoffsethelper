package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.io.Bytes;
import haxe.io.Encoding;
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

	var PNGButton:FlxUIButton;
	var XMLButton:FlxUIButton;

	var fileUploader:FileReference;

	var pngFile:BitmapData;
	var xmlFile:Xml;

	var pngImported:Bool = false;
	var xmlImported:Bool = false;

	var stampingGuy:Bool = true;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.GRAY;
		fileUploader = new FileReference();

		PNGButton = new FlxUIButton(320, 360, "upload png", importPNG);
		PNGButton.resize(300, 200);
		PNGButton.label.resize(200, 200); // please someone, find a better way to scale the text
		add(PNGButton);
		XMLButton = new FlxUIButton(960, 360, "upload xml", importXML);
		XMLButton.resize(300, 200);
		XMLButton.label.resize(200, 200); // please someone, find a better way to scale the text

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
		XMLButton.destroy();
		bf = new Boyfriend(1070, 450);
		dad = new Dad(400, 100);
		referenceDude = new Character(400, 100, pngFile, xmlFile.toString());
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
			dude = new Character(400 - gameOffsetX, 100 - gameOffsetY, pngFile, xmlFile.toString());
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
		fileUploader.addEventListener(Event.SELECT, selectPNG);
		fileUploader.addEventListener(Event.COMPLETE, loadPNG);
		trace("import png");
		#if html5
		fileUploader.browse([new FileFilter("", ".png", "")]);
		#end
		#if desktop
		fileUploader.browse([new FileFilter("", "png", "")]);
		#end
	}

	function selectPNG(e:Event):Void
	{
		trace("select png");
		fileUploader.load();
	}

	function loadPNG(e:Event):Void
	{
		fileUploader.removeEventListener(Event.SELECT, selectPNG);
		fileUploader.removeEventListener(Event.COMPLETE, loadPNG);
		trace("load png");
		BitmapData.loadFromBytes(fileUploader.data).onComplete(function(bdata)
		{
			pngFile = bdata;
		});
		pngImported = true;
		add(XMLButton);
		PNGButton.destroy();
	}

	function importXML():Void
	{
		fileUploader.addEventListener(Event.SELECT, selectXML);
		fileUploader.addEventListener(Event.COMPLETE, loadXML);
		trace("import xml");
		#if html5
		fileUploader.browse([new FileFilter("", ".xml", "")]);
		#end
		#if desktop
		fileUploader.browse([new FileFilter("", "xml", "")]);
		#end
	}

	function selectXML(e:Event):Void
	{
		trace("select xml");
		fileUploader.load();
	}

	function loadXML(e:Event):Void
	{
		trace("load xml");
		fileUploader.removeEventListener(Event.SELECT, selectXML);
		fileUploader.removeEventListener(Event.COMPLETE, loadXML);

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
