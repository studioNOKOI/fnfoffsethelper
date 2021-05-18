package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();

		var tex:FlxAtlasFrames;
		antialiasing = true;

		// make sure the images are in assets/images/<your-character>.png and assets/images/<your-character>.xml then change them below
		tex = FlxAtlasFrames.fromSparrow(AssetPaths.DADDY_DEAREST__png, AssetPaths.DADDY_DEAREST__xml);
		frames = tex;

		// make sure to change the animation names to match your xml file animation names
		// if you add more than 5 animations, be sure to add them to the currentState array in PlayState.hx
		animation.addByPrefix('idle', 'Dad idle dance', 24);
		animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
		animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
		animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
		animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

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
