void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // --------------------------------------------------------------------------------
    // 1. Initialization and Coordinate Adjustment
    // --------------------------------------------------------------------------------
    vec2 p = fragCoord;

    vec4 currentCursor = iCursorCurrent;
    vec4 previousCursor = iCursorPrevious;

    currentCursor.y = iResolution.y - currentCursor.y;
    previousCursor.y = iResolution.y - previousCursor.y;

    vec2 prevPos = (previousCursor.y > 0.0) ? abs(previousCursor.xy) : currentCursor.xy;
    vec2 currPos = currentCursor.xy;

    // --------------------------------------------------------------------------------
    // 2. Animation Setup
    // --------------------------------------------------------------------------------
    float fixedDuration = 0.2;
    float distanceBetween = length(currPos - prevPos);
    float speed = distanceBetween / fixedDuration;
    float t = clamp((iTime - iTimeCursorChange) / fixedDuration, 0.0, 1.0);
    vec2 animatedPos = mix(prevPos, currPos, t);

    float fadePos = 1.0 - t;
    float fadeWidth = 0.1;

    // --------------------------------------------------------------------------------
    // 3. Cursor Appearance Setup
    // --------------------------------------------------------------------------------
    vec2 cursorSize = vec2(currentCursor.z, currentCursor.w);
    vec2 halfSize = cursorSize * 0.5;
    float edgeSmoothing = 1.0; // Reduced edge smoothing for smoother results.

    vec3 colorAcc = vec3(0.0);
    float alphaAcc = 0.0;

    // --------------------------------------------------------------------------------
    // 4. Trail Rendering Loop
    // --------------------------------------------------------------------------------
    int steps = max(10, int(distanceBetween / 5.0));
    for (int i = 0; i < steps; i++) {
        float fi = float(i) / float(steps - 1);
        vec2 trailPos = mix(animatedPos, prevPos, fi);

        trailPos.y -= halfSize.y;
        trailPos.x += halfSize.x;

        // Improved smoothing using distance based approach.
        float dist = length(abs(p - trailPos) - halfSize);
        float segAlpha = smoothstep(0.0, edgeSmoothing, 1.0 - dist) * (1.0 - fi) * (1.0 - smoothstep(fadePos - fadeWidth, fadePos, fi));

        colorAcc += (vec3(68.0, 221.0, 255.0) / 255.0) * segAlpha;
        alphaAcc += segAlpha;
    }

    // --------------------------------------------------------------------------------
    // 5. Final Color Calculation
    // --------------------------------------------------------------------------------
    if (alphaAcc > 0.0) {
        colorAcc /= alphaAcc;
    }

    fragColor = vec4(colorAcc, alphaAcc);
}
