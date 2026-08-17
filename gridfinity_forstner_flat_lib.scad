// =============================================================================
//  GRIDFINITY FORSTNER BIT HOLDER  -  flat lay, top-and-tail
//  Built on kennetek's gridfinity-rebuilt-openscad library.
// -----------------------------------------------------------------------------
//  SETUP
//    git clone https://github.com/kennetek/gridfinity-rebuilt-openscad.git
//  and put the resulting folder next to this file:
//
//    my-project/
//      gridfinity_forstner_flat_lib.scad     <- this file
//      gridfinity-rebuilt-openscad/          <- the cloned library
//
//  The library owns the base profile, stacking lip, walls and magnet/screw
//  holes. This file only adds the two notched rails that cradle the bits.
//
//  F5 = preview, F6 = render, then File > Export > Export as STL.
// =============================================================================

include <gridfinity-rebuilt-openscad/src/core/standard.scad>
use <gridfinity-rebuilt-openscad/src/core/bin.scad>
use <gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-holes.scad>
use <gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-utility.scad>


// =============================================================================
//  BIT LIST -- up to 20 slots (Bit defaults, then Enabled bits, then Bit
//  list, near the bottom of the Customizer). Turn a slot off in "Enabled
//  bits" to skip it entirely; disabled slots don't affect sizing/layout at
//  all. All dimensions in mm,
//  measured from the head end downwards, five sections per bit (see
//  photos/ for a labelled reference):
//
//    head  -- the cutting head, the widest part
//    neck  -- short narrow transition right below the head
//    body  -- the main shaft (most of the bit's length)
//    waist -- narrow retention groove just above the shank
//    base  -- the shank that goes in the chuck
//
//  head_diameter is always read from the bit's own field -- it's the one number
//  that actually distinguishes one bit from another. Every other field
//  (head_length, neck_diameter, neck_length, body_diameter, body_length, waist_diameter, waist_length,
//  base_diameter, base_length) defaults to 0, meaning "use the matching default_*
//  value in Bit defaults" -- most forstner sets share the same head length
//  and shank across many sizes, so this saves re-typing the same numbers
//  20 times. Give a bit its own non-zero value in any of those fields to
//  override the default just for that bit.
//
//  mountN picks whether that bit's rails grip its neck or its body
//  (default body). Rather than exactly track where the neck/body/waist
//  boundaries physically fall -- fragile once bit proportions vary this
//  much between sizes -- the seat at BOTH rails for a bit is simply sized
//  to whichever one is chosen, treated as if it ran the bit's whole shaft
//  length. If a bit's body is too short/oddly proportioned relative to its
//  neighbours (like a small bit's neck being proportionally huge next to
//  its shank), switch that bit's mount to neck instead.
//
//  This is scalars-per-bit (instead of one table, or even parallel lists)
//  because it's the most restrictive customizer-compatible format there
//  is -- plain numbers and booleans, nothing structured -- so it has the
//  best chance of showing up as editable fields in both the OpenSCAD
//  Customizer and MakerWorld's parameter panel, neither of which reliably
//  supports list-type parameters.
// =============================================================================

/* [Preset] */
// Loads a known bit set's sizes into the fields below (slot 1 = the preset's first bit, etc.), overriding whatever is typed there; Enabled bits below still controls what's included. Custom = edit the fields yourself.
preset = "custom"; // [custom:Custom, vevor16:VEVOR 16 Pcs Forstner Bit Set]


/* [Layout] */

// Reverse every second bit (top and tail). Off = all heads the same end.
alternate = true;
// Sort the bit list largest-head-first before laying out. Off = keep the order you typed them in (useful for testing a specific arrangement).
sort_bits = true;
// Air gap between neighbouring bits, mm (all measurements below are mm too).
bit_gap = 2;
// Gap between the ends of the bits and the inside of the bin wall
end_gap = 2;
// Air under the heads, so you can get a finger under a bit to lift it
head_floor_gap = 2;


/* [Rails] */

// Distance between the two rails, mm. 0 = auto (as far apart as the bits allow).
rail_gap = 0;
// Width of each rail (and the seat cut into it) along the bit's length.
rail_width = 6;
// Keep the rail at least this far clear of the back of the head
rail_margin = 1.5;
// Extra radius added to every seat so bits aren't a dead-tight press fit.
slot_clearance = 0.05;
// How far the seat continues straight up past the shaft centreline
grip = 1.5;
// Funnel widening at the mouth of each seat
slot_flare = 1.2;
// Minimum material left between two neighbouring seats
rail_wall = 1.6;
// How much narrower than the bit's radius the retention pinch is, mm, so bits click into place instead of resting loosely; 0 = no pinch (plain funnel). Dial in with a test swatch (see [Testing]).
grip_pinch = 0.2;
// How far above the seat's straight-walled cradle (grip) the pinch sits.
grip_pinch_height = 1;


/* [Bin] */

// Footprint in gridfinity units (grid_x = length, grid_y = depth); 0 = auto-size to the bits.
grid_x = 0;
grid_y = 0;
// Use a 21 mm base pitch instead of the standard 42 mm one, for a more compact (half-unit) footprint; magnet/screw holes follow the same 21 mm pitch, so won't align with a standard 42 mm baseplate's holes.
allow_half_units = false;
// Height in gridfinity units (7 mm each). 0 = auto.
height_units = 0;
// Extra floor, mm, on top of the library's 7 mm base (usually leave at 0); if include_lip is off this MUST be > 0, since without a lip the walls are built from the floor's infill.
extra_floor = 0;
// Air above the tallest bit (mm). Only used when height_units = 0 (auto).
top_clearance = 2;

