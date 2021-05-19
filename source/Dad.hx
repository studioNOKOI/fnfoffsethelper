package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Dad extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();

		var tex:FlxAtlasFrames;
		antialiasing = true;

		tex = FlxAtlasFrames.fromSparrow(AssetPaths.DADDY_DEAREST__png, AssetPaths.DADDY_DEAREST__xml);
		frames = tex;

		animation.addByPrefix('idle', 'Dad idle dance', 24);
		addOffset('idle');
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
