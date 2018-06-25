
// 
// 


public class Keyboard
{
    
    private int _keycount;              // Number of keys on the keyboard (enabled and disabled)
    private int _enabledkeycount;       // Number of enabled keys on the keyboard
    private int _rowcount;              // Number of rows 
    
    private float _width;               // 
    private float _height;              // 
    private float _originalwidth;       //
    private float _originalheight;      //
    private float _aspectratio;         //
    
    private float _topmargin;
    private float _bottommargin;
    private float _leftmargin;
    private float _rightmargin;
    

    
    
    
    TouchPoint[] Keys;                  // 
    TouchPoint[] EnabledKeys;           // 
    
    List<TouchPoint> KeysList = new ArrayList<TouchPoint>();
    List<TouchPoint> EnabledKeysList = new ArrayList<TouchPoint>();
    
    // JSON Constructor
    public Keyboard(JSONObject keyboard)
    {
        // Read the 2-dimensional jagged array of key objects
        JSONArray keyboardrows = keyboard.getJSONArray("keys");
        
        _keycount = 0;
        _enabledkeycount = 0;
        _rowcount = keyboardrows.size(); //
        for (int i = 0; i < _rowcount; i++) {
            _keycount += keyboardrows.getJSONArray(i).size();
        }
                
        
        Keys = new TouchPoint[_keycount];
    
        EnabledKeys = new TouchPoint[36];
    
        int t = 0;
        float distx = 0.0; // Distance counter
        float disty = 0.0;
        for (int i = 0; i < keyboardrows.size(); i++) {
            JSONArray keys = keyboardrows.getJSONArray(i);
            distx = 0.0; // Distance counter
            disty += 1.1;
            
            for (int j = 0; j < keys.size(); j++) {
                JSONObject k = keys.getJSONObject(j);
                JSONArray size = keyboard.getJSONArray(k.getString("size")); // Convoluted, tries to use "references" to other JSON objects
                JSONArray position = k.getJSONArray("position");
                Keys[t] = new TouchPoint(createShape(RECT, -size.getFloat(0)/2, -size.getFloat(1)/2, size.getFloat(0), size.getFloat(1), .2));
                
                if (k.getBoolean("overrideposition")) {
                    Keys[t].setCenterPosition(position.getFloat(0), position.getFloat(1));
                } else {
                    Keys[t].setCenterPosition(distx + size.getFloat(0)/2, disty + size.getFloat(1)/2);
                }
                distx += size.getFloat(0) + keyboard.getFloat("spacing");
                
                Keys[t].setMarkerLabel(k.getString("name"));
                Keys[t].setEnabled(k.getBoolean("enabled"));
                Keys[t].setDrawDisabled(true);
                if (Keys[t].isEnabled()) { // Debugging
                    println("Name: " + k.getString("name") + ", size: [" + size.getFloat(0) + ", " + size.getFloat(1) + "], index: " + k.getInt("index"));
                    EnabledKeys[(int)k.getFloat("index")] = Keys[t];
                }
                
                //println("Name: " + k.getString("name") + ", size: [" + size.getFloat(0) + ", " + size.getFloat(1) + "], index: " + k.getInt("index"));
                t++;
            }
        }
    }
    
    // XML Constructor
    public Keyboard(XML keyboard)
    {
        XML keys = keyboard.getChild("keys");                              // Get the intermediate keyrows object
        XML[] keyrow = keys.getChildren("keyrow");                         // Get a list of the keyrows
        
        _topmargin = keyboard.getChild("margin").getFloat("top");
        _leftmargin = keyboard.getChild("margin").getFloat("left");
        _rightmargin = keyboard.getChild("margin").getFloat("right");
        _bottommargin = keyboard.getChild("margin").getFloat("bottom");
        
        float distx;
        float disty = _topmargin;
        for (int i = 0; i < keyrow.length; i++)
        {
            float rowheight = keyrow[i].getFloat("rowheight");
            float rowspacing = keyrow[i].getFloat("rowspacing");
            float keyspacing = keyrow[i].getFloat("keyspacing");
            
            distx = _leftmargin;
            
            XML[] k = keyrow[i].getChildren("key");
            
            for (int j = 0; j < k.length; j++)
            {
                XML tmp = keyboard.getChild(k[j].getString("size")); // Poor man's cross-reference to object...
                
                // RECT centerx, centery, width, height
                rectMode(CENTER);
                float keywidth = tmp.getFloat("width");
                float keyheight = tmp.getFloat("height");
                TouchPoint tp = new TouchPoint(createShape(RECT, 0, 0, keywidth, keyheight, keyboard.getChild("keybevel").getFloat("value")));
                
                float offsetx = k[j].getFloat("x");
                float offsety = k[j].getFloat("y");
                
                tp.setCenterPosition(distx + keywidth/2, disty + keyheight/2);
                tp.offsetCenterPosition(k[j].getFloat("x"), k[j].getFloat("y"));
                
                distx += keywidth + keyspacing;
                
                tp.setDrawDisabled(true); // Draw even if disabled
                tp.setMarkerLabel(k[j].getString("name"));
                if (Boolean.parseBoolean(k[j].getString("enabled"))) {
                    tp.setEnabled(true);
                    EnabledKeysList.add(tp);
                } else {
                    tp.setEnabled(false);
                }
                
                KeysList.add(tp);
            }
            
            disty += rowheight + rowspacing;
            
        }
        
        Keys = new TouchPoint[KeysList.size()];
        Keys = KeysList.toArray(Keys);
        
        Collections.sort(EnabledKeysList);
        
        EnabledKeys = new TouchPoint[EnabledKeysList.size()];
        EnabledKeys = EnabledKeysList.toArray(EnabledKeys);
        
                
        for (int i = 0; i < EnabledKeys.length; i++)
        {
            println(EnabledKeys[i].getMarkerLabel());
        }
        
        _keycount = Keys.length;
        _enabledkeycount = EnabledKeys.length;
        
    }
    
    
    
    public void update()
    {
        for (TouchPoint k : Keys) {
            k.update();
        }
        
    }
    
    
    
    public void setExtents()
    {
        
        
    }
    
    public void setWidth(float keyboardwidth)
    {
        
        
        
    }
    
    public void setHeight(float keyboardheight)
    {
        
        
        
    }
    
    public void setCenter(float centerx, float centery)
    {
        
    }
    
    public void setReference()
    {
        
        
    }
    
    public void setActivePressures(float[] pressure)
    {
        for (int i = 0; i < EnabledKeys.length; i++) {
            EnabledKeys[i].setNormalizedPressure(pressure[i]);
        }
        
    }
    
    public void setSize(float x)
    {
        for (TouchPoint k : Keys) {
            k.setSize(x);
        }
    }
    
    public int getKeyCount()
    {
        return _keycount;
    }
    
    public int getEnabledKeyCount()
    {
        return _enabledkeycount;
    }
    
    public TouchPoint isKeyInBounds(float x, float y)
    {
        TouchPoint bk = null;
        for (TouchPoint k : Keys) {
            if (k.isInBounds(x, y))
                bk = k;
        }
        return bk;
    }
    
    public TouchPoint isEnabledKeyInBounds(float x, float y)
    {
        TouchPoint bk = null;
        for (TouchPoint k : EnabledKeys) {
            if (k.isInBounds(x, y))
                bk = k;
        }
        return bk;
    }
    
    
    
}
