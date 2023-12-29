# godot-4-ci-cd-test

This repository contains a simple 2d jump n run to experiment with ci/cd.

The game is a simple endless jump and run game where the player needs to evade falling
objects while climbing.

**Attention:** The game is buggy as I really just wanted to test some basic github workflows with the source code!

## Workflows

The repository contains three different workflows

- PR: The PR workflow is executed on pull request and runs gdunit4 tests
- Main: The Main workflow is executed on changes to main and compiles the games and adds the build artifacts to the job execution
- Release: The release workflow is executed on a release tag (v*). It creates a new github release and uploads the exported game to [itch.io](https://sebastianhutter.itch.io/cicd-test).

### Environment and Secrets

For the workflows to work you need to define the following action variables and action secrets

***Variables***
- GODOT_VERSION: 4.2.1-stable
- ITCHIO_USERNAME: youritchiousername
- ITCHIO_GAME_ID: yourgameidonitchio

***Secrets**

- ITCHIO_API_KEY: youritchioapikey

## Assets

All assets used in this projects are from [kenney.nl](https://kenney.nl/).
The assets are licensed under the [Creative Commons Zero, CC0](http://creativecommons.org/publicdomain/zero/1.0/) license.

- https://kenney.nl/assets/interface-sounds
- https://kenney.nl/assets/jumper-pack
