# gridfinity-forstner-drill-bits-openscad

Parametric Gridfinity bin for Forstner drill bits. Bits lie flat in an open
tray, cradled by two notched rails, alternating head-to-tail ("top and
tail") so each bit's head sits next to a neighbour's narrow shaft — packing
the set far tighter than standing them upright would.

Built on [kennetek/gridfinity-rebuilt-openscad](https://github.com/kennetek/gridfinity-rebuilt-openscad)
for the base profile, stacking lip, walls, and magnet/screw holes. This repo
only adds the rail geometry that cradles the bits.

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
head end downwards:

- `head_dia` / `head_len` — the cutting head, the widest part
- `neck_dia` / `neck_len` — the shaft between head and shank
- `base_dia` / `base_len` — the shank that goes in the chuck

Only `head_dia` needs a value on every enabled bit. Everything else defaults
to `0`, which means "use the matching `default_head_len` / `default_neck_dia`
/ etc. value" in the **Bit defaults** section — handy since most forstner
sets share the same head length and shank across many sizes. Give a bit a
non-zero value in any of those fields to override the default just for that
one bit (e.g. if its shaft is a single constant diameter, set that bit's
`base_dia` equal to its `neck_dia`).

This scalar-per-field format (rather than a table or list) is deliberately
the most restrictive customizer-compatible shape there is, so it has the
best chance of showing up as editable fields both in the OpenSCAD Customizer
and in MakerWorld's parameter panel — neither reliably renders list-type
parameters.

Everything else — bin footprint, height, rail spacing, magnet/screw holes,
labels — auto-sizes from the enabled bits, or can be overridden in the
Customizer. See the comments in `gridfinity_forstner_flat_lib.scad` itself
for the full parameter reference.

## Status

Verified to compile to a clean manifold solid; nothing has been printed or
fit-tested yet. The sample bit dimensions are placeholders — measure your
actual set before printing.

## License

MIT — see [LICENSE](LICENSE). The bundled `gridfinity-rebuilt-openscad`
submodule is separately licensed (also MIT) by its own authors.
