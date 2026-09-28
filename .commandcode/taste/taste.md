# User Taste

## Communication
- Writes to the assistant in Persian (Farsi); respond in Persian. Confidence: 0.8

## Workflow
- After a fix is confirmed working, wants a proactive scan of the whole project for further improvements, with the found items prioritized (e.g., by user impact) and larger/riskier changes offered for approval instead of applied unilaterally. Confidence: 0.6
- Expects fixes to be verified before hand-off: rebuild the project (use a clean rebuild when new source files are added, since incremental builds can skip them), and smoke-test or add a quick unit test for tricky logic (e.g., diff vendored/generated tables against the upstream source). When smoke-testing the server, run it on a separate port from the user's live instance (e.g., 5902 vs 5901, with -viewonly) and stop it cleanly with SIGTERM afterwards. Confidence: 0.7
- Directs work toward performance (FPS/bandwidth) as the top goal for the macVNC → Raspberry Pi setup; after fixes landed, immediately asked for more speed-focused tasks and expected the highest-impact performance fix to be applied (dirty rects). Confidence: 0.6
- Verifies fixes manually on real hardware (macVNC server on the Mac, vncviewer from a Raspberry Pi); close out with concrete rebuild/run commands the user can run themselves. Confidence: 0.7
