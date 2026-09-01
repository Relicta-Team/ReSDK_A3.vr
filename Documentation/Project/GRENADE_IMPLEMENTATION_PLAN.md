# Grenade implementation plan

## Scope and constraints

- Add test-spawnable fragmentation grenades without placing them in roles, maps, craft, or loot tables. The existing `spawnitem Grenade` command is the test entry point.
- Keep grenade decisions server-authoritative. Clients receive only audiovisual concussion and explosion-effect messages.
- Keep the existing item-throw flight model for the MVP. Grenades receive a throwing-skill modifier rather than a second physics system.
- Determine fuse duration and dud status when the grenade object is constructed. Neither value changes when the lever is released.
- The pin is replaced only by the explicit context action. A pin-pulled grenade that leaves a hand releases its lever automatically.

## Grenade state machine

The grenade has five terminally ordered states: `safe`, `pin pulled`, `fuse burning`, `dud`, and `detonated`.

- Main interaction in `safe` pulls the pin, plays the pin sound, and broadcasts a conspicuous warning.
- Main interaction in `pin pulled` releases the lever and starts the already-generated fuse.
- `Replace pin` is available from the context menu only while the pin is pulled. It returns the grenade to `safe`, plays a distinct sound, and broadcasts a relief message.
- Moving a pin-pulled grenade out of a hand, including into an inventory or container, releases the lever.
- Giving, dropping, placing, or throwing a pin-pulled grenade also releases the lever. Moving an already-burning grenade never stops its fuse.
- Fuse callbacks carry a generation token and recheck state. Stale callbacks and repeated transitions therefore cannot detonate an object twice.
- A dud is revealed only when its fuse expires without an explosion. It remains an inert object.
- If a live fuse expires during flight, the flight object is stopped and materialized before detonation so all damage and effect calculations use a valid world position.

## Throwing

- Add an item-level throwing-skill modifier hook and give grenades a positive modifier.
- Preserve the current Bézier trajectory, gravity, collision, and landing behavior.
- Landing does not trigger an explosion by itself. Only the fuse deadline does.

## Explosion model

The server resolves two independent effects from a point slightly above the grenade model.

### Blast wave

- Add a distinct `blast` damage type. It is blunt pressure trauma, not ordinary crushing damage wearing a different label.
- Apply distance falloff inside the smaller blast radius and require a physical line of effect.
- Use a five-metre blast radius and roll one base pressure value per explosion so distance falloff remains monotonic before armour and object DR.
- Damage characters and all nearby destructible object families. Objects receive a separate pressure multiplier. Close victims can receive secondary-zone trauma; wound processing may break bones, destroy extremities, and rupture torso or abdominal organs according to injury severity and health checks.
- Probe directly below the detonation as well as querying nearby object origins, so broad floors and structures under the grenade remain blast targets even when their model origin lies outside the five-metre radius.
- Select mob blast zones from the nearest animated head, torso, pelvis, or leg selection rather than from the entity origin. A grenade exploding in a held hand destroys that arm unconditionally.
- Cover is based on geometry intersection, not player visibility or `canSeeObject`.

### Shrapnel

- Cast 50 physical rays from just above the grenade, distributed across 12 equal azimuth sectors.
- Each ray receives a random position inside its sector and a positive elevation between 1 and 16 degrees. Together the possible paths form a shallow, upward-climbing 360-degree cone.
- Resolve all first-hit raycasts before creating projectiles. Mob impacts remain independent because each ray may resolve against a different body part. Repeated impacts against the same destructible non-mob object are collapsed into one logical projectile whose dice count is multiplied by the number of hits.
- Logical impacts are consumed three at a time on subsequent frames and receive piercing damage with distance falloff. Every collapsed non-mob ray after the chosen logical hit, plus hits on unmapped or non-destructible world geometry, emits the ordinary short-lived material impact used by melee damage.
- Because the rays are geometric, going prone materially reduces exposed area without a special posture multiplier.

## Client effects

- Use the dedicated `SLIGHT_FX_GRENADE_1` scripted particle effect for grenade detonation.
- Add a client concussion event inside an eight-metre radius: listener-local tinnitus and a low-pass filter shared by ordinary positional sounds and remote player voices. Both remain steady for six seconds, decay over four seconds, and are explicitly disabled after ten seconds. Grenade audio uses the repository-standard Ogg Vorbis encoding; Ogg Opus was accepted by tooling but failed to load in the deployed game audio path.
- Send a single distance-scaled camera shake to everyone within ten metres. The epicentre is anchored at `0.18 / 14`, twice the legacy `0.09 / 7` strength. The required 2.5 centre-to-edge ratio derives edge coefficients of `0.072 / 5.6`; wound pain and agony retain their independent presentation.
- A visible blast drives a persistent, non-interactive screen overlay from one absolute-time envelope evaluated every frame: transparent at detonation, 80% of the configured distance-scaled darkness at 0.3 seconds, 40% at one second, and a smooth return to transparent at five seconds. It has no queued widget animations that can outlive the envelope. The dark channel does not share the ColorCorrections/HDR state used by health and lighting effects. DynamicBlur performs its own smooth decay over at most twenty seconds without periodic pulses or chromatic aberration.
- Repeated blasts keep the stronger remaining effect rather than starting competing update loops.
- Play the explosion from its captured world position rather than from the grenade pointer, which is deleted immediately after detonation. The 120-metre parameter is the 3D rolloff boundary, not constant-volume reach, so the source asset is normalized to carry at useful mid-range distances.

## Validation

- Static checks: macro/preprocessor balance in release, ordinary-debug, and `DEBUG_GRENADES` configurations; class and verb registration; RPC registration; generated enum visibility for the new damage type; and absence of map/role/loot references.
- State tests in simulation: safe to pin pulled; explicit and inventory replacement; lever release on second interaction, handoff, drop, placement, and throw; fuse persistence through movement; dud reveal; stale-callback and double-detonation guards.
- Physical tests: ordinary landing before fuse expiry, fuse expiry in flight, blast cover, monotonic falloff, item/structure damage, height-dependent body zones, held-arm destruction, 12-sector fragment traces, scheduled hit batches, world-geometry dust, prone exposure, and close-range wound severity.
- Client tests: particle creation without script errors, explosion audibility at measured distances, tinnitus and low-pass decay, voice muffling, sight-gated one-way dark adaptation and afterimage recovery without cycling, one-off ten-metre camera shake with 2.5-to-1 centre/edge strength, absence of grenade-owned chromatic aberration, and repeated explosions.
- Final runtime confidence must distinguish repository/static validation from behavior actually observed in an Arma/ReEditor session.
