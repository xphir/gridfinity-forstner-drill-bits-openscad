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
//  BIT LIST -- up to 20 slots below (Bit defaults, then Enabled bits, then
//  Bit list). Turn a slot off in "Enabled bits" to skip it entirely;
//  disabled slots don't affect sizing/layout at all. All dimensions in mm,
//  measured from the head end downwards, five sections per bit (see
//  photos/ for a labelled reference):
//
//    head  -- the cutting head, the widest part
//    neck  -- short narrow transition right below the head
//    body  -- the main shaft (most of the bit's length)
//    waist -- narrow retention groove just above the shank
//    base  -- the shank that goes in the chuck
//
//  head_dia is always read from the bit's own field -- it's the one number
//  that actually distinguishes one bit from another. Every other field
//  (head_len, neck_dia, neck_len, body_dia, body_len, waist_dia, waist_len,
//  base_dia, base_len) defaults to 0, meaning "use the matching default_*
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

/* [Bit defaults] */
// Used by any bit below that leaves its own head_len/neck_dia/neck_len/
// body_dia/body_len/waist_dia/waist_len/base_dia/base_len at 0. Does not
// apply to head_dia -- that always comes from the bit's own field.
default_head_len  = 15;
default_neck_dia  = 8;
default_neck_len  = 0;
default_body_dia  = 8;
default_body_len  = 40;
default_waist_dia = 8;
default_waist_len = 0;
default_base_dia  = 8;
default_base_len  = 25;

/* [Enabled bits] */
// Which of the 20 slots below are active. Grouped here so you can see and
// flip them all at a glance without scrolling through every bit's
// dimension fields.
bit01_enabled = true;
bit02_enabled = true;
bit03_enabled = true;
bit04_enabled = true;
bit05_enabled = true;
bit06_enabled = true;
bit07_enabled = false;
bit08_enabled = false;
bit09_enabled = false;
bit10_enabled = false;
bit11_enabled = false;
bit12_enabled = false;
bit13_enabled = false;
bit14_enabled = false;
bit15_enabled = false;
bit16_enabled = false;
bit17_enabled = false;
bit18_enabled = false;
bit19_enabled = false;
bit20_enabled = false;

/* [Bit list] */

// -- Bit 01 --
bit01_head_dia  = 15;
bit01_head_len  = 14;
bit01_neck_dia  = 0;
bit01_neck_len  = 0;
bit01_body_dia  = 0;
bit01_body_len  = 46;
bit01_waist_dia = 0;
bit01_waist_len = 0;
bit01_base_dia  = 0;
bit01_base_len  = 0;
bit01_mount_neck = false;

// -- Bit 02 --
bit02_head_dia  = 18;
bit02_head_len  = 0;
bit02_neck_dia  = 0;
bit02_neck_len  = 0;
bit02_body_dia  = 0;
bit02_body_len  = 45;
bit02_waist_dia = 0;
bit02_waist_len = 0;
bit02_base_dia  = 0;
bit02_base_len  = 0;
bit02_mount_neck = false;

// -- Bit 03 --
bit03_head_dia  = 20;
bit03_head_len  = 16;
bit03_neck_dia  = 0;
bit03_neck_len  = 0;
bit03_body_dia  = 0;
bit03_body_len  = 44;
bit03_waist_dia = 0;
bit03_waist_len = 0;
bit03_base_dia  = 0;
bit03_base_len  = 0;
bit03_mount_neck = false;

// -- Bit 04 --
bit04_head_dia  = 25;
bit04_head_len  = 18;
bit04_neck_dia  = 0;
bit04_neck_len  = 0;
bit04_body_dia  = 0;
bit04_body_len  = 42;
bit04_waist_dia = 0;
bit04_waist_len = 0;
bit04_base_dia  = 0;
bit04_base_len  = 0;
bit04_mount_neck = false;

// -- Bit 05 --
bit05_head_dia  = 30;
bit05_head_len  = 20;
bit05_neck_dia  = 0;
bit05_neck_len  = 0;
bit05_body_dia  = 10;
bit05_body_len  = 0;
bit05_waist_dia = 0;
bit05_waist_len = 0;
bit05_base_dia  = 10;
bit05_base_len  = 0;
bit05_mount_neck = false;

// -- Bit 06 --
bit06_head_dia  = 35;
bit06_head_len  = 22;
bit06_neck_dia  = 0;
bit06_neck_len  = 0;
bit06_body_dia  = 10;
bit06_body_len  = 38;
bit06_waist_dia = 0;
bit06_waist_len = 0;
bit06_base_dia  = 10;
bit06_base_len  = 0;
bit06_mount_neck = false;

