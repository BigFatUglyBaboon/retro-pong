// yoinked from https://www.shadertoy.com/view/WsVSzV

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


float warp = 0.25; // simulate curvature of CRT monitor
float scan = 0.45; // simulate darkness between scanlines

uniform vec2 u_resolution;
uniform sampler2D texture;


void main(void)
	{
    // squared distance from center
    vec2 uv = gl_FragCoord.xy/u_resolution.xy;
    vec2 dc = abs(0.5-uv);
    dc *= dc;
    
    // warp the fragment coordinates
    uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.3*warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.4*warp)); uv.y += 0.5;

    // sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
        gl_FragColor = vec4(0.0,0.0,0.0,1.0);
    else
    	{
        // determine if we are drawing in a scanline
        float apply = abs(sin(gl_FragCoord.y)*0.5*scan);
        // sample the texture
    	gl_FragColor = vec4(mix(texture2D(texture,uv).rgb,vec3(0.0),apply),1.0);
	}
}

