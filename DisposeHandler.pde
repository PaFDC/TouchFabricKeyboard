public class DisposeHandler
{
    DisposeHandler(PApplet pa)
    {
        pa.registerMethod("dispose", this);
    }
   
  public void dispose()
  {      
    println("Closing sketch");
    
    config.getChild("position").setFloat("min", xmin);
    config.getChild("position").setFloat("max", xmax);
    config.getChild("pressure").setFloat("min", pmin);
    config.getChild("pressure").setFloat("max", pmax);
    saveXML(config, "data" + File.separator + configfile);
  }
}
