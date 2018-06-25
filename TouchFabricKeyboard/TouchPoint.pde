
public class TouchPoint implements Comparable<TouchPoint>
{
    private PShape _TouchMarker;
    private float _markerwidth;
    private float _markerheight;
    
    private color _markerstroke = color(0, 0, 100);
    private float _markerstrokeweight = 0.06;
    private color _markercolor = color(0, 0, 100, 0);
    private color _markercolordisabled = color(0, 0, 50, 0);
    private color _markerstrokedisabled = color(0, 0, 50);
    
    private float _x = 0.0;
    private float _y = 0.0;
    
    private float _scale = 1.0;
    
    private String _markerlabel = "";
    private boolean _enabled = true;
    private boolean _drawdisabled = true;
    private boolean _drawindex = true;
    
    // Constructor
    public TouchPoint(PShape tMarker)
    {
        _TouchMarker = tMarker;
        _markerwidth = _TouchMarker.getWidth();
        _markerheight = _TouchMarker.getHeight();
    }
    
    // Update method draws the touchpoint when it is called
    public void update()
    {
        if (_drawdisabled && !_enabled) // If the touchpoint is not enabled but can be drawn
        {
            _TouchMarker.setStroke(_markerstrokedisabled);
            _TouchMarker.setStrokeWeight(_markerstrokeweight);
            _TouchMarker.setFill(_markercolordisabled);
            shape(_TouchMarker, _x, _y);
            //text(_markerlabel, _x + _markerwidth/2, _y + _markerheight/2);
            textSize(20);
            text(_markerlabel, _x - textWidth(_markerlabel)/2.0, _y + 5);
        }
        else if (_enabled)
        {
            _TouchMarker.setStroke(_markerstroke);
            _TouchMarker.setStrokeWeight(_markerstrokeweight);
            _TouchMarker.setFill(_markercolor);
            shape(_TouchMarker, _x, _y);
            //text(_markerlabel, _x + _markerwidth/2, _y + _markerheight/2);
            textSize(20);
            text(_markerlabel, _x - textWidth(_markerlabel)/2.0, _y + 5);
            if (_drawindex) {
                         
            }
        }
    }
    
    @Override
    public String toString()
    {
        return "";
    }
    
    @Override
    public int compareTo(TouchPoint tp)
    {
        if (this._x == tp._x)
        {
            return 0;
        }
        else
        {
            return this._x > tp._x? 1 : -1;
        }
    }
    
    public void setTextPosition()
    {
        
    }
    
    
    
    // 
    public void setPressureColor(float alphaPressure)
    {
        
    }
    
    // 
    public void setPressureColor(color pressureColor)
    {
        _markercolor = color(pressureColor);
    }
    
    // 
    public void setNormalizedPressureColor(float n)
    {
        //_markercolor
    }
    
    public void setNormalizedPressure(float n)
    {
        //n = (n > 0.0)? n : 0.0;
        //n = (n < 1.0)? n : 1.0;
        
        
        _markercolor = color(0, 0, 100, n);
    }
    
    // 
    public void setCenterPosition(float x, float y)
    {
        _x = x;
        _y = y;
    }
    
    // 
    public void setCenterPosition(PVector position)
    {
        _x = position.x;
        _y = position.y;
    }
    
    // 
    public void offsetCenterPosition(float x, float y)
    {
        _x += x;
        _y += y;
    }
    
    // 
    public void offestCenterPosition(PVector offset)
    {
        _x += offset.x;
        _y += offset.y;
    }
    
    // 
    public void setMarkerLabel(String str)
    {
        _markerlabel = str;
    }
    
    public String getMarkerLabel()
    {
        return _markerlabel;
    }
    
    public void setEnabled(boolean enabled)
    {
        _enabled = enabled;
    }
    
    public void setDrawDisabled(boolean drawdisabled)
    {
        _drawdisabled = drawdisabled;
    }
    
    public void setSize(float x)
    {
        _TouchMarker.scale(x/_scale);
        _x *= x/_scale;
        _y *= x/_scale;
        _scale = x;
        _markerwidth = _TouchMarker.getWidth();
        _markerheight = _TouchMarker.getHeight();
    }
    
    Boolean isEnabled()
    {
        return _enabled;
    }
    
    float getX()
    {
        return _x;
    }
    
    float getY()
    {
        return _y;
    }
    
    // Return whether or not a 
    Boolean isInBounds(float x, float y)
    {
        return
        ((_x - _markerwidth/2.0 <= x) && (_x - _markerwidth/2.0 >= x)) &&
        ((_y - _markerheight/2.0 <= y) && (_y - _markerheight/2.0 >= y));
    }
    
    // Return whether or not a 
    Boolean isInBounds(PVector position)
    {
        //position.x;
        //position.y;
        
        
        return false;
    }
}