// -- Bit 07 --
bit07_head_dia  = 10;
bit07_head_len  = 0;
bit07_neck_dia  = 0;
bit07_neck_len  = 0;
bit07_body_dia  = 0;
bit07_body_len  = 0;
bit07_waist_dia = 0;
bit07_waist_len = 0;
bit07_base_dia  = 0;
bit07_base_len  = 0;
bit07_mount_neck = false;

// -- Bit 08 --
bit08_head_dia  = 10;
bit08_head_len  = 0;
bit08_neck_dia  = 0;
bit08_neck_len  = 0;
bit08_body_dia  = 0;
bit08_body_len  = 0;
bit08_waist_dia = 0;
bit08_waist_len = 0;
bit08_base_dia  = 0;
bit08_base_len  = 0;
bit08_mount_neck = false;

// -- Bit 09 --
bit09_head_dia  = 10;
bit09_head_len  = 0;
bit09_neck_dia  = 0;
bit09_neck_len  = 0;
bit09_body_dia  = 0;
bit09_body_len  = 0;
bit09_waist_dia = 0;
bit09_waist_len = 0;
bit09_base_dia  = 0;
bit09_base_len  = 0;
bit09_mount_neck = false;

// -- Bit 10 --
bit10_head_dia  = 10;
bit10_head_len  = 0;
bit10_neck_dia  = 0;
bit10_neck_len  = 0;
bit10_body_dia  = 0;
bit10_body_len  = 0;
bit10_waist_dia = 0;
bit10_waist_len = 0;
bit10_base_dia  = 0;
bit10_base_len  = 0;
bit10_mount_neck = false;

// -- Bit 11 --
bit11_head_dia  = 10;
bit11_head_len  = 0;
bit11_neck_dia  = 0;
bit11_neck_len  = 0;
bit11_body_dia  = 0;
bit11_body_len  = 0;
bit11_waist_dia = 0;
bit11_waist_len = 0;
bit11_base_dia  = 0;
bit11_base_len  = 0;
bit11_mount_neck = false;

// -- Bit 12 --
bit12_head_dia  = 10;
bit12_head_len  = 0;
bit12_neck_dia  = 0;
bit12_neck_len  = 0;
bit12_body_dia  = 0;
bit12_body_len  = 0;
bit12_waist_dia = 0;
bit12_waist_len = 0;
bit12_base_dia  = 0;
bit12_base_len  = 0;
bit12_mount_neck = false;

// -- Bit 13 --
bit13_head_dia  = 10;
bit13_head_len  = 0;
bit13_neck_dia  = 0;
bit13_neck_len  = 0;
bit13_body_dia  = 0;
bit13_body_len  = 0;
bit13_waist_dia = 0;
bit13_waist_len = 0;
bit13_base_dia  = 0;
bit13_base_len  = 0;
bit13_mount_neck = false;

// -- Bit 14 --
bit14_head_dia  = 10;
bit14_head_len  = 0;
bit14_neck_dia  = 0;
bit14_neck_len  = 0;
bit14_body_dia  = 0;
bit14_body_len  = 0;
bit14_waist_dia = 0;
bit14_waist_len = 0;
bit14_base_dia  = 0;
bit14_base_len  = 0;
bit14_mount_neck = false;

// -- Bit 15 --
bit15_head_dia  = 10;
bit15_head_len  = 0;
bit15_neck_dia  = 0;
bit15_neck_len  = 0;
bit15_body_dia  = 0;
bit15_body_len  = 0;
bit15_waist_dia = 0;
bit15_waist_len = 0;
bit15_base_dia  = 0;
bit15_base_len  = 0;
bit15_mount_neck = false;

// -- Bit 16 --
bit16_head_dia  = 10;
bit16_head_len  = 0;
bit16_neck_dia  = 0;
bit16_neck_len  = 0;
bit16_body_dia  = 0;
bit16_body_len  = 0;
bit16_waist_dia = 0;
bit16_waist_len = 0;
bit16_base_dia  = 0;
bit16_base_len  = 0;
bit16_mount_neck = false;

// -- Bit 17 --
bit17_head_dia  = 10;
bit17_head_len  = 0;
bit17_neck_dia  = 0;
bit17_neck_len  = 0;
bit17_body_dia  = 0;
bit17_body_len  = 0;
bit17_waist_dia = 0;
bit17_waist_len = 0;
bit17_base_dia  = 0;
bit17_base_len  = 0;
bit17_mount_neck = false;

