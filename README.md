# VSCode + Claude Demo

Project overview and setup instructions for the Demo workshop.

## Team Assignments

| Topic | Owner |
|-------|-------|
| AWS CDK Scaffold | Anu Raj |
| EKS Cluster | Thiago Reboto |
| Code Review via AI Agent | Fernando Pedraza |
| Multi Agent Workflow | Arley |

## Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/solvdinc/agentic-vscode-pilot.git
cd agentic-vscode-pilot
```

### 2. Create branch in this format: `feature/<githubID>-<demo name>`
Example: 
```bash
git checkout -b feature/gihaza-auroramigration
```

### 3. Make necessary changes and update the README file accordingly

### 4. Test your demo

### 5. Verify CDK synth works
```bash
npx cdk synth
```

### 6. Push your branch to repo
```bash
git push origin feature/<your-branch-name>
```

## Branching Rules

- **Never** push directly to `main`
- All work goes on a feature branch: `feature/<githubID>-<your-topic>`
- The CI pipeline runs automatically on push to `feature/**` or `feat/**`
- If the pipeline passes, the branch is automatically merged to main
- If your branch is behind main, the pipeline will fail with the list of missing commits and instructions to rebase

## Working on Your Topic

Each team member owns one branch. See [docs/onboarding.md](docs/onboarding.md) for more detail.

---

**Repository:** [github.com/solvdinc/agentic-vscode-pilot](https://github.com/solvdinc/agentic-vscode-pilot)