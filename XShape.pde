
public class XShape extends PShape
{
    
    XShape()
    {
        
        
    }
    
    
    
    public Boolean hitDetect()
    {
        
        for (int i = 0; i < this.getVertexCount(); i++) {
            PVector v = this.getVertex(i);
            v.x += random(-1, 1);
            v.y += random(-1, 1);
            this.setVertex(i, v);
        }
        
        return false;
    }
    
    public PShape getAxisAlignedBoundingBox()
    {
        
        return new PShape();
        
    }
    
    
}
