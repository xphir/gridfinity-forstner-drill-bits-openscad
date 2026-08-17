# gridfinity-forstner-drill-bits-openscad

Parametric Gridfinity bin for Forstner drill bits. Bits lie flat in an open
tray, cradled by two notched rails, alternating head-to-tail ("top and
tail") so each bit's head sits next to a neighbour's narrow shaft — packing
the set far tighter than standing them upright would.

Built on [kennetek/gridfinity-rebuilt-openscad](https://github.com/kennetek/gridfinity-rebuilt-openscad)
for the base profile, stacking lip, walls, and magnet/screw holes. This repo
only adds the rail geometry that cradles the bits.

![Two printed trays, one sized for a small-bit set and one for a large-bit set](photos/hero%20-%201.jpg)

## Setup

The library is a git submodule, so clone with `--recurse-submodules`:

```bash
git clone --recurse-submodules https://github.com/xphir/gridfinity-forstner-drill-bits-openscad.git
```

If you already cloned without that flag:

```bash
git submodule update --init
```

Open `gridfinity_forstner_flat_lib.scad` in [OpenSCAD](https://openscad.org/).

## Usage

The bit list is up to 20 slots (`bit01_*` through `bit20_*`), each with its
own `enabled` checkbox — flip a slot on and fill in its dimensions to add a
bit, or leave it off to skip it. All dimensions are in mm, measured from the
head end downwards, five sections per bit:

- `head_dia` / `head_len` — the cutting head, the widest part
- `neck_dia` / `neck_len` — short narrow transition right below the head
- `body_dia` / `body_len` — the main shaft (most of the bit's length)
- `waist_dia` / `waist_len` — narrow retention groove just above the shank
- `base_dia` / `base_len` — the shank that goes in the chuck

![Small Forstner bit segments labelled: head, neck, body, waist, base](photos/small%20bit%20-%20labeled.png)
![Large Forstner bit segments labelled: head, body, waist, base](photos/large%20bit%20-%20labeled.png)

Only `head_dia` needs a value on every enabled bit. Everything else defaults
to `0`, which means "use the matching `default_head_len` / `default_body_dia`
/ etc. value" in the **Bit defaults** section — handy since most forstner
sets share the same head length and shank across many sizes. Give a bit a
non-zero value in any of those fields to override the default just for that
one bit (e.g. if its shaft is a single constant diameter, set that bit's
`base_dia` equal to its `body_dia`).

Each bit also has a `mountN` field (`false` = body, `true` = neck), which
picks which of those two diameters actually grips that bit's rails. Most
bits should stay on `body`; switch a bit to `neck` if its body is short or
oddly proportioned next to its neighbours (a small bit whose neck is
proportionally long next to its shank, for example) — the model will warn
in the console if neither rail actually lands on the chosen section.

This scalar-per-field format (rather than a table or list) is deliberately
the most restrictive customizer-compatible shape there is, so it has the
best chance of showing up as editable fields both in the OpenSCAD Customizer
and in MakerWorld's parameter panel — neither reliably renders list-type
parameters.

![Top-down view of a tray showing bits alternating head-to-tail](photos/above%20-%20small%20bits.jpg)

Everything else — bin footprint, height, rail spacing, magnet/screw holes,
labels — auto-sizes from the enabled bits, or can be overridden in the
Customizer. See the comments in `gridfinity_forstner_flat_lib.scad` itself
for the full parameter reference.

### Known bit sets

The **Preset** dropdown can load a known set's measurements into the bit
fields for you (currently just the VEVOR 16-piece set). A preset only fills
in *sizes* — one preset row per slot — it never touches the `enabled`
checkboxes, so you can still turn individual slots on/off same as with a
hand-entered list. Pick `Custom` to go back to editing the fields yourself.

### Splitting a large set across multiple prints

A full 16+ bit set makes for a long tray and a long print. Since rail
spacing is shared across every enabled bit, splitting the set into two
prints — rather than just picking a smaller `grid_x`/`grid_y` — keeps each
print's rail spacing tuned to a narrower size range instead of being
stretched to fit both your smallest and largest bits at once. With the
VEVOR set, for example: enable bits 1–10 for one print, then 11–16 for a
second, by flipping the rest off in **Enabled bits** (works the same way
whether you're using the preset or a hand-entered list).

![Two trays stacked, one for the small-bit split and one for the large-bit split](photos/stacked.jpg)

### Half-grid footprint

Set `allow_half_units` (in **Bin**) to size the tray in 21 mm half-units
instead of full 42 mm Gridfinity units, for a tighter footprint when a
full unit per row would waste space. It still snaps onto a standard
Gridfinity baseplate.

![Underside of a tray printed with the half-grid footprint](photos/underside%20-%20half%20grid.jpg)

### Testing grip/fit before committing to a full print

Set `test_bit` (in **Testing**) to a slot number to render a small, fast
coupon instead of the whole bin — just enough rail to test-fit that one
bit and feel whether the retention pinch actually grips. Much quicker than
re-printing the full tray while dialing in `slot_clearance` and
`grip_pinch` for your printer/filament.

## Gallery

![Angled close-up of both trays](photos/hero%20-%202.jpg)
![Top-down view of the large-bit tray](photos/above%20-%20large%20bits.jpg)
![Closer angled view of the large-bit tray](photos/close%20angle%20-%20large%20bits.jpg)

## Status

Verified to compile to a clean manifold solid. First real test print
confirmed the flat-lay/top-and-tail layout works; slot_clearance and the
retention pinch are still being tuned against real prints. The VEVOR
preset's dimensions come from a real set; anything you enter by hand
should still be measured against your own bits before printing.

## License

MIT — see [LICENSE](LICENSE). The bundled `gridfinity-rebuilt-openscad`
submodule is separately licensed (also MIT) by its own authors.
