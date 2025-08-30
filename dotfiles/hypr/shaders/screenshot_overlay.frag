#version 330
uniform sampler2D tex;
in vec2 uv;
out vec4 fragColor;
void main() {
    vec4 color = texture(tex, uv);
    fragColor = mix(color, vec4(0.2, 0.4, 0.8, 1.0), 0.4); // Adjust the blue tint strength
}
