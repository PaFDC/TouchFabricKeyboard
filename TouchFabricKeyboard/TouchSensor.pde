public class TouchSensor
{
    private PApplet _ref;
    
    private String _serialport = null;
    private long _baudrate = 115200;
    private String _delimiter = " ";
    
    private int _discretepoints = 36;
    
    private Serial _serialObject;
    
    public TouchSensor(PApplet ref, String serialport)
    {
        _ref = ref;
        _serialport = serialport;
    }
    
    public TouchSensor(String serialport, long buadrate)
    {
        //_ref = ref;
        _serialport = serialport;
        _baudrate = buadrate;
    }
    
    public TouchSensor(String serialport, long buadrate, String delimiter)
    {
        //_ref = ref;
        _serialport = serialport;
        _baudrate = buadrate;
        _delimiter = delimiter;
    }
    
    public void begin()
    {
        //_serialObject = new Serial(_ref, _serialport, _baudrate);
        
        _serialObject.clear(); // throw out the first reading, in case we started reading in the middle of a string from the sender
        mystring = _serialObject.readStringUntil(lf);
        mystring = null;
    }
    
    
    public void end()
    {
        if (_serialObject != null)
            _serialObject.stop();
    }
    
    
    public void read()
    {
        
        
    }
    
    
    public float[] readAsFloatArray()
    {
        
        return new float[] { 0 };
        
    }
    
    public int setDiscretePoints(int discretepoints)
    {
        if (discretepoints < 1)
            discretepoints = 1;
        return _discretepoints;
    }
    
    public int getDiscretePoints()
    {
        return _discretepoints;
    }
    
    
    void setPositionRange(float min, float max)
    {
        
        
    }
    
    void setPressureRange(float min, float max)
    {
        
        
    }
    
    
    
    /*
     * 
     * return the discrete 
     */
    //float[] readDiscreteArray(int arraylength)
    //{
    //    float[] p = new float[poslength]; // Same length as the number of touch points
        
    //    float h = map(position, posrange[0], posrange[1], 0, poslength - 1);
    //    float g = map(pressure, pressurerange[0], pressurerange[1], 0, 100);
        
    //    // Coerce the range
    //    h = (h > poslength - 1)? poslength - 1 : h; // Coerce if greater than poslength - 1
    //    h = (h < 0)? 0 : h; // Coerce if less than 0
        
    //    g = (g > 100)? 100 : g; // Coerce if greater than 100
    //    g = (g < 0)? 0 : g; // Coerce if less than 0
        
    //    p[round(h)] = g;
        
    //    return p;
    //}
    
    
    /*
     * 
     * Returns an array of interpolated 
     */
    //float[] readInterpolatedArray(int arraylength)
    //{
    //    float[] p = new float[arraylength]; // Same length as the number of touch points
        
    //    float h = map(position, posrange[0], posrange[1], 0, poslength - 1);
    //    float g = map(pressure, pressurerange[0], pressurerange[1], 0, 100);
        
    //    // Coerce the range
    //    h = (h > poslength - 1)? poslength - 1 : h; // Coerce if greater than poslength - 1
    //    h = (h < 0)? 0 : h; // Coerce if less than 0
        
    //    g = (g > 100)? 100 : g; // Coerce if greater than 100
    //    g = (g < 0)? 0 : g; // Coerce if less than 0
        
    //    if (floor(h) == ceil(h))
    //    {
    //        p[floor(h)] = g;
    //    }
    //    else
    //    {
    //        p[ceil(h)] = (h - floor(h))*g;
    //        p[floor(h)] = (ceil(h) - h)*g;
    //    }
        
    //    return p;
    //}
    
}