// -- Bit 18 --
bit18_head_dia  = 10;
bit18_head_len  = 0;
bit18_neck_dia  = 0;
bit18_neck_len  = 0;
bit18_body_dia  = 0;
bit18_body_len  = 0;
bit18_waist_dia = 0;
bit18_waist_len = 0;
bit18_base_dia  = 0;
bit18_base_len  = 0;
bit18_mount_neck = false;

// -- Bit 19 --
bit19_head_dia  = 10;
bit19_head_len  = 0;
bit19_neck_dia  = 0;
bit19_neck_len  = 0;
bit19_body_dia  = 0;
bit19_body_len  = 0;
bit19_waist_dia = 0;
bit19_waist_len = 0;
bit19_base_dia  = 0;
bit19_base_len  = 0;
bit19_mount_neck = false;

// -- Bit 20 --
bit20_head_dia  = 10;
bit20_head_len  = 0;
bit20_neck_dia  = 0;
bit20_neck_len  = 0;
bit20_body_dia  = 0;
bit20_body_len  = 0;
bit20_waist_dia = 0;
bit20_waist_len = 0;
bit20_base_dia  = 0;
bit20_base_len  = 0;
bit20_mount_neck = false;


/* [Layout] */

// Reverse every second bit (top and tail). Off = all heads the same end.
alternate = true;
// Sort the bit list largest-head-first before laying out. Off = keep the
// order you typed them in (useful for testing a specific arrangement).
sort_bits = true;
// Air gap between neighbouring bits
bit_gap = 2;
// Gap between the ends of the bits and the inside of the bin wall
end_gap = 2;
// Air under the heads, so you can get a finger under a bit to lift it
head_floor_gap = 2;


/* [Rails] */

// Distance between the two rails. 0 = auto (as far apart as the bits allow).
rail_gap = 0;
// Width of each rail (and the seat cut into it) along the bit's length.
rail_width = 6;
// Keep the rail at least this far clear of the back of the head
rail_margin = 1.5;
// Extra radius added to every seat so bits aren't a dead-tight press fit.
slot_clearance = 0.3;
// How far the seat continues straight up past the shaft centreline
grip = 1.5;
// Funnel widening at the mouth of each seat
slot_flare = 1.2;
// Minimum material left between two neighbouring seats
rail_wall = 1.6;


/* [Bin] */

// Footprint in gridfinity units (grid_x = length, grid_y = depth).
// 0 = auto-size to the bits.
grid_x = 0;
grid_y = 0;
// Build the whole base on a 21 mm pitch instead of the standard 42 mm one,
// so the footprint can round to the nearest half unit instead of a whole
// one -- more compact. Magnet/screw holes follow the same 21 mm pitch, so
// they won't land on a real 42 mm baseplate's hole spacing.
allow_half_units = false;
// Height in gridfinity units (7 mm each). 0 = auto.
height_units = 0;
// Extra floor on top of the library's 7 mm base. Usually leave at 0.
// If include_lip is off, this MUST be > 0 -- without a lip the library
// builds the outer wall from the infill, so a zero-infill bin has no walls.
extra_floor = 0;
// Air above the tallest bit. Only used when height_units = 0 (auto).
top_clearance = 2;

// Stacking lip around the top rim, so another bin can stack on this one.
// If off, see the extra_floor note above.
include_lip = true;

/* [Base holes] */
// Hole for a 6mm magnet in each base cell.
magnet_holes = false;
// Hole for an M3 screw in each base cell.
screw_holes = false;
// Ribs that grip a pressed-in magnet without glue.
// Only has an effect if magnet_holes is on.
crush_ribs = true;
// Chamfer the top edge of the hole(s).
// Only has an effect if magnet_holes and/or screw_holes is on.
chamfer_holes = true;
// Print the hole(s) without support material.
// Only has an effect if magnet_holes and/or screw_holes is on.
supportless = true;
// Put holes in the outer corner cells only, instead of every cell.
// Only has an effect if magnet_holes and/or screw_holes is on.
only_corners = false;


/* [Labels] */
// Engrave each bit's label (from the bit list) into the floor under it.
labels = true;
// Text height. Only has an effect if labels is on.
label_size = 5;
// How deep the text is cut into the floor. Only has an effect if labels
// is on.
label_depth = 0.6;


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

