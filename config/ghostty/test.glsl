//-----------------------------------------------------------------------------
// CRT Shader with Chromatic Aberration, Glow, Scanlines, Dot Matrix and Transparency
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Customizable Parameters
//-----------------------------------------------------------------------------

// Transparency Settings
const float GLOBAL_OPACITY = 1;        // Overall transparency (1.0 = fully opaque, 0.0 = fully transparent)

// Chromatic Aberration Settings
const float ABBERATION_FACTOR = 0.025;    // Strength of color splitting effect (default: 0.05)

// Glow/Bloom Settings
const float DIM_CUTOFF = 0.28;           // Threshold for what's considered a dim pixel (default: 0.35)
const float BRIGHT_CUTOFF = 0.65;        // Threshold for what's considered a bright pixel
const float BRIGHT_BOOST = 1.0;          // Brightness multiplier for bright pixels (default: 1.2)
const float DIM_GLOW = 0.05;             // Glow intensity for dim pixels (default: 0.05)
const float BRIGHT_GLOW = 0.10;          // Glow intensity for bright pixels (default: 0.10)
const float COLOR_GLOW = 0.3;            // Color bleeding intensity (default: 0.3)

// Scanline Settings
const float SCANLINE_INTENSITY = 1.0;    // Overall intensity of scanlines (default: 1.0)
const float SCANLINE_DENSITY = 0.25;     // Density/thickness of scanlines (default: 0.25)

// Dot Matrix Settings
const float MASK_INTENSITY = 0;          // Strength of the dot pattern (default: 0.3)
const float MASK_SIZE = 1.0;             // Size of the dots (default: 1.0)

//-----------------------------------------------------------------------------
// Color Space Conversion Functions
//-----------------------------------------------------------------------------

// sRGB linear -> nonlinear transform
float f(float x) {
    if (x >= 0.0031308) return 1.055 * pow(x, 1.0 / 2.4) - 0.055;
    return 12.92 * x;
}

float f_inv(float x) {
    if (x >= 0.04045) return pow((x + 0.055) / 1.055, 2.4);
    return x / 12.92;
}

// Oklab color space conversions
vec4 toOklab(vec4 rgb) {
    vec3 c = vec3(f_inv(rgb.r), f_inv(rgb.g), f_inv(rgb.b));
    float l = 0.4122214708 * c.r + 0.5363325363 * c.g + 0.0514459929 * c.b;
    float m = 0.2119034982 * c.r + 0.6806995451 * c.g + 0.1073969566 * c.b;
    float s = 0.0883024619 * c.r + 0.2817188376 * c.g + 0.6299787005 * c.b;
    float l_ = pow(l, 1.0 / 3.0);
    float m_ = pow(m, 1.0 / 3.0);
    float s_ = pow(s, 1.0 / 3.0);
    return vec4(
        0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
        1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
        0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
        rgb.a
    );
}

vec4 toRgb(vec4 oklab) {
    vec3 c = oklab.rgb;
    float l_ = c.r + 0.3963377774 * c.g + 0.2158037573 * c.b;
    float m_ = c.r - 0.1055613458 * c.g - 0.0638541728 * c.b;
    float s_ = c.r - 0.0894841775 * c.g - 1.2914855480 * c.b;
    float l = l_ * l_ * l_;
    float m = m_ * m_ * m_;
    float s = s_ * s_ * s_;
    vec3 linear_srgb = vec3(
         4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
        -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
        -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
    );
    return vec4(
        clamp(f(linear_srgb.r), 0.0, 1.0),
        clamp(f(linear_srgb.g), 0.0, 1.0),
        clamp(f(linear_srgb.b), 0.0, 1.0),
        oklab.a
    );
}

//-----------------------------------------------------------------------------
// Effect Generation Functions
//-----------------------------------------------------------------------------

