import skyui.widgets.WidgetBase;

class skyui.widgets.cfslevelup.LevelUpWidget extends WidgetBase
{	
  /* STAGE ELEMENTS */
	
	public var archeryText: TextField;
	public var healthText: TextField;
	public var healthCursor: MovieClip;
	public var archeryCursor: MovieClip;
  
  
  /* INITIALIZATION */

	public function LevelUpWidget()
	{
		super();
		
		_visible = false;
		archeryText.text = "0";
		healthText.text = "0";
		healthCursor.visible = false;
		archeryCursor.visible = false;
	}


  /* PUBLIC FUNCTIONS */
  
	// @overrides WidgetBase
	public function getWidth(): Number
	{
		return _width;
	}

	// @overrides WidgetBase
	public function getHeight(): Number
	{
		return _height;
	}

	// @Papyrus Global
	public function setVisible(a_visible: Boolean): Void
	{
		_visible = a_visible;
	}
	
	// @Papyrus Cursors
	public function healthCursorV(a_visible: Boolean): Void
	{
		healthCursor._visible = Boolean(a_visible);
	}
	public function archeryCursorV(a_visible: Boolean): Void
	{
		archeryCursor._visible = Boolean(a_visible);
	}
	// @Papyrus Level/Att/Skill Values
	public function setArchery(a_count: Number): Void
	{
		archeryText.text = String(a_count);
	}
	public function setHealth(a_count: Number): Void
	{
		healthText.text = String(a_count);
	}
}