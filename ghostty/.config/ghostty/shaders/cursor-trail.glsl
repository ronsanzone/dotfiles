float segmentDistance(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / max(dot(ba, ba), 0.0001), 0.0, 1.0);
    return length(pa - ba * h);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 base = texture(iChannel0, fragCoord / iResolution.xy);

    vec2 current = iCurrentCursor.xy + iCurrentCursor.zw * 0.5;
    vec2 previous = iPreviousCursor.xy + iPreviousCursor.zw * 0.5;
    float elapsed = clamp(iTime - iTimeCursorChange, 0.0, 0.22);
    float movement = length(current - previous);

    float width = max(iCurrentCursor.z * 1.45, 8.0);
    float distanceToTrail = segmentDistance(fragCoord, previous, current);
    float trail = smoothstep(width, 0.0, distanceToTrail);
    trail *= exp(-elapsed * 12.0);
    trail *= smoothstep(1.0, 18.0, movement);
    trail *= float(iFocus > 0);

    vec3 trailColor = mix(iCurrentCursorColor.rgb, vec3(0.333, 0.878, 0.863), 0.35);
    base.rgb = mix(base.rgb, trailColor, trail * 0.34);
    fragColor = base;
}
