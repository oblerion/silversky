shader_type spatial;
render_mode diffuse_lambert, specular_schlick_ggx, cull_back;

// ==================== PARAMÈTRES ====================
uniform vec4 main_color : source_color = vec4(0.2, 0.6, 1.0, 1.0);     // Couleur de fond
uniform vec4 square_color : source_color = vec4(0.1, 0.3, 0.8, 1.0);   // Couleur des petits carrés

uniform float square_size : hint_range(0.01, 2.0) = 0.25;              // Taille des carrés
uniform float square_gap : hint_range(0.0, 0.5) = 0.08;                // Espacement
uniform float edge_softness : hint_range(0.0, 0.1) = 0.03;

uniform bool use_world_space = true;

// ===================================================

varying vec3 world_pos;   // On passe la position du monde depuis le vertex shader

void vertex() {
    if (use_world_space) {
        // Position dans le monde (correct pour Godot 4)
        world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    }
}

void fragment() {
    vec2 coord;
    
    if (use_world_space) {
        coord = world_pos.xz + world_pos.y * 0.5;   // Bon pour voxels (tu peux changer l'axe)
    } else {
        coord = UV * 20.0;
    }
    
    // Création du motif carrés
    vec2 grid = fract(coord / square_size);
    
    float inside = step(square_gap, grid.x) * step(square_gap, grid.y) *
                   step(grid.x, 1.0 - square_gap) * step(grid.y, 1.0 - square_gap);
    
    float smooth_square = smoothstep(square_gap - edge_softness, square_gap + edge_softness, min(grid.x, grid.y)) *
                          smoothstep(square_gap - edge_softness, square_gap + edge_softness, min(1.0 - grid.x, 1.0 - grid.y));
    
    float square_factor = inside * smooth_square;
    
    ALBEDO = mix(main_color.rgb, square_color.rgb, square_factor);
    ALPHA = main_color.a;
}