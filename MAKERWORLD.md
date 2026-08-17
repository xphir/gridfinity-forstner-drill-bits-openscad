# MakerWorld listing description

Copy/paste source for the MakerWorld listing. Not linked from the README —
this is just where the listing text lives so it's versioned with the model.

---

## Title

Gridfinity Forstner Bit Holder (Parametric)

(43 chars — MakerWorld's model name field caps out at 50.)

## Category

Organizers

## Tags

- parametric
- customisable
- gridfinity
- forstner bit
- bit
- tool

## Description

<!-- IMAGE: photos/hero-1.jpg — two trays side by side, small-bit set + large-bit set -->

A parametric Gridfinity tray for Forstner bits that actually fits *your*
set — enter your bits' measurements (or pick a known preset) and it
generates a custom holder sized exactly for them.

Forstner bits don't stack neatly like twist drills: the head is much wider
than the shank, so upright holders waste a ton of space. This tray lays
bits flat instead, alternating head-to-tail ("top and tail") so each bit's
wide head sits next to a neighbour's narrow shaft. Two notched rails cradle
each bit at its shaft, with a small retention pinch moulded into the seat
so bits click in and stay put instead of rattling around.

<!-- IMAGE: photos/above-small-bits.jpg — top-down shot showing the head-to-tail packing -->

**Works with MakerWorld's Customise button** — every field is a plain
number or checkbox, no fiddly list editing required.

### Features

- **Fits any Forstner set** — describe up to 20 bits (diameter + length for
  head/neck/body/waist/shank) and the tray sizes itself automatically.
- **Built-in preset** — the VEVOR 16-piece Forstner set is included as a
  one-click preset; just toggle which sizes you actually own.
- **Real retention grip** — a moulded pinch in each rail seat, not just a
  funnel, so bits hold with a light click instead of sliding loose.
- **Handles odd bit shapes** — some bits have a thin "neck" between head
  and shaft that's too short to grip normally; a per-bit switch lets you
  choose whether the rail grips the neck or the main body, with a warning
  if a bit's geometry won't work with either.
- **Test coupon mode** — render a small single-bit test piece instead of
  the full tray so you can dial in clearance/grip for your printer and
  filament before committing to a long print.
- **Split large sets across multiple prints** — rail spacing is tuned to
  the enabled bits, so a 16+ bit set prints better as two trays than one
  stretched-out tray.
- **Gridfinity-native base** — snaps onto any standard Gridfinity
  baseplate, including half-size (21 mm) footprints for tighter packing.
- **Auto-sized labels** engraved under each bit slot.

<!-- IMAGE: photos/stacked.jpg — two trays stacked, illustrating a split large set -->

### How to use it

1. Hit **Customise** on the print page (or open it in OpenSCAD's
   Customizer for the full experience).
2. Either pick a **Preset** (e.g. VEVOR 16 Pcs) and just toggle
   **Enabled bits**, or leave Preset on `None` and fill in your own bits'
   measurements under **Bit list** (it ships with a 5-bit generic example
   to start from).
3. Only `head_diameter` is required per bit — everything else falls back to
   sensible defaults you set once under **Bit defaults**.
4. **Strongly recommended:** before printing the full tray, set `test_bit`
   under **Testing** to a slot number (or `test_all_bits` to print one
   labelled coupon per enabled bit at once) and print that small coupon
   first — it takes minutes, not hours, and lets you dial in
   `slot_clearance` / `grip_pinch` for your printer and filament so the
   bits actually fit.
5. Once the coupon(s) fit the way you want, set `test_bit = 0` and
   `test_all_bits = false`, then print the full tray.

Full field-by-field reference and split-print guidance are on the
[GitHub repo](https://github.com/xphir/gridfinity-forstner-drill-bits-openscad).

### Print settings

<!-- IMAGE: photos/underside-half-grid.jpg — underside showing the half-grid Gridfinity base feet -->

My prints used the `allow_half_units` half-grid (21 mm) base — it dropped
the footprint from 3x4 grids to 2.5x4 for the same bits, a noticeably more
compact tray. Still snaps onto a standard Gridfinity baseplate.

Printed and tested with: 0.4 mm nozzle, 0.2 mm layers, Arachne walls,
3 wall loops, 15% gyroid infill, no supports needed. [Siddament Black
PLA+](https://siddament.com.au/products/black-pla-1) worked well; any
PLA/PLA+ should be fine.

At the default `slot_clearance` (0.05 mm) bits click in and hold firmly —
even fully upside down, nothing falls out — but they can be a little tight
to pull back out. Try 0.1 mm if you'd rather have easier removal at the
cost of a slightly less snug hold. Either way, check it with the
`test_bit` coupon on your own printer before committing to a full tray —
grip depends on your printer and filament.

### Credit

Base profile, stacking lip, and magnet/screw holes come from
[kennetek/gridfinity-rebuilt-openscad](https://github.com/kennetek/gridfinity-rebuilt-openscad)
(MIT licensed). This model only adds the bit rail geometry.

Inspired by PabloFernandez's [Gridfinity Bins for Forstner Drill Bits](https://www.printables.com/model/870351-gridfinity-bins-for-forstner-drill-bits)
on Printables.

### License

The source (GitHub repo) is MIT. MakerWorld doesn't offer MIT as a listing
license — it only offers Creative Commons-style toggles — so the closest
equivalent there is CC-BY.
