# MR/PR Guidelines

## DO
- **Explain "Why"**: Focus on the purpose and context, not just the code changes.
- **Link Issues**: Always use keywords like `Closes #123`, `Fixes #456`, or `Refs #789`.
- **Be Concise**: Use bullet points for readability.
- **Self-Review**: Review your own PR/MR before requesting others to do so.
- **Add Visuals**: Include screenshots or GIFs for any UI/UX changes.
- **Atomic PRs**: Keep changes focused on a single logical task (<400 lines preferred).

## DON'T
- **Empty Descriptions**: Never leave the description blank or with just "updates".
- **Overshare "How"**: Don't explain every single line of code; leave that for the code itself or comments.
- **Ignore Tests**: Don't open a PR/MR if tests are failing or missing for new logic.
- **Combine Features**: Don't mix independent features or refactors in the same PR/MR.
- **Hard-code Secrets**: Never include API keys, passwords, or tokens in your descriptions.

## Examples

### Good Title
- `feat: add user authentication (#123)`
- `fix: resolve memory leak in worker (#456)`
- `docs: update deployment guide`

### Bad Title
- `stuff`
- `fixed bug`
- `PR for refactor`
- `Update main`