// Stacking lip around the top rim, so another bin can stack on this one; if off, see the extra_floor note above.
include_lip = true;


/* [Base holes] */
// Hole for a 6mm magnet in each base cell.
magnet_holes = false;
// Hole for an M3 screw in each base cell.
screw_holes = false;
// Ribs that grip a pressed-in magnet without glue (only if magnet_holes is on).
crush_ribs = true;
// Chamfer the top edge of the hole(s) (only if magnet_holes and/or screw_holes is on).
chamfer_holes = true;
// Print the hole(s) without support material (only if magnet_holes and/or screw_holes is on).
supportless = true;
// Put holes in the outer corner cells only, instead of every cell (only if magnet_holes and/or screw_holes is on).
only_corners = false;


/* [Labels] */
// Engrave each bit's label (from the bit list) into the floor under it.
labels = true;
// Text height (mm). Only has an effect if labels is on.
label_size = 5;
// How deep the text is cut into the floor (mm). Only has an effect if labels is on.
label_depth = 0.6;


/* [Bit defaults] */
// All values in mm. Fallback used by any bit below that leaves its own matching field at 0 (does not apply to head_diameter, which always comes from the bit's own field).
default_head_length = 15;
default_neck_diameter = 8;
default_neck_length = 0;
default_body_diameter = 8;
default_body_length = 40;
default_waist_diameter = 8;
default_waist_length = 0;
default_base_diameter = 8;
default_base_length = 25;


/* [Enabled bits] */
// Which of the 20 slots below are active (independent of Preset above; grouped here so you can flip them all at a glance).
bit_01_enabled = true;
bit_02_enabled = true;
bit_03_enabled = true;
bit_04_enabled = true;
bit_05_enabled = true;
bit_06_enabled = true;
bit_07_enabled = true;
bit_08_enabled = true;
bit_09_enabled = true;
bit_10_enabled = true;
bit_11_enabled = true;
bit_12_enabled = true;
bit_13_enabled = true;
bit_14_enabled = true;
bit_15_enabled = true;
bit_16_enabled = true;
bit_17_enabled = false;
bit_18_enabled = false;
bit_19_enabled = false;
bit_20_enabled = false;


/* [Bit list] */

// Bit 01: dimensions in mm; 0 = use Bit defaults, except head_diameter; ignored for slots a Preset already covers.
bit_01_head_diameter = 6;
bit_01_head_length = 8;
bit_01_neck_diameter = 4.75;
bit_01_neck_length = 15;
bit_01_body_diameter = 5.55;
bit_01_body_length = 35;
bit_01_waist_diameter = 0;
bit_01_waist_length = 2;
bit_01_base_diameter = 9.55;
bit_01_base_length = 30;
bit_01_mount_neck = true;

// Bit 02
bit_02_head_diameter = 9;
bit_02_head_length = 12;
bit_02_neck_diameter = 6;
bit_02_neck_length = 15;
bit_02_body_diameter = 8;
bit_02_body_length = 30;
bit_02_waist_diameter = 0;
bit_02_waist_length = 3;
bit_02_base_diameter = 9.55;
bit_02_base_length = 30;
bit_02_mount_neck = true;

// Bit 03
bit_03_head_diameter = 12;
bit_03_head_length = 12;
bit_03_neck_diameter = 6;
bit_03_neck_length = 15;
bit_03_body_diameter = 8;
bit_03_body_length = 30;
bit_03_waist_diameter = 0;
bit_03_waist_length = 3;
bit_03_base_diameter = 9.55;
bit_03_base_length = 30;
bit_03_mount_neck = true;

// Bit 04
bit_04_head_diameter = 15;
bit_04_head_length = 0;
bit_04_neck_diameter = 0;
bit_04_neck_length = 0;
bit_04_body_diameter = 9.85;
bit_04_body_length = 45;
bit_04_waist_diameter = 0;
bit_04_waist_length = 0;
bit_04_base_diameter = 7.94;
bit_04_base_length = 30;
bit_04_mount_neck = false;

// Bit 05
bit_05_head_diameter = 16;
bit_05_head_length = 0;
bit_05_neck_diameter = 0;
bit_05_neck_length = 0;
bit_05_body_diameter = 9.52;
bit_05_body_length = 45;
bit_05_waist_diameter = 0;
bit_05_waist_length = 0;
bit_05_base_diameter = 9.52;
bit_05_base_length = 30;
bit_05_mount_neck = false;

// Bit 06
bit_06_head_diameter = 19;
bit_06_head_length = 0;
bit_06_neck_diameter = 0;
bit_06_neck_length = 0;
bit_06_body_diameter = 9.52;
bit_06_body_length = 45;
bit_06_waist_diameter = 0;
bit_06_waist_length = 0;
bit_06_base_diameter = 9.52;
bit_06_base_length = 30;
bit_06_mount_neck = false;