// Gather the 20 individual bit slots above into plain lists, keeping only
// the enabled ones and resolving any 0 (default sentinel) fields
// against default_*. This is the only place that needs to know there are
// 20 separate slots -- everything below just works with a simple list,
// same as before the slots existed.
_enabled        = [bit01_enabled, bit02_enabled, bit03_enabled, bit04_enabled, bit05_enabled, bit06_enabled, bit07_enabled, bit08_enabled, bit09_enabled, bit10_enabled, bit11_enabled, bit12_enabled, bit13_enabled, bit14_enabled, bit15_enabled, bit16_enabled, bit17_enabled, bit18_enabled, bit19_enabled, bit20_enabled];
_head_dia_raw   = [bit01_head_dia, bit02_head_dia, bit03_head_dia, bit04_head_dia, bit05_head_dia, bit06_head_dia, bit07_head_dia, bit08_head_dia, bit09_head_dia, bit10_head_dia, bit11_head_dia, bit12_head_dia, bit13_head_dia, bit14_head_dia, bit15_head_dia, bit16_head_dia, bit17_head_dia, bit18_head_dia, bit19_head_dia, bit20_head_dia];
_head_len_raw   = [bit01_head_len, bit02_head_len, bit03_head_len, bit04_head_len, bit05_head_len, bit06_head_len, bit07_head_len, bit08_head_len, bit09_head_len, bit10_head_len, bit11_head_len, bit12_head_len, bit13_head_len, bit14_head_len, bit15_head_len, bit16_head_len, bit17_head_len, bit18_head_len, bit19_head_len, bit20_head_len];
_neck_dia_raw   = [bit01_neck_dia, bit02_neck_dia, bit03_neck_dia, bit04_neck_dia, bit05_neck_dia, bit06_neck_dia, bit07_neck_dia, bit08_neck_dia, bit09_neck_dia, bit10_neck_dia, bit11_neck_dia, bit12_neck_dia, bit13_neck_dia, bit14_neck_dia, bit15_neck_dia, bit16_neck_dia, bit17_neck_dia, bit18_neck_dia, bit19_neck_dia, bit20_neck_dia];
_neck_len_raw   = [bit01_neck_len, bit02_neck_len, bit03_neck_len, bit04_neck_len, bit05_neck_len, bit06_neck_len, bit07_neck_len, bit08_neck_len, bit09_neck_len, bit10_neck_len, bit11_neck_len, bit12_neck_len, bit13_neck_len, bit14_neck_len, bit15_neck_len, bit16_neck_len, bit17_neck_len, bit18_neck_len, bit19_neck_len, bit20_neck_len];
_body_dia_raw   = [bit01_body_dia, bit02_body_dia, bit03_body_dia, bit04_body_dia, bit05_body_dia, bit06_body_dia, bit07_body_dia, bit08_body_dia, bit09_body_dia, bit10_body_dia, bit11_body_dia, bit12_body_dia, bit13_body_dia, bit14_body_dia, bit15_body_dia, bit16_body_dia, bit17_body_dia, bit18_body_dia, bit19_body_dia, bit20_body_dia];
_body_len_raw   = [bit01_body_len, bit02_body_len, bit03_body_len, bit04_body_len, bit05_body_len, bit06_body_len, bit07_body_len, bit08_body_len, bit09_body_len, bit10_body_len, bit11_body_len, bit12_body_len, bit13_body_len, bit14_body_len, bit15_body_len, bit16_body_len, bit17_body_len, bit18_body_len, bit19_body_len, bit20_body_len];
_waist_dia_raw  = [bit01_waist_dia, bit02_waist_dia, bit03_waist_dia, bit04_waist_dia, bit05_waist_dia, bit06_waist_dia, bit07_waist_dia, bit08_waist_dia, bit09_waist_dia, bit10_waist_dia, bit11_waist_dia, bit12_waist_dia, bit13_waist_dia, bit14_waist_dia, bit15_waist_dia, bit16_waist_dia, bit17_waist_dia, bit18_waist_dia, bit19_waist_dia, bit20_waist_dia];
_waist_len_raw  = [bit01_waist_len, bit02_waist_len, bit03_waist_len, bit04_waist_len, bit05_waist_len, bit06_waist_len, bit07_waist_len, bit08_waist_len, bit09_waist_len, bit10_waist_len, bit11_waist_len, bit12_waist_len, bit13_waist_len, bit14_waist_len, bit15_waist_len, bit16_waist_len, bit17_waist_len, bit18_waist_len, bit19_waist_len, bit20_waist_len];
_base_dia_raw   = [bit01_base_dia, bit02_base_dia, bit03_base_dia, bit04_base_dia, bit05_base_dia, bit06_base_dia, bit07_base_dia, bit08_base_dia, bit09_base_dia, bit10_base_dia, bit11_base_dia, bit12_base_dia, bit13_base_dia, bit14_base_dia, bit15_base_dia, bit16_base_dia, bit17_base_dia, bit18_base_dia, bit19_base_dia, bit20_base_dia];
_base_len_raw   = [bit01_base_len, bit02_base_len, bit03_base_len, bit04_base_len, bit05_base_len, bit06_base_len, bit07_base_len, bit08_base_len, bit09_base_len, bit10_base_len, bit11_base_len, bit12_base_len, bit13_base_len, bit14_base_len, bit15_base_len, bit16_base_len, bit17_base_len, bit18_base_len, bit19_base_len, bit20_base_len];
_mount_neck_raw = [bit01_mount_neck, bit02_mount_neck, bit03_mount_neck, bit04_mount_neck, bit05_mount_neck, bit06_mount_neck, bit07_mount_neck, bit08_mount_neck, bit09_mount_neck, bit10_mount_neck, bit11_mount_neck, bit12_mount_neck, bit13_mount_neck, bit14_mount_neck, bit15_mount_neck, bit16_mount_neck, bit17_mount_neck, bit18_mount_neck, bit19_mount_neck, bit20_mount_neck];

