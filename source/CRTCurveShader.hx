package;

import flixel.system.FlxAssets.FlxShader;

class CRTCurveShader extends FlxShader
{
	@:glFragmentSource('
    #pragma header
    float warp = 0.75; // simulate curvature of CRT monitor
    float scan = 0.75; // simulate darkness between scanlines

    void main()
    {
        // gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);
        // squared distance from center
        vec2 uv = openfl_TextureCoordv;
        vec2 fragCoord = openfl_TextureCoordv;
        vec2 dc = abs(0.5-uv);
        dc *= dc;
        
        // warp the fragment coordinates
        uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.3*warp)); uv.x += 0.5;
        uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.4*warp)); uv.y += 0.5;

        // sample inside boundaries, otherwise set to black
        if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
        {
            gl_FragColor = vec4(0.0,0.0,0.0,1.0);
        }
        else
        {
            // determine if we are drawing in a scanline
            float apply = abs(sin(fragCoord.y)*0.5*scan);
            // sample the texture
            gl_FragColor = vec4(mix(flixel_texture2D(bitmap,uv).rgb,vec3(0.0),apply),1.0);
        }
    }
    ')
	public function new()
	{
		super();
	}
}
