import java.util.*;  
import processing.serial.*;
import javax.swing.*; //for serial port prompt


DisposeHandler dh;

int lf = 10;  // linefeed in ASCII
String delimeter = " "; // Serial data delimeter
String mystring = null; //raw serial data
float[] serialdata = new float[9]; //serial data split in 2 numbers
Serial myport;  // serial port

Keyboard keyboard;
//TouchSensor touchsensor;

color bg;
float e = 0.0;

String configfile = "config.xml";
XML config;
float xmin;
float xmax;
float pmin;
float pmax;

float xinc = 0.01; // Position increment
float pinc = 0.01; // Pressure increment
float minc = 1;


Boolean iscalibrating = false;

void setup() {
    
    size(1600, 800, P2D);
    surface.setResizable(true); // allow the canvas to be resized
    pixelDensity(displayDensity()); // renders hq if retina display
    
    println((Object)Serial.list()); //print available serial ports to console
    

    initializeTouchSensor();
    //myport = new Serial(this, "COM84", 115200);
    
    //myport.clear(); // throw out the first reading, in case we started reading in the middle of a string from the sender
    //mystring = myport.readStringUntil(lf);
    //mystring = null;
    
    colorMode(HSB, 360, 100, 100, 100); // Hue (0-360), Saturation (0-100), Brightness (0-100), alpha (0-100)
    smooth(8); // Set anti-aliasing for shapes to maximum smoothing
    
    bg = color(218, 21, 36);
    
    dh = new DisposeHandler(this);
    
    config = loadXML(configfile);
    xmin = config.getChild("position").getFloat("min");
    xmax = config.getChild("position").getFloat("max");
    pmin = config.getChild("pressure").getFloat("min");
    pmax = config.getChild("pressure").getFloat("max");
    
    
    //keyboard = new Keyboard(loadJSONObject("keyboardMac.json"));
    keyboard = new Keyboard(loadXML("keyboardMac.xml"));
    keyboard.setSize(100);
    keyboard.setWidth(width);
    
    
}

void draw() {
    background(bg);
    
    readSerialData();
    
    //keyboard.setActivePressures(discretePositionPressure(0.35, 0.6, 36, new float[]{0.0, 1.0}, new float[]{0.0, 1.0}));
    //keyboard.setActivePressures(touchsensor.readInterpolatedArray(keyboard.getEnabledKeyCount()));
    //keyboard.setActivePressures(interpolatedPositionPressure(e, 1.0, keyboard.getEnabledKeyCount(), new float[] { 0.0, 1.0 }, new float[] { 0.0, 1.0 }));
    keyboard.setActivePressures(discretePositionPressure(serialdata[2], serialdata[3], keyboard.getEnabledKeyCount(), new float[] { xmax, xmin }, new float[] { pmin, pmax }));
    //keyboard.setActivePressures(interpolatedPositionPressure(serialdata[2], serialdata[3], keyboard.getEnabledKeyCount(), new float[] { xmax, xmin }, new float[] { pmin, pmax }));
    
    if (mousePressed == true)
    {
        println("clicked");
        TouchPoint ctp = keyboard.isEnabledKeyInBounds(mouseX, mouseY);
        if (ctp != null)
            println(ctp.getMarkerLabel());
    }
    
    keyboard.update();
}


/*
 * 
 * 
 */
void initializeTouchSensor()
{
    try {
        Object selection;
        String port = "";
        
        if (Serial.list().length > 0) {
            //if there are multiple ports available, ask which one to use
            selection = JOptionPane.showInputDialog(frame, "Select serial port number to use:\n", "Setup", JOptionPane.PLAIN_MESSAGE, null, Serial.list(), Serial.list()[0]);
            if (selection == null)
                exit();
            
            println(selection);
            port = selection.toString();
            println(port);
            myport = new Serial(this, "COM84", 115200);
            
            myport.clear(); // throw out the first reading, in case we started reading in the middle of a string from the sender
            mystring = myport.readStringUntil(lf);
            mystring = null;
            //xScale();
            //yScale();
            //println(time);
        }
        else
        {
            JOptionPane.showMessageDialog(frame, "Device is not connected to the PC");
            exit();
        }
    }
    catch (Exception e)
    {
        JOptionPane.showMessageDialog(frame, "COM port is not available (may\nbe in use by another program)");
        println("Error:", e); //Print the type of error
        exit();
    }
}


void readSerialData()
{
    while (myport.available() > 0) {
        mystring = myport.readStringUntil(lf);
    }
    
    if (mystring != null) {
        serialdata = float(split(mystring, delimeter)); //split raw data into 2 numbers
        println(serialdata);
    }
}

/*
 * 
 * return the discrete 
 */
float[] discretePositionPressure(float position, float pressure, int poslength, float[] posrange, float[] pressurerange)
{
    float[] p = new float[poslength]; // Same length as the number of touch points
    
    float h = map(position, posrange[0], posrange[1], 0, poslength - 1);
    float g = map(pressure, pressurerange[0], pressurerange[1], 0, 100);
    
    // Coerce the range
    h = (h > poslength - 1)? poslength - 1 : h; // Coerce if greater than poslength - 1
    h = (h < 0)? 0 : h; // Coerce if less than 0
    
    g = (g > 100)? 100 : g; // Coerce if greater than 100
    g = (g < 0)? 0 : g; // Coerce if less than 0
    
    p[round(h)] = g;
    
    return p;
}


/*
 * 
 * Returns an array of interpolated 
 */
float[] interpolatedPositionPressure(float position, float pressure, int poslength, float[] posrange, float[] pressurerange)
{
    float[] p = new float[poslength]; // Same length as the number of touch points
    
    float h = map(position, posrange[0], posrange[1], 0, poslength - 1);
    float g = map(pressure, pressurerange[0], pressurerange[1], 0, 100);
    
    // Coerce the range
    h = (h > poslength - 1)? poslength - 1 : h; // Coerce if greater than poslength - 1
    h = (h < 0)? 0 : h; // Coerce if less than 0
    
    g = (g > 100)? 100 : g; // Coerce if greater than 100
    g = (g < 0)? 0 : g; // Coerce if less than 0
    
    if (floor(h) == ceil(h))
    {
        p[floor(h)] = g;
    }
    else
    {
        p[ceil(h)] = (h - floor(h))*g;
        p[floor(h)] = (ceil(h) - h)*g;
    }
    
    return p;
}

void mouseWheel(MouseEvent event)
{
    //e += 0.001*event.getCount();
    //e = (e > 1)? 1 : e;
    //e = (e < 0)? 0 : e;
    
    if (keyPressed && (key == CODED))
    {
        if (keyCode == LEFT)
        {
            xmin += xinc*event.getCount();
        }
        else if (keyCode == RIGHT)
        {
            xmax += xinc*event.getCount();
        }
        else if (keyCode == DOWN)
        {
            pmin += pinc*event.getCount();
        }
        else if (keyCode == UP)
        {
            pmax += pinc*event.getCount();
        }
    }
}