// Bit 07
bit_07_head_diameter = 20;
bit_07_head_length = 0;
bit_07_neck_diameter = 0;
bit_07_neck_length = 0;
bit_07_body_diameter = 9.85;
bit_07_body_length = 45;
bit_07_waist_diameter = 0;
bit_07_waist_length = 0;
bit_07_base_diameter = 7.94;
bit_07_base_length = 30;
bit_07_mount_neck = false;

// Bit 08 (duplicate 20mm row, entered as given)
bit_08_head_diameter = 20;
bit_08_head_length = 0;
bit_08_neck_diameter = 0;
bit_08_neck_length = 0;
bit_08_body_diameter = 9.85;
bit_08_body_length = 45;
bit_08_waist_diameter = 0;
bit_08_waist_length = 0;
bit_08_base_diameter = 7.94;
bit_08_base_length = 30;
bit_08_mount_neck = false;

// Bit 09
bit_09_head_diameter = 25;
bit_09_head_length = 0;
bit_09_neck_diameter = 0;
bit_09_neck_length = 0;
bit_09_body_diameter = 12.0;
bit_09_body_length = 45;
bit_09_waist_diameter = 0;
bit_09_waist_length = 0;
bit_09_base_diameter = 7.94;
bit_09_base_length = 30;
bit_09_mount_neck = false;

// Bit 10
bit_10_head_diameter = 28;
bit_10_head_length = 0;
bit_10_neck_diameter = 0;
bit_10_neck_length = 0;
bit_10_body_diameter = 12.0;
bit_10_body_length = 45;
bit_10_waist_diameter = 0;
bit_10_waist_length = 0;
bit_10_base_diameter = 9.52;
bit_10_base_length = 30;
bit_10_mount_neck = false;

// Bit 11
bit_11_head_diameter = 30;
bit_11_head_length = 0;
bit_11_neck_diameter = 0;
bit_11_neck_length = 0;
bit_11_body_diameter = 12.0;
bit_11_body_length = 45;
bit_11_waist_diameter = 0;
bit_11_waist_length = 0;
bit_11_base_diameter = 7.94;
bit_11_base_length = 30;
bit_11_mount_neck = false;

// Bit 12
bit_12_head_diameter = 32;
bit_12_head_length = 0;
bit_12_neck_diameter = 0;
bit_12_neck_length = 0;
bit_12_body_diameter = 12.0;
bit_12_body_length = 45;
bit_12_waist_diameter = 0;
bit_12_waist_length = 0;
bit_12_base_diameter = 9.52;
bit_12_base_length = 30;
bit_12_mount_neck = false;

// Bit 13
bit_13_head_diameter = 35;
bit_13_head_length = 0;
bit_13_neck_diameter = 0;
bit_13_neck_length = 0;
bit_13_body_diameter = 12.0;
bit_13_body_length = 45;
bit_13_waist_diameter = 0;
bit_13_waist_length = 0;
bit_13_base_diameter = 9.52;
bit_13_base_length = 30;
bit_13_mount_neck = false;

// Bit 14
bit_14_head_diameter = 38;
bit_14_head_length = 0;
bit_14_neck_diameter = 0;
bit_14_neck_length = 0;
bit_14_body_diameter = 12.0;
bit_14_body_length = 45;
bit_14_waist_diameter = 0;
bit_14_waist_length = 0;
bit_14_base_diameter = 9.52;
bit_14_base_length = 30;
bit_14_mount_neck = false;

// Bit 15
bit_15_head_diameter = 40;
bit_15_head_length = 0;
bit_15_neck_diameter = 0;
bit_15_neck_length = 0;
bit_15_body_diameter = 12.0;
bit_15_body_length = 45;
bit_15_waist_diameter = 0;
bit_15_waist_length = 0;
bit_15_base_diameter = 9.52;
bit_15_base_length = 30;
bit_15_mount_neck = false;

// Bit 16
bit_16_head_diameter = 41;
bit_16_head_length = 0;
bit_16_neck_diameter = 0;
bit_16_neck_length = 0;
bit_16_body_diameter = 12.0;
bit_16_body_length = 45;
bit_16_waist_diameter = 0;
bit_16_waist_length = 0;
bit_16_base_diameter = 9.52;
bit_16_base_length = 30;
bit_16_mount_neck = false;

// Bit 17
bit_17_head_diameter = 10;
bit_17_head_length = 0;
bit_17_neck_diameter = 0;
bit_17_neck_length = 0;
bit_17_body_diameter = 0;
bit_17_body_length = 0;
bit_17_waist_diameter = 0;
bit_17_waist_length = 0;
bit_17_base_diameter = 0;
bit_17_base_length = 0;
bit_17_mount_neck = false;

// Bit 18
bit_18_head_diameter = 10;
bit_18_head_length = 0;
bit_18_neck_diameter = 0;
bit_18_neck_length = 0;
bit_18_body_diameter = 0;
bit_18_body_length = 0;
bit_18_waist_diameter = 0;
bit_18_waist_length = 0;
bit_18_base_diameter = 0;
bit_18_base_length = 0;
bit_18_mount_neck = false;

// Bit 19
bit_19_head_diameter = 10;
bit_19_head_length = 0;
bit_19_neck_diameter = 0;
bit_19_neck_length = 0;
bit_19_body_diameter = 0;
bit_19_body_length = 0;
bit_19_waist_diameter = 0;
bit_19_waist_length = 0;
bit_19_base_diameter = 0;
bit_19_base_length = 0;
bit_19_mount_neck = false;

