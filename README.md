# godot-4-ci-cd-test

This repository contains a simple 2d jump n run to experiment with ci/cd.

The game is a simple endless jump and run game where the player needs to evade falling
objects while climbing.

**Attention:** The game is buggy as I really just wanted to test some basic github workflows with the source code!

## Workflows

The repository contains three different workflows

- PR: The PR workflow is executed on pull request and runs gdunit4 tests
- Main: The Main workflow is executed on changes to main and compiles the games and adds the build artifacts to the job execution
- Release: The release workflow is executed when a new tag is created

### Environment and Secrets

For the workflows to work you need to define the following action variables and action secrets

***Variables***
- GODOT_VERSION: 4.2.1-stable
- ITCHIO_USERNAME: youritchiousername
- ITCHIO_GAME_ID: yourgameidonitchio

***Secrets**

- ITCHIO_API_KEY: youritchioapikey

## TODOS

Todo list will be removed sooner or later
- [ ] create core game mechanic
- [ ] add gdunit4 test cases
- [ ] add githubworkflows for pr, main builds 
- [ ] add python scripts to publish to itch.io

## Assets

All assets used in this projects are from [kenney.nl](https://kenney.nl/).
The assets are licensed under the [Creative Commons Zero, CC0](http://creativecommons.org/publicdomain/zero/1.0/) license.

- https://kenney.nl/assets/interface-sounds
- https://kenney.nl/assets/jumper-pack
