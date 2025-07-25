// Test file to demonstrate the color interpolation functionality
import { get_color_at_percentage, generate_colors_gradient } from "./color";

// Example usage:
const battery_colors = [
    '#FF0000FF', // Red (0%)
    '#FFFF00FF', // Yellow (50%)  
    '#00FF00FF'  // Green (100%)
];

// Test individual percentage values
console.log("Battery color at 0%:", get_color_at_percentage(battery_colors, 0));    // Should be red
console.log("Battery color at 25%:", get_color_at_percentage(battery_colors, 25));  // Should be red-orange
console.log("Battery color at 50%:", get_color_at_percentage(battery_colors, 50));  // Should be yellow
console.log("Battery color at 75%:", get_color_at_percentage(battery_colors, 75));  // Should be yellow-green
console.log("Battery color at 100%:", get_color_at_percentage(battery_colors, 100)); // Should be green

// Generate full gradient (101 colors for 0-100%)
const full_gradient = generate_colors_gradient(battery_colors);
console.log("Full gradient has", full_gradient.length, "colors");

// Example with different color schemes:

// Fire theme (red to orange to yellow)
const fire_colors = ['#FF0000FF', '#FF8000FF', '#FFFF00FF'];
console.log("Fire theme at 50%:", get_color_at_percentage(fire_colors, 50));

// Ocean theme (blue to cyan to white)
const ocean_colors = ['#000080FF', '#00FFFFFF', '#FFFFFFFF'];
console.log("Ocean theme at 50%:", get_color_at_percentage(ocean_colors, 50));

// Simple two-color gradient (red to green)
const simple_colors = ['#FF0000FF', '#00FF00FF'];
console.log("Simple red-green at 50%:", get_color_at_percentage(simple_colors, 50));
