// yoinked from https://www.shadertoy.com/view/lsXGWn

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 u_resolution;
uniform sampler2D texture;

const float blurSize = 1.0/512.0;
const float intensity = 0.35;

void main(void)
{
   vec4 sum = vec4(0);
   vec2 texcoord = gl_FragCoord.xy/u_resolution.xy;
   int j;
   int i;

   //thank you! http://www.gamerendering.com/2008/10/11/gaussian-blur-filter-shader/ for the 
   //blur tutorial
   // blur in y (vertical)
   // take nine samples, with the distance blurSize between them
   sum += texture(texture, vec2(texcoord.x - 4.0*blurSize, texcoord.y)) * 0.05;
   sum += texture(texture, vec2(texcoord.x - 3.0*blurSize, texcoord.y)) * 0.09;
   sum += texture(texture, vec2(texcoord.x - 2.0*blurSize, texcoord.y)) * 0.12;
   sum += texture(texture, vec2(texcoord.x - blurSize, texcoord.y)) * 0.15;
   sum += texture(texture, vec2(texcoord.x, texcoord.y)) * 0.16;
   sum += texture(texture, vec2(texcoord.x + blurSize, texcoord.y)) * 0.15;
   sum += texture(texture, vec2(texcoord.x + 2.0*blurSize, texcoord.y)) * 0.12;
   sum += texture(texture, vec2(texcoord.x + 3.0*blurSize, texcoord.y)) * 0.09;
   sum += texture(texture, vec2(texcoord.x + 4.0*blurSize, texcoord.y)) * 0.05;
	
	// blur in y (vertical)
   // take nine samples, with the distance blurSize between them
   sum += texture(texture, vec2(texcoord.x, texcoord.y - 4.0*blurSize)) * 0.05;
   sum += texture(texture, vec2(texcoord.x, texcoord.y - 3.0*blurSize)) * 0.09;
   sum += texture(texture, vec2(texcoord.x, texcoord.y - 2.0*blurSize)) * 0.12;
   sum += texture(texture, vec2(texcoord.x, texcoord.y - blurSize)) * 0.15;
   sum += texture(texture, vec2(texcoord.x, texcoord.y)) * 0.16;
   sum += texture(texture, vec2(texcoord.x, texcoord.y + blurSize)) * 0.15;
   sum += texture(texture, vec2(texcoord.x, texcoord.y + 2.0*blurSize)) * 0.12;
   sum += texture(texture, vec2(texcoord.x, texcoord.y + 3.0*blurSize)) * 0.09;
   sum += texture(texture, vec2(texcoord.x, texcoord.y + 4.0*blurSize)) * 0.05;

   gl_FragColor = sum * 0.15f + texture(texture, texcoord);
}