_active = [for (i = [0:19]) if (_enabled[i]) i];

head_dias   = [for (i = _active) _head_dia_raw[i]];
head_lens   = [for (i = _active) _head_len_raw[i]   > 0 ? _head_len_raw[i]   : default_head_len];
neck_dias   = [for (i = _active) _neck_dia_raw[i]   > 0 ? _neck_dia_raw[i]   : default_neck_dia];
neck_lens   = [for (i = _active) _neck_len_raw[i]   > 0 ? _neck_len_raw[i]   : default_neck_len];
body_dias   = [for (i = _active) _body_dia_raw[i]   > 0 ? _body_dia_raw[i]   : default_body_dia];
body_lens   = [for (i = _active) _body_len_raw[i]   > 0 ? _body_len_raw[i]   : default_body_len];
waist_dias  = [for (i = _active) _waist_dia_raw[i]  > 0 ? _waist_dia_raw[i]  : default_waist_dia];
waist_lens  = [for (i = _active) _waist_len_raw[i]  > 0 ? _waist_len_raw[i]  : default_waist_len];
base_dias   = [for (i = _active) _base_dia_raw[i]   > 0 ? _base_dia_raw[i]   : default_base_dia];
base_lens   = [for (i = _active) _base_len_raw[i]   > 0 ? _base_len_raw[i]   : default_base_len];
mount_necks = [for (i = _active) _mount_neck_raw[i]];

// tied directly into nbits's own definition (rather than a separate bare
// assert() statement) because OpenSCAD evaluates top-level variables
// somewhat independently of statement order -- a standalone assert() can
// end up NOT running before other variables that depend on nbits get
// evaluated, producing a cascade of cryptic "undefined operation" warnings
// instead of this message.
nbits = assert(len(head_dias) > 0, "enable at least one bit (bit01_enabled etc.)") len(head_dias);

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
function mount_dia(i) = mnt_neck(i) ? nd(i) : bd(i);
// diameter of bit i at distance d from its head end. Anywhere between the
// head and the base is sized to the chosen mount diameter rather than
// tracking the exact neck/body/waist boundaries -- simpler, and avoids a
// rail landing on a thin, unintended transition by accident.
function dia_at(i, d) = d < hl(i)              ? hd(i) :
                        d >= bitlen(i) - sl(i)  ? sd(i) : mount_dia(i);
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
rail_top = axis_z + grip + 0.8;

max_len  = max([for (i = [0:nbits-1]) bitlen(i)]);
need_x   = max_len + 2*end_gap;
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

// does bit i's mount segment (neck or body) actually span both rail
// positions, or does a rail spill into a neighbouring segment (head, the
// other of neck/body, or waist) where the seat would be sized wrong?
function mount_lo(i) = mnt_neck(i) ? hl(i) : hl(i) + nl(i);
function mount_hi(i) = mnt_neck(i) ? hl(i) + nl(i) : hl(i) + nl(i) + bl(i);
function mount_ok(i) =
    d_near(i) >= mount_lo(i) && d_near(i) <= mount_hi(i) &&
    d_far(i)  >= mount_lo(i) && d_far(i)  <= mount_hi(i);
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

// a shaft seat: circular cradle, straight sides, then a funnel to the rail top
module seat(d) {
    r = d/2 + slot_clearance;
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

if (section_view)
    difference() {
        holder();
        translate([-outer.x, cy(0), -1])
            cube([2*outer.x, outer.y, 2*outer.z + 2]);
    }
else
    holder();
