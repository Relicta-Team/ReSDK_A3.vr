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
- Damage characters and destructible world objects. Close victims can receive secondary-zone trauma; wound processing may break bones, destroy extremities, and rupture torso or abdominal organs according to injury severity and health checks.
- Cover is based on geometry intersection, not player visibility or `canSeeObject`.

### Shrapnel

- Cast 20 physical rays from just above the grenade.
- Each ray receives a random azimuth and a small positive elevation. Together the possible paths form a shallow, upward-climbing 360-degree cone.
- Resolve only the first physical hit per ray, translate engine objects back to game objects, and apply piercing damage with distance falloff.
- Because the rays are geometric, going prone materially reduces exposed area without a special posture multiplier.

## Client effects

- Wire the existing `SLIGHT_FX_GRENADE` particle placeholder to real grenade detonation and repair its stale emitter reference.
- Add a client concussion event inside a six-metre radius: tinnitus, camera shake, and a low-pass filter shared by ordinary positional sounds and remote player voices.
- A visible blast applies one decaying afterimage effect lasting from five seconds at the edge to sixty seconds at the epicentre. It raises brightness, lifts the contrast offset, and reduces contrast to represent lost dark adaptation without darkening the image.
- Repeated blasts keep the stronger remaining effect rather than starting competing update loops.

## Validation

- Static checks: macro/preprocessor balance, class and verb registration, RPC registration, generated enum visibility for the new damage type, and absence of map/role/loot references.
- State tests in simulation: safe to pin pulled; explicit and inventory replacement; lever release on second interaction, handoff, drop, placement, and throw; fuse persistence through movement; dud reveal; stale-callback and double-detonation guards.
- Physical tests: ordinary landing before fuse expiry, fuse expiry in flight, blast cover, falloff, object damage, shallow-cone fragment traces, prone exposure, and close-range wound severity.
- Client tests: particle creation without script errors, tinnitus and low-pass decay, voice muffling, sight-gated afterimage without dark recovery, and repeated explosions.
- Final runtime confidence must distinguish repository/static validation from behavior actually observed in an Arma/ReEditor session.
