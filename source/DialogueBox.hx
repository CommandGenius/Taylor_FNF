package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitMids:FlxSprite;
	var portraitMads:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		if (PlayState.isStoryMode)
		{
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'senpai':
					FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'thorns':
					FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'tutorial':
					FlxG.sound.playMusic(Paths.music('LunchBlox', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'bopeebo':
						FlxG.sound.playMusic(Paths.music('daddiTalki', 'shared'), 0);
						FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'fresh':
					FlxG.sound.playMusic(Paths.music('daddiTalki', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'dadbattle':
					FlxG.sound.playMusic(Paths.music('daddiTalki', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'cliche':
					FlxG.sound.playMusic(Paths.music('blug', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'drama':
					FlxG.sound.playMusic(Paths.music('blug', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'liwake':
					FlxG.sound.playMusic(Paths.music('blug', 'shared'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
			}
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		if (PlayState.isStoryMode)
		{
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'senpai':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
					box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
					box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
				case 'roses':
					hasDialog = true;
					FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

					box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
					box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
					box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

				case 'thorns':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
					box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
					box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

					var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
					face.setGraphicSize(Std.int(face.width * 6));
					add(face);
				case 'tutorial':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'bopeebo':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'fresh':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'dadbattle':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'cliche':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'drama':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
				case 'liwake':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByPrefix('normal', 'speech bubble normal', 24);
					box.antialiasing = true;
					box.width = 200;
					box.height = 200;
					box.x = -100;
					box.y = 375;
					box.flipX = true;
			}
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai' | 'roses' | 'thorns':
			{
				portraitLeft = new FlxSprite(-20, 40);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
				portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}
			case 'tutorial':
			{
				portraitLeft = new FlxSprite(-1500, 10);
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/gfPortrait', 'shared');
				portraitLeft.animation.addByPrefix('enter', 'GF Portrait Enter instance 1', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.175));
				portraitLeft.antialiasing = true;
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}
			case 'bopeebo' | 'fresh' | 'dadbattle':
			{
				portraitLeft = new FlxSprite(-1500, 51);
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/dadPortrait', 'shared');
				portraitLeft.animation.addByPrefix('enter', 'Dad Portrait Enter instance 1', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
				portraitLeft.antialiasing = true;
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}
			case 'cliche' | 'drama' | 'liwake':
			{
				portraitLeft = new FlxSprite(-1500, 51);
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/taylorPortrait', 'shared');
				portraitLeft.animation.addByPrefix('enter', 'Taylor Portrait Enter instance 1', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
				portraitLeft.antialiasing = true;
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}
		}

		portraitMids = new FlxSprite(-1500, 51);
		portraitMids.frames = Paths.getSparrowAtlas('portraits/taylorPortrait2', 'shared');
		portraitMids.animation.addByPrefix('enter', 'Taylor Portrait 2 Enter instance 1', 24, false);
		portraitMids.setGraphicSize(Std.int(portraitMids.width * PlayState.daPixelZoom * 0.15));
		portraitMids.antialiasing = true;
		portraitMids.updateHitbox();
		portraitMids.scrollFactor.set();
		add(portraitMids);
		portraitMids.visible = false;

		portraitMads = new FlxSprite(-1500, 51);
		portraitMads.frames = Paths.getSparrowAtlas('portraits/taylorPortrait3', 'shared');
		portraitMads.animation.addByPrefix('enter', 'Taylor Portrait 3 Enter instance 1', 24, false);
		portraitMads.setGraphicSize(Std.int(portraitMads.width * PlayState.daPixelZoom * 0.15));
		portraitMads.antialiasing = true;
		portraitMads.updateHitbox();
		portraitMads.scrollFactor.set();
		add(portraitMads);
		portraitMads.visible = false;

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai' | 'roses' | 'thorns':
			{
				portraitRight = new FlxSprite(0, 40);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
			}
			case 'tutorial' | 'bopeebo' | 'fresh' | 'dadbattle' | 'cliche' | 'drama' | 'liwake':
			{
				portraitRight = new FlxSprite(0, 44);
				portraitRight.frames = Paths.getSparrowAtlas('portraits/boyfriendPortrait', 'shared');
				portraitRight.animation.addByPrefix('enter', 'BF Portrait Enter instance 1', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
				portraitRight.antialiasing = true;
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
			}
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);
		portraitMids.screenCenter(X);
		portraitMads.screenCenter(X);

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
			add(handSelect);


				if (!talkingRight)
				{
					// box.flipX = true;
				}
		}

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);
		}
		else if (PlayState.SONG.song.toLowerCase() == 'tutorial' || PlayState.SONG.song.toLowerCase() == 'bopeebo' || PlayState.SONG.song.toLowerCase() == 'fresh' || PlayState.SONG.song.toLowerCase() == 'dadbattle' || PlayState.SONG.song.toLowerCase() == 'cliche' || PlayState.SONG.song.toLowerCase() == 'drama' || PlayState.SONG.song.toLowerCase() == 'liwake')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Anime Ace 2.0 BB';
			dropText.color = 0xFFD99495;
			dropText.antialiasing = true;
			add(dropText);
		}

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai' | 'roses' | 'thorns':
			{
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Pixel Arial 11 Bold';
				swagDialogue.color = 0xFF3F2021;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				add(swagDialogue);
			}
			case 'tutorial':
			{
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Anime Ace 2.0 BB';
				swagDialogue.color = FlxColor.BLACK;
				swagDialogue.antialiasing = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				add(swagDialogue);
			}
			case 'bopeebo' | 'fresh' | 'dadbattle':
			{
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Anime Ace 2.0 BB';
				swagDialogue.color = FlxColor.BLACK;
				swagDialogue.antialiasing = true;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dearestText'), 0.6)];
				add(swagDialogue);
			}
			case 'cliche' | 'drama' | 'liwake':
			{
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Anime Ace 2.0 BB';
				swagDialogue.color = FlxColor.BLACK;
				swagDialogue.antialiasing = true;
				add(swagDialogue);
			}
		}

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'tutorial' || PlayState.SONG.song.toLowerCase() == 'bopeebo' || PlayState.SONG.song.toLowerCase() == 'fresh' || PlayState.SONG.song.toLowerCase() == 'dadbattle' || PlayState.SONG.song.toLowerCase() == 'cliche' || PlayState.SONG.song.toLowerCase() == 'drama' || PlayState.SONG.song.toLowerCase() == 'liwake')
						FlxG.sound.music.fadeOut(2.2, 0);

						new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitMids.visible = false;
						portraitMads.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					box.flipX = true;
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitMids.visible = false;
				portraitMads.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					box.flipX = false;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				}
			case 'taydad':
				portraitRight.visible = false;
				portraitMids.visible = false;
				portraitMads.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					box.flipX = true;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				}
			case 'taydadnoanim':
				portraitRight.visible = false;
				portraitMids.visible = false;
				portraitMads.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					portraitLeft.animation.finish();
				}
			case 'taydadseq':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMads.visible = false;
				if (!portraitMids.visible)
				{
					portraitMids.visible = true;
					portraitMids.animation.play('enter');
					box.flipX = true;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				}
			case 'taydadseqnoanim':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMads.visible = false;
				if (!portraitMids.visible)
				{
					portraitMids.visible = true;
					portraitMids.animation.play('enter');
					portraitMids.animation.finish();
				}
			case 'taydadtreq':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMids.visible = false;
				if (!portraitMads.visible)
				{
					portraitMads.visible = true;
					portraitMads.animation.play('enter');
					box.flipX = true;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				}
			case 'taydadtreqnoanim':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMids.visible = false;
				if (!portraitMads.visible)
				{
					portraitMads.visible = true;
					portraitMads.animation.play('enter');
					portraitMads.animation.finish();
				}
			case 'pixdad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'pixbf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
