# Authoring Checklist

## Before Coding

- pick the correct family and base class
- find the nearest existing peer class
- decide whether the work is only code or also content-data integration

## During Coding

- follow local family style and naming
- keep fields explicit in the class body
- prefer public methods over reaching into private internals from other systems
- use `autoref` only where its lifecycle behavior is appropriate
- apply the interaction feedback and sustained-work rule from the skill, including completion-time revalidation

## After Coding

Check whether the object also needs updates in:

- loot templates
- craft recipes
- verbs and interactions
- proxy or slot behavior
- light config or model helpers
- map placement or editor documentation

## Editor And Runtime Follow-Up

When the editor needs to see the new class:

- rebuild the editor class library

When model mapping changed:

- consider regenerating the model map owned by `systools_GenerateModelData`

When gameplay behavior changed:

- run a focused simulation smoke test

## Good Final Sanity Checks

- class loads without breaking module order
- the new object appears in the expected library or content flow
- interactions, spawn paths, and derived data still make sense