// Bit 20
bit_20_head_diameter = 10;
bit_20_head_length = 0;
bit_20_neck_diameter = 0;
bit_20_neck_length = 0;
bit_20_body_diameter = 0;
bit_20_body_length = 0;
bit_20_waist_diameter = 0;
bit_20_waist_length = 0;
bit_20_base_diameter = 0;
bit_20_base_length = 0;
bit_20_mount_neck = false;


/* [Testing] */
// Render a small test swatch for just this bit's seats instead of the whole bin (ignores grid_x/grid_y/height_units/labels while active); 0 = off, full bin. 1-based slot number in the order slots appear (bit_01, bit_02, ...), skipping disabled ones, not sorted layout order.
test_bit = 0;


// =============================================================================
//  Bit table and layout maths  (the only custom part)
// =============================================================================

/* [Hidden] */
EPS = 0.01;

// Slice the model in half lengthways for inspecting the seats and rail
// cross-section, and circle/cylinder facet count. Not exposed as
// Customizer options -- edit these directly in code if you need them.
section_view = false;
$fn = 64;

// Known bit sets, selectable via the preset dropdown above instead of
// filling in the individual bit fields by hand. Each row is
// [head_diameter, head_length, neck_diameter, neck_length, body_diameter, body_length, waist_diameter,
// waist_length, base_diameter, base_length, mount_neck] -- the same ten dimensions
// plus mountN as a bit's own fields, just in one internal table instead
// of scattered across 11 customizer fields each. Returns [] for "custom"
// (and any unrecognised name), meaning "use the individual fields".
function preset_bits(name) =
    name == "vevor16" ? [
        [ 6,  8, 4.75, 15, 5.55, 35, 0, 2, 9.55, 30, true],
        [ 9, 12,    6, 15,    8, 30, 0, 3, 9.55, 30, true],
        [12, 12,    6, 15,    8, 30, 0, 3, 9.55, 30, true],
        [15,  0,    0,  0, 9.85, 45, 0, 0, 7.94, 30, false],
        [16,  0,    0,  0, 9.52, 45, 0, 0, 9.52, 30, false],
        [19,  0,    0,  0, 9.52, 45, 0, 0, 9.52, 30, false],
        [20,  0,    0,  0, 9.85, 45, 0, 0, 7.94, 30, false],
        [20,  0,    0,  0, 9.85, 45, 0, 0, 7.94, 30, false],
        [25,  0,    0,  0,   12, 45, 0, 0, 7.94, 30, false],
        [28,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
        [30,  0,    0,  0,   12, 45, 0, 0, 7.94, 30, false],
        [32,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
        [35,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
        [38,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
        [40,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
        [41,  0,    0,  0,   12, 45, 0, 0, 9.52, 30, false],
    ] : [];

_preset = preset_bits(preset);
_preset_length = len(_preset);

// Gather the 20 individual bit slots above into plain lists. This is the
// only place that needs to know there are 20 separate slots -- everything
// below just works with a simple list.
_enabled        = [bit_01_enabled, bit_02_enabled, bit_03_enabled, bit_04_enabled, bit_05_enabled, bit_06_enabled, bit_07_enabled, bit_08_enabled, bit_09_enabled, bit_10_enabled, bit_11_enabled, bit_12_enabled, bit_13_enabled, bit_14_enabled, bit_15_enabled, bit_16_enabled, bit_17_enabled, bit_18_enabled, bit_19_enabled, bit_20_enabled];
_field_head_diameter   = [bit_01_head_diameter, bit_02_head_diameter, bit_03_head_diameter, bit_04_head_diameter, bit_05_head_diameter, bit_06_head_diameter, bit_07_head_diameter, bit_08_head_diameter, bit_09_head_diameter, bit_10_head_diameter, bit_11_head_diameter, bit_12_head_diameter, bit_13_head_diameter, bit_14_head_diameter, bit_15_head_diameter, bit_16_head_diameter, bit_17_head_diameter, bit_18_head_diameter, bit_19_head_diameter, bit_20_head_diameter];
_field_head_length   = [bit_01_head_length, bit_02_head_length, bit_03_head_length, bit_04_head_length, bit_05_head_length, bit_06_head_length, bit_07_head_length, bit_08_head_length, bit_09_head_length, bit_10_head_length, bit_11_head_length, bit_12_head_length, bit_13_head_length, bit_14_head_length, bit_15_head_length, bit_16_head_length, bit_17_head_length, bit_18_head_length, bit_19_head_length, bit_20_head_length];
_field_neck_diameter   = [bit_01_neck_diameter, bit_02_neck_diameter, bit_03_neck_diameter, bit_04_neck_diameter, bit_05_neck_diameter, bit_06_neck_diameter, bit_07_neck_diameter, bit_08_neck_diameter, bit_09_neck_diameter, bit_10_neck_diameter, bit_11_neck_diameter, bit_12_neck_diameter, bit_13_neck_diameter, bit_14_neck_diameter, bit_15_neck_diameter, bit_16_neck_diameter, bit_17_neck_diameter, bit_18_neck_diameter, bit_19_neck_diameter, bit_20_neck_diameter];
_field_neck_length   = [bit_01_neck_length, bit_02_neck_length, bit_03_neck_length, bit_04_neck_length, bit_05_neck_length, bit_06_neck_length, bit_07_neck_length, bit_08_neck_length, bit_09_neck_length, bit_10_neck_length, bit_11_neck_length, bit_12_neck_length, bit_13_neck_length, bit_14_neck_length, bit_15_neck_length, bit_16_neck_length, bit_17_neck_length, bit_18_neck_length, bit_19_neck_length, bit_20_neck_length];
_field_body_diameter   = [bit_01_body_diameter, bit_02_body_diameter, bit_03_body_diameter, bit_04_body_diameter, bit_05_body_diameter, bit_06_body_diameter, bit_07_body_diameter, bit_08_body_diameter, bit_09_body_diameter, bit_10_body_diameter, bit_11_body_diameter, bit_12_body_diameter, bit_13_body_diameter, bit_14_body_diameter, bit_15_body_diameter, bit_16_body_diameter, bit_17_body_diameter, bit_18_body_diameter, bit_19_body_diameter, bit_20_body_diameter];
_field_body_length   = [bit_01_body_length, bit_02_body_length, bit_03_body_length, bit_04_body_length, bit_05_body_length, bit_06_body_length, bit_07_body_length, bit_08_body_length, bit_09_body_length, bit_10_body_length, bit_11_body_length, bit_12_body_length, bit_13_body_length, bit_14_body_length, bit_15_body_length, bit_16_body_length, bit_17_body_length, bit_18_body_length, bit_19_body_length, bit_20_body_length];
_field_waist_diameter  = [bit_01_waist_diameter, bit_02_waist_diameter, bit_03_waist_diameter, bit_04_waist_diameter, bit_05_waist_diameter, bit_06_waist_diameter, bit_07_waist_diameter, bit_08_waist_diameter, bit_09_waist_diameter, bit_10_waist_diameter, bit_11_waist_diameter, bit_12_waist_diameter, bit_13_waist_diameter, bit_14_waist_diameter, bit_15_waist_diameter, bit_16_waist_diameter, bit_17_waist_diameter, bit_18_waist_diameter, bit_19_waist_diameter, bit_20_waist_diameter];
_field_waist_length  = [bit_01_waist_length, bit_02_waist_length, bit_03_waist_length, bit_04_waist_length, bit_05_waist_length, bit_06_waist_length, bit_07_waist_length, bit_08_waist_length, bit_09_waist_length, bit_10_waist_length, bit_11_waist_length, bit_12_waist_length, bit_13_waist_length, bit_14_waist_length, bit_15_waist_length, bit_16_waist_length, bit_17_waist_length, bit_18_waist_length, bit_19_waist_length, bit_20_waist_length];
_field_base_diameter   = [bit_01_base_diameter, bit_02_base_diameter, bit_03_base_diameter, bit_04_base_diameter, bit_05_base_diameter, bit_06_base_diameter, bit_07_base_diameter, bit_08_base_diameter, bit_09_base_diameter, bit_10_base_diameter, bit_11_base_diameter, bit_12_base_diameter, bit_13_base_diameter, bit_14_base_diameter, bit_15_base_diameter, bit_16_base_diameter, bit_17_base_diameter, bit_18_base_diameter, bit_19_base_diameter, bit_20_base_diameter];
_field_base_length   = [bit_01_base_length, bit_02_base_length, bit_03_base_length, bit_04_base_length, bit_05_base_length, bit_06_base_length, bit_07_base_length, bit_08_base_length, bit_09_base_length, bit_10_base_length, bit_11_base_length, bit_12_base_length, bit_13_base_length, bit_14_base_length, bit_15_base_length, bit_16_base_length, bit_17_base_length, bit_18_base_length, bit_19_base_length, bit_20_base_length];
_field_mount_neck = [bit_01_mount_neck, bit_02_mount_neck, bit_03_mount_neck, bit_04_mount_neck, bit_05_mount_neck, bit_06_mount_neck, bit_07_mount_neck, bit_08_mount_neck, bit_09_mount_neck, bit_10_mount_neck, bit_11_mount_neck, bit_12_mount_neck, bit_13_mount_neck, bit_14_mount_neck, bit_15_mount_neck, bit_16_mount_neck, bit_17_mount_neck, bit_18_mount_neck, bit_19_mount_neck, bit_20_mount_neck];

// A preset only supplies SIZES, one row per slot in order (slot i gets
// preset row i) -- it does not touch enabled/disabled at all. Slots
// beyond the preset's length (or every slot, once "custom" is selected)
// keep using their own field values. Either way, "Enabled bits" above is
// what actually decides which slots are included.
function overlay(field, col) = [for (i = [0:19]) i < _preset_length ? _preset[i][col] : field[i]];
_head_dia_raw   = overlay(_field_head_diameter, 0);
_head_len_raw   = overlay(_field_head_length, 1);
_neck_dia_raw   = overlay(_field_neck_diameter, 2);
_neck_len_raw   = overlay(_field_neck_length, 3);
_body_dia_raw   = overlay(_field_body_diameter, 4);
_body_len_raw   = overlay(_field_body_length, 5);
_waist_dia_raw  = overlay(_field_waist_diameter, 6);
_waist_len_raw  = overlay(_field_waist_length, 7);
_base_dia_raw   = overlay(_field_base_diameter, 8);
_base_len_raw   = overlay(_field_base_length, 9);
_mount_neck_raw = overlay(_field_mount_neck, 10);

_active = [for (i = [0:19]) if (_enabled[i]) i];

head_dias   = [for (i = _active) _head_dia_raw[i]];
head_lens   = [for (i = _active) _head_len_raw[i]   > 0 ? _head_len_raw[i]   : default_head_length];
neck_dias   = [for (i = _active) _neck_dia_raw[i]   > 0 ? _neck_dia_raw[i]   : default_neck_diameter];
neck_lens   = [for (i = _active) _neck_len_raw[i]   > 0 ? _neck_len_raw[i]   : default_neck_length];
body_dias   = [for (i = _active) _body_dia_raw[i]   > 0 ? _body_dia_raw[i]   : default_body_diameter];
body_lens   = [for (i = _active) _body_len_raw[i]   > 0 ? _body_len_raw[i]   : default_body_length];
waist_dias  = [for (i = _active) _waist_dia_raw[i]  > 0 ? _waist_dia_raw[i]  : default_waist_diameter];
waist_lens  = [for (i = _active) _waist_len_raw[i]  > 0 ? _waist_len_raw[i]  : default_waist_length];
base_dias   = [for (i = _active) _base_dia_raw[i]   > 0 ? _base_dia_raw[i]   : default_base_diameter];
base_lens   = [for (i = _active) _base_len_raw[i]   > 0 ? _base_len_raw[i]   : default_base_length];
mount_necks = [for (i = _active) _mount_neck_raw[i]];

// tied directly into nbits's own definition (rather than a separate bare
// assert() statement) because OpenSCAD evaluates top-level variables
// somewhat independently of statement order -- a standalone assert() can
// end up NOT running before other variables that depend on nbits get
// evaluated, producing a cascade of cryptic "undefined operation" warnings
// instead of this message.
nbits = assert(len(head_dias) > 0, "enable at least one bit (bit_01_enabled etc.)") len(head_dias);

// sort bit INDICES by head diameter, largest first, so all lists stay in
// sync instead of sorting (and duplicating) each list separately
function qsort_idx(idx) =
    len(idx) <= 1 ? idx :
    let (p = idx[0], rest = [for (i = [1:len(idx)-1]) idx[i]])
    concat(
        qsort_idx([for (i = rest) if (head_dias[i] >  head_dias[p]) i]),
        [p],
        qsort_idx([for (i = rest) if (head_dias[i] <= head_dias[p]) i]));

order = sort_bits ? qsort_idx([for (i = [0:nbits-1]) i]) : [for (i = [0:nbits-1]) i];

function hd(i) = head_dias[order[i]];
function hl(i) = head_lens[order[i]];
function nd(i) = neck_dias[order[i]];
function nl(i) = neck_lens[order[i]];
function bd(i) = body_dias[order[i]];
function bl(i) = body_lens[order[i]];
function wd(i) = waist_dias[order[i]];
function wl(i) = waist_lens[order[i]];
function sd(i) = base_dias[order[i]];
function sl(i) = base_lens[order[i]];
function mnt_neck(i) = mount_necks[order[i]];
function lbl(i) = str(hd(i));
function bitlen(i) = hl(i) + nl(i) + bl(i) + wl(i) + sl(i);

// which diameter grips this bit's rails: its neck or its body (see the
// note on mountN in the header comment above)
function mount_diameter(i) = mnt_neck(i) ? nd(i) : bd(i);
// diameter of bit i at distance d from its head end. Anywhere between the
// head and the base is sized to the chosen mount diameter rather than
// tracking the exact neck/body/waist boundaries -- simpler, and avoids a
// rail landing on a thin, unintended transition by accident.
function dia_at(i, d) = d < hl(i)              ? hd(i) :
                        d >= bitlen(i) - sl(i)  ? sd(i) : mount_diameter(i);
// widest diameter anywhere under the footprint of a rail centred at d
function dia_rail(i, d) = max(dia_at(i, d - rail_width/2),
                              dia_at(i, d + rail_width/2));

function flip(i) = alternate && (i % 2 == 1);

// a rail must clear the head at both ends of every bit, in either orientation
gap_max = min([for (i = [0:nbits-1])
               bitlen(i) - 2*hl(i) - rail_width - 2*rail_margin]);
G = rail_gap > 0 ? rail_gap : gap_max;

function d_near(i) = bitlen(i)/2 - G/2;
function d_far(i)  = bitlen(i)/2 + G/2;

function dL(i) = dia_rail(i, flip(i) ? d_far(i) : d_near(i));
function dR(i) = dia_rail(i, flip(i) ? d_near(i) : d_far(i));

function wL(i) = flip(i) ? sd(i) : hd(i);
function wR(i) = flip(i) ? hd(i) : sd(i);
function ext(i) = max(wL(i), wR(i)) / 2;

// heads two apart share a side, so they must clear each other over two pitches
function two_away(i) = (i + 2 < nbits) ? ((hd(i) + hd(i+2))/2 + bit_gap)/2 : 0;

function pitch(i) = max(
    (wL(i) + wL(i+1))/2 + bit_gap,
    (wR(i) + wR(i+1))/2 + bit_gap,
    (dL(i) + dL(i+1))/2 + slot_clearance*2 + rail_wall,
    (dR(i) + dR(i+1))/2 + slot_clearance*2 + rail_wall,
    two_away(i),
    (i > 0 ? two_away(i-1) : 0));

function ypos(i) = i == 0 ? 0 : ypos(i-1) + pitch(i-1);

y_lo = min([for (i = [0:nbits-1]) ypos(i) - ext(i)]);
y_hi = max([for (i = [0:nbits-1]) ypos(i) + ext(i)]);
function cy(i) = ypos(i) - (y_lo + y_hi)/2;

// ---- heights ----------------------------------------------------------------
// The library's base is BASE_HEIGHT (7 mm) of solid material.
floor_z  = BASE_HEIGHT + max(extra_floor, 0);
max_head = max([for (i = [0:nbits-1]) hd(i)]);
// one centreline height for every bit, so they all lie level
axis_z   = floor_z + max_head/2 + head_floor_gap;
// must clear the pinch (axis_z + grip + grip_pinch_height, see seat())
// with a bit of margin, or the pinch ends up above the rail's actual top
// surface -- no material left there to squeeze against, so it does nothing.
rail_top = axis_z + grip + grip_pinch_height + 0.8;

max_length  = max([for (i = [0:nbits-1]) bitlen(i)]);
need_x   = max_length + 2*end_gap;
need_y   = (y_hi - y_lo) + 2*bit_gap;
need_z   = axis_z + max_head/2 + top_clearance;

// ---- let the library tell us how much room a given footprint really has ------
holes = bundle_hole_options(
            magnet_hole = magnet_holes,
            screw_hole  = screw_holes,
            crush_ribs  = crush_ribs,
            chamfer     = chamfer_holes,
            supportless = supportless);

// grid_dimensions is the size of ONE base cell -- the standard 42 mm, or a
// uniform 21 mm when allow_half_units is on. Either way grid_size (the
// COUNT of cells) stays a plain whole integer, so this always uses the
// library's normal, reliable code path. (Passing a fractional grid_size,
// e.g. 2.5, straight into new_bin() is NOT reliable in the pinned library
// version (910e22d) -- gridfinityBase() centers its solid bridge on the
// exact fractional span, but places the individual base feet via a pattern
// that truncates to whole units, so the feet end up visibly offset from
// the bridge. Changing the cell size instead of the cell count sidesteps
// that bug entirely.)
unit = allow_half_units ? GRID_DIMENSIONS_MM / 2 : GRID_DIMENSIONS_MM;

function probe(gx, gy) = bin_get_infill_size_mm(
        new_bin(grid_size = [gx, gy],
                grid_dimensions = unit,
                height_mm = fromGridfinityUnits(3),
                include_lip = include_lip));

GX = grid_x > 0 ? grid_x : min([for (g = [1:24]) if (probe(g, 1).x >= need_x) g]);
GY = grid_y > 0 ? grid_y : min([for (g = [1:24]) if (probe(1, g).y >= need_y) g]);
U  = height_units > 0 ? height_units : ceil(need_z / 7);

bin = new_bin(
    grid_size       = [GX, GY],
    grid_dimensions = unit,
    height_mm       = fromGridfinityUnits(U),
    fill_height     = extra_floor > 0 ? extra_floor : -fromGridfinityUnits(U),
    include_lip     = include_lip,
    hole_options    = holes,
    only_corners    = only_corners);

inner  = bin_get_infill_size_mm(bin);
outer  = bin_get_bounding_box(bin);

// Does a rail actually land somewhere dia_at() sizes correctly for bit i?
// Landing on the head or base is always fine (both have their own known
// diameter). Landing on the CHOSEN mount (neck or body) is fine too, since
// that's what the seat gets sized to. The only genuinely bad spots are the
// *other*, non-chosen one of neck/body (different diameter, sized wrong),
// or the waist (never sized to its own diameter at all).
function bad_lo(i) = mnt_neck(i) ? hl(i) + nl(i)         : hl(i);
function bad_hi(i) = mnt_neck(i) ? hl(i) + nl(i) + bl(i) : hl(i) + nl(i);
function waist_lo(i) = hl(i) + nl(i) + bl(i);
function waist_hi(i) = hl(i) + nl(i) + bl(i) + wl(i);
function in_bad_zone(i, d) =
    (d >= bad_lo(i)   && d < bad_hi(i))   ||
    (d >= waist_lo(i) && d < waist_hi(i));
function mount_ok(i) = !in_bad_zone(i, d_near(i)) && !in_bad_zone(i, d_far(i));
bad_mount_labels = [for (i = [0:nbits-1]) if (!mount_ok(i)) lbl(i)];

echo(str("Bin: ", GX, "x", GY, " @ ", unit.x, "mm cells x ", U, "u tall   outer ", outer, " mm"));
echo(str("Bits: ", nbits, "   rail spacing: ", G,
         " mm   bit centreline: ", axis_z - floor_z, " mm above the floor"));
if (G > gap_max)
    echo("*** WARNING: rail_gap too wide, a rail lands on a head - reduce it ***");
if (need_x > inner.x)
    echo("*** WARNING: bits are longer than the bin - increase grid_x ***");
if (need_y > inner.y)
    echo("*** WARNING: bits do not fit side by side - increase grid_y ***");
if (fromGridfinityUnits(U) < need_z)
    echo("*** NOTE: bits stand proud of the rim, bins will not stack ***");
if (len(bad_mount_labels) > 0)
    echo(str("*** WARNING: rails don't land on the chosen mount (neck/body) section for bit(s) ",
             bad_mount_labels, " - measure that section's width and try the other mount, or ",
             "adjust its neck/body/waist lengths ***"));


// =============================================================================
//  Geometry
// =============================================================================

// a shaft seat: straight-walled cradle at the bit's own diameter, a
// retention pinch narrower than the bit (the "click"), then a funnel
// back out to the rail top that eases inserting the bit in the first
// place. grip_pinch = 0 collapses the pinch section to nothing, giving
// the same plain funnel as before it existed.
module seat(d) {
    r = d/2 + slot_clearance;
    pinch_r = max(d/2 - grip_pinch, 0.1);
    pinch_z = axis_z + grip + grip_pinch_height;
    rotate([0, 90, 0]) {
        hull() {
            translate([-axis_z, 0, 0])
                cylinder(r = r, h = rail_width + 4, center = true);
            translate([-(axis_z + grip), 0, 0])
                cylinder(r = r, h = rail_width + 4, center = true);
        }
        hull() {
            translate([-(axis_z + grip), 0, 0])
                cylinder(r = r, h = rail_width + 4, center = true);
            translate([-pinch_z, 0, 0])
                cylinder(r = pinch_r, h = rail_width + 4, center = true);
        }
        hull() {
            translate([-pinch_z, 0, 0])
                cylinder(r = pinch_r, h = rail_width + 4, center = true);
            translate([-(rail_top + r + slot_flare), 0, 0])
                cylinder(r = r + slot_flare, h = rail_width + 4, center = true);
        }
    }
}

module rails() {
    difference() {
        for (x = [-G/2, G/2])
            translate([x - rail_width/2, -outer.y/2, floor_z - EPS])
                cube([rail_width, outer.y, rail_top - floor_z + EPS]);
        for (i = [0:nbits-1]) {
            translate([-G/2, cy(i), 0]) seat(dL(i));
            translate([ G/2, cy(i), 0]) seat(dR(i));
        }
    }
}

// keep the rails inside the walls lengthways, but let them run into the side
// walls so each rail is supported at both ends
module rails_clipped() {
    intersection() {
        rails();
        translate([-inner.x/2, -outer.y/2, floor_z - 1])
            cube([inner.x, outer.y, rail_top - floor_z + 2]);
    }
}

module engraving() {
    for (i = [0:nbits-1])
        if (lbl(i) != "")
            translate([0, cy(i), floor_z - label_depth])
                linear_extrude(label_depth + EPS)
                    text(lbl(i), size = label_size, halign = "center",
                         valign = "center");
}

module holder() {
    difference() {
        union() {
            bin_render(bin);
            rails_clipped();
        }
        if (labels) engraving();
    }
}

// a small printable coupon: a short strip of both rails with one bit's
// two seats cut in, for test-fitting grip_pinch/slot_clearance without
// printing the whole bin. See test_bit in [Testing].
module test_swatch() {
    // test_bit counts enabled bits in the order their slots appear
    // (bit_01, bit_02, ...), not sorted (largest-first) layout order, since
    // that's how they're numbered/labelled in the Customizer. order[]
    // maps sorted position -> original position, so find the sorted
    // position whose order[] entry matches the slot the user asked for.
    j = min(max(test_bit, 1), nbits) - 1;
    i = [for (k = [0:nbits-1]) if (order[k] == j) k][0];
    pad = 10;
    // no sideways overhang -- an upside-down Pi/U shape: the connecting
    // base spans exactly rail-to-rail, nothing sticking out past the legs
    sx = G + rail_width;
    sy = rail_width + 2*pad;
    // thin connector, just enough to hold the two rail "legs" together --
    // this is only for testing grip/fit, not a real gridfinity floor
    base_h = 2;
    // half the leg height to save time/material -- everything below
    // axis_z is just plain material anyway (the cutout itself lives
    // between axis_z and rail_top), so shorten from the BOTTOM and leave
    // the top -- and the cutout -- untouched. Clamped so it can never
    // shorten enough to reach into the cutout, regardless of bit sizes.
    full_leg_h = rail_top - floor_z;
    min_leg_h  = (rail_top - axis_z) + 2;
    leg_h = max(full_leg_h / 2, min_leg_h);
    shift = (rail_top - leg_h) - base_h;
    difference() {
        union() {
            translate([-sx/2, -sy/2, 0])
                cube([sx, sy, base_h]);
            translate([0, 0, -shift])
            for (x = [-G/2, G/2])
                translate([x - rail_width/2, -sy/2, rail_top - leg_h - EPS])
                    cube([rail_width, sy, leg_h + EPS]);
        }
        translate([0, 0, -shift]) {
            translate([-G/2, 0, 0]) seat(dL(i));
            translate([ G/2, 0, 0]) seat(dR(i));
        }
    }
}

if (test_bit > 0)
    test_swatch();
else if (section_view)
    difference() {
        holder();
        translate([-outer.x, cy(0), -1])
            cube([2*outer.x, outer.y, 2*outer.z + 2]);
    }
else
    holder();
