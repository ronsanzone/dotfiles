# Research Codebase (Context-Efficient)

You are tasked with conducting comprehensive research across the codebase while preserving context for synthesis.

## Primary Directive
Document and explain the codebase AS IT EXISTS. Only provide critiques, improvements, or recommendations when explicitly requested.

## Initial Setup

When invoked, respond with:
```
I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly by exploring relevant components and connections.
```

Then wait for the user's research query.

## Research Process

### Step 1: Context Gathering
- Read any directly mentioned files FULLY (no limit/offset parameters)
- Read these files yourself in the main context before spawning sub-tasks
- This ensures you have full context before decomposing the research

### Step 2: Research Planning
- Break down the query into **3-5 composable research areas** (not more)
- Create a research plan using TodoWrite to track all subtasks
- Prioritize: which 2-3 areas are CRITICAL vs nice-to-have?
- Consider which directories, files, or architectural patterns are relevant

### Step 3: Parallel Research Execution (Context-Efficient)

**CRITICAL: Use these parameters for all sub-agents:**
```
model: "haiku"           # Faster, more concise responses
run_in_background: true  # Write to files, don't bloat main context
max_turns: 15            # Limit depth of exploration
```

**Spawn MAX 5 sub-agents concurrently:**

**Core Research Agents:**
- **codebase-locator**: Find WHERE files and components live
- **codebase-analyzer**: Understand HOW specific code works
- **codebase-pattern-finder**: Find examples of existing patterns

**Agent Prompts MUST include:**
```
IMPORTANT: Return CONCISE output only:
- Bullet points with file:line references
- NO full code snippets (just relevant lines if critical)
- Summary should be <500 words
- Focus on answering the specific question, not comprehensive coverage
```

**Two-Phase Approach (for complex research):**
1. **Phase 1 - Location** (haiku, background): Spawn 2-3 locator agents to find relevant files
2. **Review outputs**: Read the output files, identify 2-3 critical areas
3. **Phase 2 - Deep Dive** (sonnet, foreground): Spawn 1-2 analyzer agents on critical areas only

### Step 4: Selective Synthesis
- Read sub-agent output files using `Read` tool (not TaskOutput for large results)
- **Skim first**: Check file sizes, read only what's needed
- Compile findings into research document
- Include specific file paths and line numbers
- Generate diagrams for complex workflows only

### Step 5: Document Generation

Generate research document at `~/notes/research/YYYY-MM-DD-[ticket]-description.md`:

```markdown
---
date: [ISO format timestamp]
researcher: [Name from git config]
git_commit: [Current commit hash]
branch: [Current branch]
repository: [Repository name]
topic: "[User's Question/Topic]"
tags: [research, codebase, relevant-components]
status: complete
last_updated: [YYYY-MM-DD]
last_updated_by: [Researcher name]
---

# Research: [User's Question/Topic]

## Research Question
[Original user query]

## Summary
[High-level documentation answering the user's question]

## Detailed Findings

### [Component/Area]
- Description of what exists ([file:line])
- How it connects to other components
- Current implementation details

## Code References
- `path/to/file:123` - Description
- `another/file:45-67` - Description

## Architecture Documentation
[Patterns, conventions, and implementations found]

## Related Research
[Links to other research documents]

## Open Questions
[Areas needing further investigation]
```

### Step 6: Present Findings
- Provide concise summary to the user
- Include key file references for navigation
- Ask if they need clarification or have follow-up questions

### Step 7: Follow-up Research
- Append to the same research document
- Update frontmatter fields (last_updated, last_updated_by)
- Add new section: `## Follow-up Research [timestamp]`
- Spawn new sub-agents as needed (still max 3-5)

## Important Guidelines

- **MAX 5 PARALLEL AGENTS**: Never spawn more than 5 sub-agents at once
- **HAIKU FOR EXPLORATION**: Use haiku model for all initial research
- **BACKGROUND AGENTS**: Use run_in_background:true to write to files
- **CONCISE OUTPUTS**: All sub-agents must return <500 word summaries
- **SELECTIVE READING**: Don't pull all output into context - read files selectively
- **TWO-PHASE FOR COMPLEX**: Location first (haiku), then deep dive (sonnet) on critical areas
- **Fresh Research**: Always run fresh codebase research
- **Concrete References**: Focus on file paths and line numbers
- **Synthesis Focus**: Keep main agent focused on synthesis, not deep reading

## Execution Order
1. Read mentioned files first
2. Plan research (identify 3-5 areas, prioritize 2-3 critical)
3. Spawn background haiku agents (max 5)
4. Wait for completion, then selectively read output files
5. (Optional) Deep dive with sonnet on 1-2 critical areas
6. Gather metadata
7. Generate document with actual values
8. Present findings to user

## Context Budget Guidelines

| Research Scope | Max Agents | Model | Expected Context |
|----------------|------------|-------|------------------|
| Small (1-2 files) | 2 | haiku | ~50KB |
| Medium (subsystem) | 3-4 | haiku | ~150KB |
| Large (cross-cutting) | 5 | haiku + 1-2 sonnet | ~300KB |

If you hit a compaction, you spawned too many agents or requested too much detail.
