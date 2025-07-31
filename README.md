# Indent PR Review Action

A GitHub Action that runs Indent AI code reviews on your pull requests.

## Usage

```yaml
name: Indent PR Review

on:
  pull_request:
    types: [opened, synchronize, reopened]

concurrency:
  group: indent-pr-review-${{ github.event.number }}
  cancel-in-progress: true

jobs:
  indent:
    runs-on: ubuntu-latest
    timeout-minutes: 30
    steps:
      - uses: indent-com/pr-review-action@beta
        with:
          indent-api-key: ${{ secrets.PR_REVIEW_INDENT_API_KEY }}
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `indent-api-key` | Indent API key for authentication | Yes | - |
| `workflow-id` | Indent workflow ID to run | No | `indent_pr_review` |
| `python-version` | Python version to use | No | `3.12.2` |

## Optional: Label-based triggering

To only run the workflow when a PR is labeled with 'indent', modify your workflow:

```yaml
name: Indent PR Review

on:
  pull_request:
    types: [opened, synchronize, reopened, labeled]

concurrency:
  group: indent-pr-review-${{ github.event.number }}
  cancel-in-progress: true

jobs:
  indent:
    if: contains(github.event.pull_request.labels.*.name, 'indent')
    runs-on: ubuntu-latest
    timeout-minutes: 30
    steps:
      - uses: indent-com/pr-review-action@beta
        with:
          indent-api-key: ${{ secrets.PR_REVIEW_INDENT_API_KEY }}
```

## Setup

1. Get your Indent API key from your Indent dashboard
2. Add it as a repository secret named `PR_REVIEW_INDENT_API_KEY`
3. Create the workflow file as shown above in `.github/workflows/indent_pr_review.yaml`

## License

MIT