// Bloom sample points
const vec3[24] samples = {
    vec3(0.1693761725038636, 0.9855514761735895, 1),
    vec3(-1.333070830962943, 0.4721463328627773, 0.7071067811865475),
    vec3(-0.8464394909806497, -1.51113870578065, 0.5773502691896258),
    vec3(1.554155680728463, -1.2588090085709776, 0.5),
    vec3(1.681364377589461, 1.4741145918052656, 0.4472135954999579),
    vec3(-1.2795157692199817, 2.088741103228784, 0.4082482904638631),
    vec3(-2.4575847530631187, -0.9799373355024756, 0.3779644730092272),
    vec3(0.5874641440200847, -2.7667464429345077, 0.35355339059327373),
    vec3(2.997715703369726, 0.11704939884745152, 0.3333333333333333),
    vec3(0.41360842451688395, 3.1351121305574803, 0.31622776601683794),
    vec3(-3.167149933769243, 0.9844599011770256, 0.30151134457776363),
    vec3(-1.5736713846521535, -3.0860263079123245, 0.2886751345948129),
    vec3(2.888202648340422, -2.1583061557896213, 0.2773500981126146),
    vec3(2.7150778983300325, 2.5745586041105715, 0.2672612419124244),
    vec3(-2.1504069972377464, 3.2211410627650165, 0.2581988897471611),
    vec3(-3.6548858794907493, -1.6253643308191343, 0.25),
    vec3(1.0130775986052671, -3.9967078676335834, 0.24253562503633297),
    vec3(4.229723673607257, 0.33081361055181563, 0.23570226039551587),
    vec3(0.40107790291173834, 4.340407413572593, 0.22941573387056174),
    vec3(-4.319124570236028, 1.159811599693438, 0.22360679774997896),
    vec3(-1.9209044802827355, -4.160543952132907, 0.2182178902359924),
    vec3(3.8639122286635708, -2.6589814382925123, 0.21320071635561041),
    vec3(3.3486228404946234, 3.4331800232609, 0.20851441405707477),
    vec3(-2.8769733643574344, 3.9652268864187157, 0.20412414523193154)
};

// Chromatic aberration time variation
float offsetFunction(float iTime) {
    float amount = 1.0;
    const float periods[4] = {6.0, 16.0, 19.0, 27.0};
    for (int i = 0; i < 4; i++) {
        amount *= 1.0 + 0.5 * sin(iTime*periods[i]);
    }
    return amount * periods[3];
}

//-----------------------------------------------------------------------------
// Main Shader
//-----------------------------------------------------------------------------

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Apply Chromatic Aberration with alpha
    float amount = offsetFunction(iTime);
    vec4 colR = texture(iChannel0, vec2(uv.x-ABBERATION_FACTOR*amount / iResolution.x, uv.y));
    vec4 colG = texture(iChannel0, uv);
    vec4 colB = texture(iChannel0, vec2(uv.x+ABBERATION_FACTOR*amount / iResolution.x, uv.y));

    // Combine colors while preserving alpha
    vec4 col = vec4(colR.r, colG.g, colB.b, colG.a);

    // Process Colors and Apply Glow
    vec4 splittedColor = col;
    vec4 source = toOklab(splittedColor);
    vec4 dest = source;

    if (source.x > DIM_CUTOFF) {
        dest.x *= BRIGHT_BOOST;
    } else {
        vec2 step = vec2(1.414) / iResolution.xy;
        vec3 glow = vec3(0.0);
        for (int i = 0; i < 24; i++) {
            vec3 s = samples[i];
            float weight = s.z;
            vec4 c = toOklab(texture(iChannel0, uv + s.xy * step));
            if (c.x > DIM_CUTOFF) {
                glow.yz += c.yz * weight * COLOR_GLOW;
                if (c.x <= BRIGHT_CUTOFF) {
                    glow.x += c.x * weight * DIM_GLOW;
                } else {
                    glow.x += c.x * weight * BRIGHT_GLOW;
                }
            }
        }
        dest.xyz += glow.xyz;
    }

    vec4 processedColor = toRgb(dest);

    // Apply Scanlines
    float scanline = abs(sin(fragCoord.y) * SCANLINE_DENSITY * SCANLINE_INTENSITY);

    // Apply Dot Matrix
    vec2 mask_pos = fragCoord.xy * MASK_SIZE;
    float mask = 1.0 - (MASK_INTENSITY * (
        0.5 + 0.5 * sin(mask_pos.x * 3.14159) *
        sin(mask_pos.y * 3.14159)
    ));

    // Combine Effects while preserving alpha
    vec3 final_color = processedColor.rgb * mask;
    vec3 with_scanline = mix(final_color, vec3(0.0), scanline);

    // Apply global opacity while preserving the original alpha relationship
    float final_alpha = processedColor.a * GLOBAL_OPACITY;

    fragColor = vec4(with_scanline, final_alpha);
}
