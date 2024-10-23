uniform sampler2D tex;

varying vec3 vNormal;

void main() {

    vec2 uv = normalize( vNormal ).xy * 0.5 + 0.5;

    vec3 color = texture2D( tex, uv ).rgb;

    if ( vNormal.z < - 0.85 ) color = vec3( 0.777, 0.74, 0.74 ); // back of eye
    
    gl_FragColor = vec4( color, 1.0 );

}
