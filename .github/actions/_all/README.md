# _all actions

Actions in this folder can be exuected os independent.
The goal was to use these jobs to run the tests and builds as matrix jobs.

Unfortunately, outputs in matrix jobs behave differently and only the latest output
is available to all jobs which makes the use of matrix impossible as the "godot-bin" output is dependent
on the os!

See:
- https://github.com/orgs/community/discussions/17245
- https://github.com/actions/runner/pull/2477#issuecomment-1501003600
