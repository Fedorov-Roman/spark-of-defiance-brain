# Time Dagger

## Mechanic

- **Hybrid dilation**: World slows to 30%, Kai moves at 100%.
- **Visual**: Fullscreen blue shader + air distortion.
- **Energy**: Limited, recharges at hub or via batteries.
- **Duration**: 2-3 seconds.

## Implementation

- Custom `delta` multiplier for `"time_affected"` group (enemies, traps, particles).
- Kai and UI excluded from group.
- NOT `Engine.time_scale` (would break UI and Kai animations).

## Up

[[MOC_Mechanics]]
