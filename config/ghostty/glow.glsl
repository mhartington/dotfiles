void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord/iResolution.xy;
    
    // Base color from terminal
    vec3 color = texture(iChannel0, uv).rgb;
    
    // Add bloom/glow
    float bloom = 0.15;
    vec3 glow = vec3(0.0);
    for(float i = 0.0; i < 4.0; i++) {
        vec2 offset = vec2(i) / iResolution.xy;
        glow += texture(iChannel0, uv + offset).rgb;
        glow += texture(iChannel0, uv - offset).rgb;
    }
    
    // Combine glow with original color
    color += glow * bloom;
    
    fragColor = vec4(color, 1.0);
}
