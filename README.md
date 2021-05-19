# Friday Night Funkin' Character Offset Tool (FNFCOT)
tool to help determine character animation offsets for friday night funkin'
demo of how it works here https://studionokoi.github.io/fnfoffset/

# How to use
1. Add your character png and xml files into assets/images

![image](https://user-images.githubusercontent.com/63418160/118844882-50cc3780-b899-11eb-9643-2e29f5b9daf1.png)

2. Replace "brandon__png" and "brandon__xml" in Character.hx with the names of the png and xml you added in step 1.

![image](https://user-images.githubusercontent.com/63418160/118845211-91c44c00-b899-11eb-9841-4b495732f2b0.png)

3. Change the animation names in Character.hx to the names in your xml file.

![image](https://user-images.githubusercontent.com/63418160/118845305-ab659380-b899-11eb-86eb-68ab0486583a.png)

If you have more animations, you can add them as well. Extra animations should also be added here in PlayState.hx

![image](https://user-images.githubusercontent.com/63418160/118845472-cfc17000-b899-11eb-8402-92f7319ded74.png)

4. Build the program. I prefer to use "lime test html5". If you're struggling with this step, refer to README.md at https://github.com/ninjamuffin99/Funkin/

5. Use the ARROW KEYS to match up the bottom bounds of your character with the bottom bounds of the dad. When you are done, press ENTER.

![image](https://user-images.githubusercontent.com/63418160/118845932-347cca80-b89a-11eb-90a3-2414168f8736.png)

The "Game Offset" value is what you should add to the dad.x and dad.y values in PlayState.hx in the actual Friday Night Funkin' files.

![image](https://user-images.githubusercontent.com/63418160/118846236-86255500-b89a-11eb-8b6e-d7ae6fed5174.png)

6. Press space to cycle through animations. Move the character with the ARROW KEYS and note the offset values when you get the character aligned with the reference beneath it.

![image](https://user-images.githubusercontent.com/63418160/118846530-cc7ab400-b89a-11eb-89f6-364c2c8b93ec.png)

The X and Y values are what you set the offsets to in Character.hx in the Friday Night Funkin' files.

![image](https://user-images.githubusercontent.com/63418160/118846663-f46a1780-b89a-11eb-8dab-bb7395f83c0d.png)


# Enjoy!!
I hope you enjoy this program. If you like it, consider following me on twitter here: https://twitter.com/studioNOKOI
You don't have to credit me if you use this in any mods, but I'd like you to show me what you make with it :)
Have fun!
