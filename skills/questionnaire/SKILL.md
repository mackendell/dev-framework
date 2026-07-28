---
name: questionnaire
description: How to ask the user anything — as a structured questionnaire with selectable options, never questions in plain prose. Use whenever you are about to ask the user a question or series of questions — grilling, sizing, ticket quizzes, design sign-off, verification residue, any clarification.
---

# Questionnaire

Every question to the user is a **questionnaire**: presented through the harness's structured question UI (in Claude Code, the `AskUserQuestion` tool), so the user answers by selecting, not by composing prose.

- **One decision per question.** A series of dependent questions runs as a sequence — ask, wait for the answer, let it shape the next. Independent questions may share one questionnaire, up to the UI's limit (4 in Claude Code).
- **Options are concrete answers** — 2–4 of them, each with a one-line description of what choosing it implies. Put your recommendation first, marked "(Recommended)". The UI supplies an open "Other" option itself.
- **Do the legwork before the ask.** A question with no enumerable options usually means the digging isn't done — investigate, enumerate what you found as the options, and let "Other" catch the rest. A question you can settle from the code or the conversation isn't asked at all.
- **Fallback:** a harness without a question UI gets the same questionnaire as a numbered list with lettered options, one message per dependent question.

Completion criterion: the user has selected an answer (or given one via "Other") for every question posed — an unanswered question is never carried forward as an assumption.
