package;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.xml.Parser;
import openfl.display.BitmapData;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new(x:Float, y:Float, sprite:BitmapData, xml:String)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();

		var tex:FlxAtlasFrames;
		antialiasing = true;

		// make sure the images are in assets/images/<your-character>.png and assets/images/<your-character>.xml then change them below
		tex = FlxAtlasFrames.fromSparrow(sprite, xml);
		frames = tex;

		var animArray:Array<String>;

		// make sure to change the animation names to match your xml file animation names
		// if you add more than 5 animations, be sure to add them to the currentState array in PlayState.hx
		animation.addByPrefix('idle', 'brandon idle', 24);
		animation.addByPrefix('singUP', 'brandon up', 24);
		animation.addByPrefix('singRIGHT', 'brandon right', 24);
		animation.addByPrefix('singDOWN', 'brandon down', 24);
		animation.addByPrefix('singLEFT', 'brandon left', 24);

		// i think you need to also do this for any new added poses but im not sure, haven't tried
		addOffset('idle');
		addOffset("singUP");
		addOffset("singRIGHT");
		addOffset("singLEFT");
		addOffset("singDOWN");

		playAnim('idle');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
